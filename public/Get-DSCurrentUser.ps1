function Get-DSCurrentUser {
    <#
    .SYNOPSIS
    Gets the current user

    .DESCRIPTION
    Gets the current user

    .EXAMPLE
    Get-DSCurrentUser

    Gets the current user logged into Discord

#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DSClient or Start-DSClient"
        }
        $script:rpcclient.CurrentUser
    }
}