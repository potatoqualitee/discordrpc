function Get-DSClient {
    <#
    .SYNOPSIS
    Gets the current client/connection

    .DESCRIPTION
    Gets the current client/connection

    .EXAMPLE
    Get-DSClient

#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DSClient or Start-DSClient"
        }
        $script:rpcclient
    }
}