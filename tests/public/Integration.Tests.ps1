Write-Host -Object "Running $PSCommandpath" -ForegroundColor Cyan
. "$PSScriptRoot\..\constants.ps1"


Describe "Integration Tests" -Tag "IntegrationTests" {
    BeforeEach {
        Write-Output -Message "Next test"
    }
    Context "New-DisAsset" {
        It "Creates an asset object" {
            $results = New-DisAsset
            $results | Should -Not -BeNullorEmpty
        }
    }
}