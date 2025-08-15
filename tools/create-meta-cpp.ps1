param (
    [string]$FilePath,
    [string]$PublishedId,
    [string]$ModName
)

# Generate timestamp
$ticks = [DateTime]::UtcNow.Ticks

# Build the file content without comments
$content = @"
protocole = 1;
publishedid = $PublishedId;
name = "$ModName";
timestamp = $ticks;
"@

# Create or overwrite the file
Set-Content -Path $FilePath -Value $content -Encoding UTF8

Write-Host "meta.cpp created/overwritten at $FilePath"
