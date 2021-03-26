param (
    $Show = "None"
)

Write-Host "Starting Tests" -ForegroundColor Green
Write-PSFMessage -Level Important -Message "Loading constants"
. "$PSScriptRoot\constants.ps1"

Write-PSFMessage -Level Important -Message "Importing Module"
Import-Module "$PSScriptRoot\..\discordprc.psd1"

$totalFailed = 0
$totalRun = 0

$testresults = @()

Write-PSFMessage -Level Important -Message "Proceeding with individual tests"
foreach ($file in (Get-ChildItem "$PSScriptRoot\public" -Recurse -File -Filter "*.Tests.ps1")) {
    Write-PSFMessage -Level Important -Message "Executing $($file.Name)"
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

if ($totalFailed -eq 0) { Write-PSFMessage -Level Critical -Message "All <c='em'>$totalRun</c> tests executed without failure" }
else { Write-PSFMessage -Level Critical -Message "<c='em'>$totalFailed tests</c> out of <c='sub'>$totalRun</c> tests failed" }

if ($totalFailed -gt 0) {
    throw "$totalFailed / $totalRun tests failed"
}