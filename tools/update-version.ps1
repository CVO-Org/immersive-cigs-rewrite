param (
    [string]$Version
)

# Hardcoded path to script_version.hpp
$filePath = "addons/main/script_version.hpp"

# Take MAJOR.MINOR.PATCH from the tag - ignores a leading "v" and any suffix like ".RC.1" or "-rc1"
if ($Version -notmatch '^v?(\d+)\.(\d+)\.(\d+)') {
    Write-Error "Invalid version format: $Version"
    exit 1
}

$major = $Matches[1]
$minor = $Matches[2]
$patch = $Matches[3]

Write-Host "Updating $filePath → MAJOR=$major, MINOR=$minor, PATCH=$patch"

$content = Get-Content $filePath

$content = $content -replace '#define MAJOR .*', "#define MAJOR $major"
$content = $content -replace '#define MINOR .*', "#define MINOR $minor"
$content = $content -replace '#define PATCH .*', "#define PATCH $patch"

Set-Content -Path $filePath -Value $content -Encoding UTF8
