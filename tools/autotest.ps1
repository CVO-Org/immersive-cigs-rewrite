<#
.SYNOPSIS
    Runs the test mission (.hemtt\missions\test.VR) unattended and reports the results from the RPT.

.DESCRIPTION
    Builds and starts the game through `hemtt launch <profiles>` with Arma's -autotest parameter: the game plays the
    test mission, which runs every test in init.sqf and ends as END1 (all passed) or LOSER (a test failed), then quits.
    Afterwards the RPT is searched for:
      - the test lines ("[cigs][test]"; only FAIL lines and summaries unless -Full),
      - "Updating base class" lines from this mod's addons: a class declared with a wrong parent (OFFICER_CIGARS),
      - script errors.
    Exit code 0 when the mission reported 0 failures and nothing above was found, else 1.

.EXAMPLE
    .\tools\autotest.ps1 3cb
    .\tools\autotest.ps1 rhs -Full
    .\tools\autotest.ps1 terrains -Grep '[cigs][terrains]'
#>
param(
    # hemtt launch profiles, e.g. 3cb or rhs. Default: the default profile.
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]] $Profiles = @('default'),
    # Give up and close the game after it has run this many minutes (the build before it doesn't count).
    [int] $TimeoutMinutes = 30,
    # Print every test line, not only FAIL lines and summaries.
    [switch] $Full,
    # Extra RPT prefix to print in full (e.g. '[cigs][terrains]').
    [string[]] $Grep = @(),
    # Skip the build, launch the last built version (hemtt launch -Q).
    [switch] $Quick
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$mission = Join-Path $root '.hemtt\missions\test.VR'
$outDir = Join-Path $root '.hemttout\autotest'
$cfg = Join-Path $outDir 'autotest.cfg'
$rptDir = Join-Path $env:LOCALAPPDATA 'Arma 3'

if (Get-Process arma3_x64 -ErrorAction SilentlyContinue) { throw 'Arma 3 is already running - close it first.' }

New-Item -ItemType Directory -Force $outDir | Out-Null
@"
class TestMissions {
    class CigsTest {
        campaign = "";
        mission = "$mission";
    };
};
"@ | Set-Content -Encoding ascii $cfg

$start = Get-Date
$launchArgs = @('launch') + $Profiles
if ($Quick) { $launchArgs += '-Q' }
$launchArgs += @('--', "-autotest=$cfg")
Write-Host "hemtt $($launchArgs -join ' ')"
Push-Location $root
# 'Continue' here: the game writes to stderr through hemtt, and when this script's output is redirected (*> file),
# Windows PowerShell turns each stderr line into an error record that 'Stop' would make fatal
$ErrorActionPreference = 'Continue'
try { & hemtt @launchArgs; if ($LASTEXITCODE -ne 0) { throw "hemtt launch failed ($LASTEXITCODE)" } }
finally { Pop-Location; $ErrorActionPreference = 'Stop' }

# Wait for the game to start, then to quit. The timeout counts from the game's start.
$arma = $null
$startWait = Get-Date
while (-not $arma -and (Get-Date) -lt $startWait.AddMinutes(3)) { Start-Sleep 2; $arma = Get-Process arma3_x64 -ErrorAction SilentlyContinue | Select-Object -First 1 }
if (-not $arma) { throw 'Arma 3 did not start.' }
$deadline = (Get-Date).AddMinutes($TimeoutMinutes)
Write-Host "Game running (pid $($arma.Id)), waiting for the autotest to finish (timeout $TimeoutMinutes min)"
$timedOut = -not $arma.WaitForExit([int]([Math]::Max(0, ($deadline - (Get-Date)).TotalMilliseconds)))
if ($timedOut) { Write-Warning 'Timeout - closing the game'; Stop-Process -Id $arma.Id -Force }

# The RPT of this run
$rpt = Get-ChildItem $rptDir -Filter 'arma3_x64_*.rpt' | Where-Object LastWriteTime -gt $start | Sort-Object LastWriteTime | Select-Object -Last 1
if (-not $rpt) { throw "No RPT newer than $start in $rptDir" }
$lines = Get-Content $rpt.FullName
Write-Host "RPT: $($rpt.FullName)`n"

$problems = 0

# Test lines
$test = @($lines | Where-Object { $_.Contains('[cigs][test]') })
# The game may start the mission more than once (a start cut short, then a full one): only the last pass counts
$lastPass = [Array]::FindLastIndex([string[]]$test, [Predicate[string]] { param($l) $l -match '==== \w+ \(1/\d+\) ====' })
if ($lastPass -gt 0) { $test = $test[$lastPass..($test.Count - 1)] }
$summaryAt = [Array]::FindLastIndex([string[]]@($test), [Predicate[string]] { param($l) $l.Contains('==== Summary ====') })
$shown = if ($Full) { $test } else {
    for ($i = 0; $i -lt @($test).Count; $i++) {
        $l = @($test)[$i]
        if (($summaryAt -ge 0 -and $i -ge $summaryAt) -or $l -match 'FAIL|failed|passed|====|not allowed') { $l }
    }
}
$shown | ForEach-Object { $_ -replace '^.*?\[cigs\]\[test\] ', '' }

foreach ($prefix in $Grep) {
    Write-Host "`n$prefix"
    $lines | Where-Object { $_.Contains($prefix) } | ForEach-Object { $_.Substring($_.IndexOf($prefix) + $prefix.Length).TrimStart() }
}

# Wrong parents: the engine rebases a class declared with another parent than it had
$rebased = $lines | Where-Object { $_ -match 'Updating base class' -and $_ -match 'cigs' }
if ($rebased) { $problems += @($rebased).Count; Write-Host "`nUpdating base class (wrong parent in a cigs addon):"; $rebased }

# Script errors
$errors = for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i] -match 'Error in expression') { $lines[$i..([Math]::Min($i + 6, $lines.Count - 1))] -join "`n"; '' } }
if ($errors) { $problems += @($errors | Where-Object { $_ }).Count; Write-Host "`nScript errors:"; $errors }

$done = $lines | Where-Object { $_ -match '\[cigs\]\[test\] ---- Autotest done: (\d+) failed' } | Select-Object -Last 1
$failed = if ($done -and $done -match 'done: (\d+) failed') { [int]$Matches[1] } else { -1 }
$autotest = ($lines | Where-Object { $_ -match '<AutoTest result' }) -join ' '

Write-Host ''
if ($failed -lt 0) { Write-Host 'RESULT: the tests did not finish' -ForegroundColor Red; exit 1 }
if ($failed -gt 0 -or $problems -gt 0 -or $autotest) {
    Write-Host "RESULT: FAILED - $failed test failures, $problems RPT problems $autotest" -ForegroundColor Red; exit 1
}
Write-Host 'RESULT: PASSED' -ForegroundColor Green
exit 0
