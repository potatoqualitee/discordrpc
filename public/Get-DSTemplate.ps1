function Get-DSTemplate {
    <#
    .SYNOPSIS
    Gets a list of a bunch of apps to use

    .DESCRIPTION
    Gets a list of a bunch of apps to use

    .EXAMPLE
    Get-DSTemplate

    .EXAMPLE
    Get-DSTemplate | Out-GridView

#>
    [CmdletBinding()]
    param ()
    process {
        $products = Get-Content (Resolve-Path "$script:ModuleRoot\clientids.json") | ConvertFrom-Json
        foreach ($product in $products) {
            $product | Select-Object *
        }
        $products = Get-Content (Resolve-Path "$script:ModuleRoot\other-clientids.json") | ConvertFrom-Json
        foreach ($product in $products) {
            $product | Select-Object *
        }
    }
}