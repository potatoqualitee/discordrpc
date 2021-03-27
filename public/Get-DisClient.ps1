function Get-DisClient {
    <#
    .SYNOPSIS
    Gets the current client/connection

    .DESCRIPTION
    Gets the current client/connection

    .EXAMPLE
    Get-DisClient

#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        $script:rpcclient
    }
}