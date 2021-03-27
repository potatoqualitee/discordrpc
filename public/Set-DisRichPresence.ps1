function Set-DisRichPresence {
    <#
    .SYNOPSIS
    A Discord RPC Client which is used to send Rich Presence updates and receive Join / Spectate events.

    .DESCRIPTION
    A Discord RPC Client which is used to send Rich Presence updates and receive Join / Spectate events.

    .PARAMETER Buttons
    The buttons to display in the presence.

    .PARAMETER State
    The user's current Party status. For example, "Playing Solo" or "With Friends".

    .PARAMETER Details
    What the user is currently doing. For example, "Competitive - Total Mayhem"

    .PARAMETER Timestamps
    The time elapsed / remaining time data.

    .PARAMETER Assets
    The names of the images to use and the tooltips to give those images.

    .PARAMETER Party
    The party the player is currently in. The <see cref="P:DiscordRPC.Party.ID"/> must be set for this to be included in the RichPresence update.

    .PARAMETER Secrets
    The secrets used for Join / Spectate. Secrets are obfuscated data of your choosing. They could be match ids, player ids, lobby ids, etc. Make this object null if you do not wish too / unable too implement the Join / Request feature.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [DiscordRPC.Button[]]$Buttons,
        [String]$State,
        [String]$Details,
        [DiscordRPC.Timestamps]$Timestamps,
        [DiscordRPC.Assets]$Assets,
        [DiscordRPC.Party]$Party,
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.RichPresence")) {
            try {
                $object = New-Object -TypeName DiscordRPC.RichPresence
                $object.Buttons = $Buttons
                $object.State = $State
                $object.Details = $Details
                $object.Timestamps = $Timestamps
                $object.Assets = $Assets
                $object.Party = $Party
                $object.Secrets = $Secrets
            } catch {
                throw $_
            }
        }
    }
}
