function Get-DisCurrentUser {
    <#
    .SYNOPSIS
    Creates a new User instance.. This is used for join requests.

    .DESCRIPTION
    Creates a new User instance.. This is used for join requests.

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