param (
    [string]$Version
)

# Hardcoded path to script_version.hpp
$filePath = "addons/main/script_version.hpp"

# Strip leading "v" and ignore any ".RC.x"
$cleanVersion = $Version -replace '^v', '' -replace '\.RC\..*$', ''
$parts = $cleanVersion.Split('.')

if ($parts.Count -lt 3) {
    Write-Error "Invalid version format: $Version"
    exit 1
}

$major = $parts[0]
$minor = $parts[1]
$patch = $parts[2]

Write-Host "Updating $filePath → MAJOR=$major, MINOR=$minor, PATCH=$patch"

$content = Get-Content $filePath

$content = $content -replace '#define MAJOR .*', "#define MAJOR $major"
$content = $content -replace '#define MINOR .*', "#define MINOR $minor"
$content = $content -replace '#define PATCH .*', "#define PATCH $patch"

Set-Content -Path $filePath -Value $content -Encoding UTF8
