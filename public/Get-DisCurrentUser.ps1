function Get-DisCurrentUser {
    <#
    .SYNOPSIS
    Gets the current user

    .DESCRIPTION
    Gets the current user

    .EXAMPLE
    Get-DisCurrentUser

#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        $script:rpcclient.CurrentUser
    }
}