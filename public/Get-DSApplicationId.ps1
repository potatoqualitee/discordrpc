function Get-DSApplicationId {
    <#
    .SYNOPSIS
    Gets a list of a bunch of apps to use

    .DESCRIPTION
    Gets a list of a bunch of apps to use

    .EXAMPLE
    Get-DSApplicationId

#>
    [CmdletBinding()]
    param ()
    process {
        Get-Content (Resolve-Path "$script:ModuleRoot\clientids.json") | ConvertFrom-Json
        Get-Content (Resolve-Path "$script:ModuleRoot\other-clientids.json") | ConvertFrom-Json
    }
}