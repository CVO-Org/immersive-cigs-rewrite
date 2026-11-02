<#
.SYNOPSIS
    Creates a new addon in addons\ from the shared addon template.

.DESCRIPTION
    Downloads the addon template (the "addon" folder of CVO-Org/ZRN-Mod-Template-Default-Addon
    by default), so every mod starts from the same default.
    Pass -TemplateDir to use a local template folder instead.

    The template's placeholders are filled in:
        {{MAINPREFIX}}       from .hemtt\project.toml
        {{PREFIX}}           from .hemtt\project.toml
        {{ADDON}}            -Name
        {{ADDON_BEAUTIFIED}} -DisplayName
        {{AUTHOR}}           -Author

    Any parameter that is not passed is asked for. Nothing outside the new addon folder is touched.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File tools\new-addon.ps1

.EXAMPLE
    pwsh tools/new-addon.ps1 -Name my_addon -DisplayName "My Addon" -Author "Zorn"

.EXAMPLE
    pwsh tools/new-addon.ps1 -TemplateDir ../ZRN-Mod-Template-Default-Addon/addon
#>
param (
    [string]$Name,
    [string]$DisplayName,
    [string]$Author,
    [string]$TemplateRepo = "CVO-Org/ZRN-Mod-Template-Default-Addon",
    [string]$TemplateRef  = "main",
    [string]$TemplateDir
)

$ErrorActionPreference = "Stop"

$templateSubPath = "addon"

$repoRoot     = Split-Path -Parent $PSScriptRoot
$projectToml  = Join-Path $repoRoot ".hemtt/project.toml"
$addonsDir    = Join-Path $repoRoot "addons"
$utf8NoBom    = New-Object System.Text.UTF8Encoding $false
$interactive  = -not ($PSBoundParameters.ContainsKey("Name") -and $PSBoundParameters.ContainsKey("DisplayName") -and $PSBoundParameters.ContainsKey("Author"))

function Stop-WithError([string]$message) {
    Write-Host "ERROR: $message" -ForegroundColor Red
    exit 1
}

function Read-Value([string]$prompt, [string]$default) {
    $suffix = if ($default) { " [$default]" } else { "" }
    $value = Read-Host "$prompt$suffix"
    if ([string]::IsNullOrWhiteSpace($value)) { return $default }
    return $value.Trim()
}

function Get-TomlValue([string]$content, [string]$key) {
    $match = [regex]::Match($content, "(?m)^\s*$key\s*=\s*""([^""]*)""")
    if ($match.Success) { return $match.Groups[1].Value }
    return $null
}

# --- Project prefixes ---
if ($TemplateDir -and -not (Test-Path $TemplateDir -PathType Container)) { Stop-WithError "Template not found: $TemplateDir" }
if (-not (Test-Path $projectToml)) { Stop-WithError "Project file not found: $projectToml" }

$toml       = [System.IO.File]::ReadAllText($projectToml)
$mainPrefix = Get-TomlValue $toml "mainprefix"
$prefix     = Get-TomlValue $toml "prefix"

if (-not $mainPrefix -or -not $prefix) { Stop-WithError "Could not read 'mainprefix' and 'prefix' from .hemtt\project.toml" }
if ($mainPrefix.Contains("~") -or $prefix.Contains("~")) {
    Stop-WithError "The mod is not set up yet - replace the MAINPREFIX and PREFIX placeholders first (see README, 'Once Per Mod')"
}

# --- Addon name ---
$existing = @(Get-ChildItem -Path $addonsDir -Directory -ErrorAction SilentlyContinue | ForEach-Object { $_.Name })

while ($true) {
    if (-not $Name) { $Name = Read-Value "Addon name (lowercase, e.g. common or my_addon)" "" }

    $problem = $null
    if (-not $Name)                              { $problem = "The addon name can't be empty" }
    elseif ($Name -cnotmatch '^[a-z][a-z0-9_]*$') { $problem = "Only lowercase letters, digits and _ are allowed, starting with a letter" }
    elseif ($existing -contains $Name)           { $problem = "addons\$Name already exists" }

    if (-not $problem) { break }
    if (-not $interactive) { Stop-WithError $problem }
    Write-Host $problem -ForegroundColor Yellow
    $Name = $null
}

# --- Display name and author ---
if (-not $PSBoundParameters.ContainsKey("DisplayName")) {
    $suggested = (($Name -split '_' | Where-Object { $_ } | ForEach-Object { $_.Substring(0, 1).ToUpper() + $_.Substring(1) }) -join ' ')
    $DisplayName = Read-Value "Display name" $suggested
}
if (-not $PSBoundParameters.ContainsKey("Author")) {
    $suggested = $null
    try { $suggested = (git -C $repoRoot config user.name 2>$null) } catch { }
    $Author = Read-Value "Author" $suggested
}
if (-not $DisplayName) { Stop-WithError "The display name can't be empty" }
if (-not $Author)      { Stop-WithError "The author can't be empty" }

$tokens = [ordered]@{
    "{{MAINPREFIX}}"       = $mainPrefix
    "{{PREFIX}}"           = $prefix
    "{{ADDON_BEAUTIFIED}}" = $DisplayName
    "{{ADDON}}"            = $Name
    "{{AUTHOR}}"           = $Author
}

$target = Join-Path $addonsDir $Name
$source = if ($TemplateDir) { $TemplateDir } else { "github.com/$TemplateRepo ($TemplateRef)" }

Write-Host ""
Write-Host "Creating addons\$Name"
Write-Host "  Template     : $source"
Write-Host "  PBO prefix   : $mainPrefix\$prefix\addons\$Name"
Write-Host "  Display name : $DisplayName"
Write-Host "  Author       : $Author"

if ($interactive) {
    $confirm = Read-Host "Continue? [Y/n]"
    if ($confirm -and $confirm -notmatch '^(y|yes)$') { Write-Host "Aborted."; exit 0 }
}

# --- Copy and fill in ---
# Built in a temp folder first, so a failure never leaves a half-filled addon behind
$work    = Join-Path ([System.IO.Path]::GetTempPath()) ("new-addon-" + [guid]::NewGuid())
$staging = Join-Path $work "addon"

try {
    New-Item -ItemType Directory -Path $work | Out-Null

    if ($TemplateDir) {
        Copy-Item -Path $TemplateDir -Destination $staging -Recurse
    } else {
        # Windows PowerShell 5.1 does not enable TLS 1.2 by default
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

        $zip = Join-Path $work "template.zip"
        $url = "https://codeload.github.com/$TemplateRepo/zip/$TemplateRef"
        Write-Host "Downloading $url"
        try {
            Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
        } catch {
            Stop-WithError "Could not download the template from $url - $($_.Exception.Message)"
        }

        $extracted = Join-Path $work "repo"
        Expand-Archive -Path $zip -DestinationPath $extracted
        # The zip contains a single "<repo>-<ref>" folder
        $remoteTemplate = Get-ChildItem -Path $extracted -Directory | Select-Object -First 1 | ForEach-Object { Join-Path $_.FullName $templateSubPath }
        if (-not $remoteTemplate -or -not (Test-Path $remoteTemplate -PathType Container)) {
            Stop-WithError "$TemplateRepo ($TemplateRef) has no $templateSubPath folder"
        }
        Move-Item -Path $remoteTemplate -Destination $staging
    }

    foreach ($file in Get-ChildItem -Path $staging -Recurse -File -Force) {
        $content = [System.IO.File]::ReadAllText($file.FullName)
        $updated = $content
        foreach ($token in $tokens.Keys) { $updated = $updated.Replace($token, $tokens[$token]) }
        # GitHub's zip has LF line endings, .editorconfig wants CRLF
        $updated = [regex]::Replace($updated, "\r?\n", "`r`n")
        if ($updated -ne $content) { [System.IO.File]::WriteAllText($file.FullName, $updated, $utf8NoBom) }
    }

    # Placeholders in file and folder names, deepest first so parent paths stay valid
    $named = Get-ChildItem -Path $staging -Recurse -Force | Where-Object { $_.Name.Contains("{{") } | Sort-Object { $_.FullName.Length } -Descending
    foreach ($item in $named) {
        $newName = $item.Name
        foreach ($token in $tokens.Keys) { $newName = $newName.Replace($token, $tokens[$token]) }
        if ($newName -ne $item.Name) { Rename-Item -LiteralPath $item.FullName -NewName $newName }
    }

    $leftoverName = Get-ChildItem -Path $staging -Recurse -Force | Where-Object { $_.Name -match '\{\{[A-Z_]+\}\}' } | Select-Object -First 1
    if ($leftoverName) { Stop-WithError "Unknown placeholder left in the name of $($leftoverName.FullName.Substring($staging.Length + 1))" }

    $leftover = Get-ChildItem -Path $staging -Recurse -File -Force | Select-String -Pattern '\{\{[A-Z_]+\}\}' -List
    if ($leftover) { Stop-WithError "Unknown placeholder left in $($leftover[0].Path): $($leftover[0].Matches[0].Value)" }

    if (-not (Test-Path $addonsDir)) { New-Item -ItemType Directory -Path $addonsDir | Out-Null }
    Move-Item -Path $staging -Destination $target
}
finally {
    if (Test-Path $work) { Remove-Item -Path $work -Recurse -Force }
}

Write-Host ""
Write-Host "Created addons\$Name" -ForegroundColor Green
Write-Host "Next: update config.cpp (requiredAddons, units, weapons) and remove fn_example once you add your own functions."
