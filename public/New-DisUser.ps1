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
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}