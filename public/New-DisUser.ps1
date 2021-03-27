function New-DisUser {
    <#
    .SYNOPSIS
    Creates a new User instance.. This is used for join requests.

    .DESCRIPTION
    Creates a new User instance.. This is used for join requests.

    .PARAMETER ID
    Parameter description

    .PARAMETER Username
    The username of the player.

    .PARAMETER Discriminator
    The discriminator of the user.

    .PARAMETER Avatar
    Possible formats for avatars

    .PARAMETER Flags
    The flags on a users account, often represented as a badge.

    .PARAMETER Premium
    The premium type of the user.

    .PARAMETER CdnEndpoint
    The endpoint for the CDN. Normally cdn.discordapp.com.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [UInt64]$ID,
        [String]$Username,
        [Int32]$Discriminator,
        [String]$Avatar,
        [psobject]$Flags,
        [psobject]$Premium,
        [String]$CdnEndpoint
    )
    process {
        $object = New-Object -TypeName DiscordRPC.User
        if ($PSBoundParameters.Count) {
            foreach ($param in $PSBoundParameters) {
                $key = $param.Keys
                if ($key -and $param.Values) {
                    $object.$key = $param.Values
                }
            }
        }
        $object
    }
}