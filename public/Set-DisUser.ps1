function Set-DisUser {
    <#
    .SYNOPSIS
    Sets properties for the Discord user.

    .DESCRIPTION
    Sets properties for the Discord user.

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
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
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.User")) {
            try {
                $object = New-Object -TypeName DiscordRPC.User
                $object.ID = $ID
                $object.Username = $Username
                $object.Discriminator = $Discriminator
                $object.Avatar = $Avatar
                $object.Flags = $Flags
                $object.Premium = $Premium
                $object.CdnEndpoint = $CdnEndpoint
            } catch {
                throw $_
            }
        }
    }
}