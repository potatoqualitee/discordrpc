param (
    $Show = "None"
)

Write-Host "Starting Tests" -ForegroundColor Green
Write-Output "Loading constants"
. "$PSScriptRoot\constants.ps1"

Write-Output "Importing Module"
Import-Module "$PSScriptRoot\..\discordrpc.psd1"

$totalFailed = 0
$totalRun = 0

$testresults = @()

Write-Output "Proceeding with individual tests"
foreach ($file in (Get-ChildItem "$PSScriptRoot\public" -Recurse -File -Filter "*.Tests.ps1")) {
    Write-Output "Executing $($file.Name)"
    $results = Invoke-Pester -Script $file.FullName -PassThru
    foreach ($result in $results) {
        $totalRun += $result.TotalCount
        $totalFailed += $result.FailedCount
        $result.TestResult | Where-Object { -not $_.Passed } | ForEach-Object {
            $name = $_.Name
            $testresults += [pscustomobject]@{
                Describe = $_.Describe
                Context  = $_.Context
                Name     = "It $name"
                Result   = $_.Result
                Message  = $_.FailureMessage
            }
        }
    }
}

$testresults | Sort-Object Describe, Context, Name, Result, Message | Format-List

if ($totalFailed -eq 0) { Write-Output "All $totalRun tests executed without failure" }
else { Write-Output "$totalFailed tests out of $totalRun tests failed" }

if ($totalFailed -gt 0) {
    throw "$totalFailed / $totalRun tests failed"
}