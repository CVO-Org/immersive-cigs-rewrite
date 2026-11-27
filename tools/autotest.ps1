<#
.SYNOPSIS
    Runs the autotest mission unattended and reports the result from the RPT.

.DESCRIPTION
    Starts `hemtt launch <profiles> autotest`. The autotest mission (.hemtt\missions\autotest.VR) starts its preview by
    itself, runs every suite, and the game quits by itself afterwards - no input needed.
    This script waits for the game to quit (or closes it after -TimeoutMinutes), then reads this run's RPT:
      - the test lines ("[ T1.02    ] ...", "[ AUTOTEST ] ..."; without -Full only the lines of tests that did not pass),
      - script errors ("Error in expression"),
      - "Updating base class" lines from this mod's addons (a class declared with a wrong parent).
    Exit code 0 when the DONE line reports 0 failed tests and nothing above was found, else 1.

    Several profiles load together in one game (hemtt launch merges them, left to right). The mission profile goes
    last, so its mission wins.

.EXAMPLE
    .\tools\autotest.ps1
    .\tools\autotest.ps1 default -Full
    .\tools\autotest.ps1 rhs -Mission autotest_altis
    .\tools\autotest.ps1 -Quick -Grep '[mymod][debug]'
    .\tools\autotest.ps1 -Rpt last
#>
param(
    # hemtt launch profiles (the modset). Default: the default profile.
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]] $Profiles = @('default'),
    # The launch profile that switches to the autotest mission, chained last.
    [string] $Mission = 'autotest',
    # Close the game after it has run this many minutes (the build before it doesn't count).
    [int] $TimeoutMinutes = 15,
    # Print every test line, not only the lines of tests that did not pass.
    [switch] $Full,
    # Extra RPT prefixes to print in full (e.g. '[mymod][debug]').
    [string[]] $Grep = @(),
    # Skip the build, launch the last built version (hemtt launch -Q).
    [switch] $Quick,
    # Don't launch: read this RPT file again ('last' = the newest RPT).
    [string] $Rpt = ''
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$rptDir = Join-Path $env:LOCALAPPDATA 'Arma 3'
$prefix = (Select-String -Path (Join-Path $root '.hemtt\project.toml') -Pattern '^prefix\s*=\s*"([^"]+)"').Matches[0].Groups[1].Value

if ($Rpt) {
    $rptFile = if ($Rpt -eq 'last') { Get-ChildItem $rptDir -Filter 'arma3_x64_*.rpt' | Sort-Object LastWriteTime | Select-Object -Last 1 } else { Get-Item $Rpt }
} else {
    if (Get-Process arma3_x64 -ErrorAction SilentlyContinue) { throw 'Arma 3 is already running - close it first.' }

    $start = Get-Date
    $launchArgs = @('launch') + $Profiles + @($Mission)
    if ($Quick) { $launchArgs += '-Q' }
    Write-Host "hemtt $($launchArgs -join ' ')"
    Push-Location $root
    # 'Continue' here: the game writes to stderr through hemtt, and when this script's output is redirected (*> file),
    # Windows PowerShell turns each stderr line into an error record that 'Stop' would make fatal
    $ErrorActionPreference = 'Continue'
    try { & hemtt @launchArgs; if ($LASTEXITCODE -ne 0) { throw "hemtt launch failed ($LASTEXITCODE)" } }
    finally { Pop-Location; $ErrorActionPreference = 'Stop' }

    # Wait for the game to start, then to quit. The timeout counts from the game's start.
    # hemtt launch may return before the game is up, or only after it has quit: then a new RPT says it did run.
    $ranAlready = { Get-ChildItem $rptDir -Filter 'arma3_x64_*.rpt' | Where-Object LastWriteTime -gt $start | Select-Object -First 1 }
    $arma = Get-Process arma3_x64 -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $arma -and (& $ranAlready)) {
        Write-Host 'The game has already quit'
    } else {
        $startWait = Get-Date
        while (-not $arma -and (Get-Date) -lt $startWait.AddMinutes(3)) { Start-Sleep 2; $arma = Get-Process arma3_x64 -ErrorAction SilentlyContinue | Select-Object -First 1 }
        if (-not $arma) { throw 'Arma 3 did not start.' }
        Write-Host "Game running (pid $($arma.Id)), waiting for it to quit (timeout $TimeoutMinutes min)"
        if (-not $arma.WaitForExit($TimeoutMinutes * 60 * 1000)) { Write-Warning 'Timeout - closing the game'; Stop-Process -Id $arma.Id -Force }
    }

    # The RPT of this run
    $rptFile = Get-ChildItem $rptDir -Filter 'arma3_x64_*.rpt' | Where-Object LastWriteTime -gt $start | Sort-Object LastWriteTime | Select-Object -Last 1
    if (-not $rptFile) { throw "No RPT newer than $start in $rptDir" }
}

$lines = Get-Content $rptFile.FullName
Write-Host "RPT: $($rptFile.FullName)`n"

$problems = 0

# Walk the RPT in order: the test lines ("[ T1.02    ] ...", "[ AUTOTEST ] ..."; the RPT's timestamp cut off), and
# the script errors - SQF logs most errors and carries on, so a test with an error may still report PASSED.
# Each error is put on the test that was running when it was logged.
$headPattern = '\[ (T\d+\.\d+|AUTOTEST) *\] '
$test = [System.Collections.Generic.List[string]]::new()
$errors = [System.Collections.Generic.List[string]]::new()
$errorIds = @{}
$current = $null
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match $headPattern) {
        $text = $line.Substring($line.IndexOf($Matches[0]))
        $test.Add($text)
        if ($text -match '^\[ (T\d+\.\d+) *\] \[ BEGIN') { $current = $Matches[1] }
        elseif ($text -match '^\[ (T\d+\.\d+) *\] \[ END') { $current = $null }
    } elseif ($line -match 'Error in expression') {
        $where = if ($current) { $current } else { 'outside a test' }
        if ($current) {
            $errorIds[$current] = $true
            $test.Add(('[ {0,-8} ]     ERROR script error, see "Script errors" below' -f $current))
        }
        $errors.Add("in ${where}:`n" + ($lines[$i..([Math]::Min($i + 6, $lines.Count - 1))] -join "`n") + "`n")
    }
}
$problems += $errors.Count

# Passed: the END line says PASSED and no script error was logged during the test
$endPassed = @($test | ForEach-Object { if ($_ -match '^\[ (T\d+\.\d+) *\] \[ END *\] Result: PASSED') { $Matches[1] } })
$passedIds = @($endPassed | Where-Object { -not $errorIds.ContainsKey($_) })
$erroredPassed = $endPassed.Count - $passedIds.Count

# Without -Full: the AUTOTEST lines, and every line of a test that did not pass (or never reached its END line)
$shown = if ($Full) { $test } else {
    $test | Where-Object { $_ -notmatch '^\[ (T\d+\.\d+) *\] ' -or $passedIds -notcontains $Matches[1] }
}
$shown

foreach ($p in $Grep) {
    Write-Host "`n$p"
    $lines | Where-Object { $_.Contains($p) } | ForEach-Object { $_.Substring($_.IndexOf($p) + $p.Length).TrimStart() }
}

# Wrong parents: the engine rebases a class declared with another parent than it had
$rebased = @($lines | Where-Object { $_ -match 'Updating base class' -and $_ -match [regex]::Escape($prefix) })
if ($rebased) { $problems += $rebased.Count; Write-Host "`nUpdating base class (wrong parent in a $prefix addon):"; $rebased }

# Script errors, with the lines after them
if ($errors.Count) { Write-Host "`nScript errors:"; $errors }

$donePattern = '\[ DONE *\] (\d+) / (\d+) successful - failed: (\d+) - skipped: (\d+)'
$done = $test | Where-Object { $_ -match $donePattern } | Select-Object -Last 1

Write-Host ''
if (-not $done) { Write-Host 'Verdict: FAILED - the tests did not finish (no DONE line)' -ForegroundColor Red; exit 1 }
$null = $done -match $donePattern
# a test that reported PASSED but logged a script error counts as failed
$successful = [int]$Matches[1] - $erroredPassed
$failedTests = [int]$Matches[3] + $erroredPassed
$summary = "$successful / $($Matches[2]) successful, $failedTests failed, $($Matches[4]) skipped, $problems RPT problems"
if ($failedTests -gt 0 -or [int]$Matches[2] -eq 0 -or $problems -gt 0) {
    Write-Host "Verdict: FAILED - $summary" -ForegroundColor Red; exit 1
}
Write-Host "Verdict: PASSED - $summary" -ForegroundColor Green
exit 0
