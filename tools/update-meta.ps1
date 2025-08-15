param (
    [string]$FilePath,
    [string]$PublishedId,
    [string]$ModName
)

$content = Get-Content $FilePath -Raw
$ticks = [DateTime]::UtcNow.Ticks

# Escape quotes in name if needed
$escapedName = $ModName -replace '"', '\"'

# Replace values
$content = $content -replace 'publishedid\s*=\s*\d+;', "publishedid = $PublishedId;"
$content = $content -replace 'name\s*=\s*".*?";', "name = `"$escapedName`";"
$content = $content -replace 'timestamp\s*=\s*(\d*)\s*;', "timestamp = $ticks;"

# Save updated file as UTF-8
Set-Content -Path $FilePath -Value $content -Encoding UTF8
