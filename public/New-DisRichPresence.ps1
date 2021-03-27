function New-DisRichPresence {
    <#
    .SYNOPSIS
    Creates a Rich Presence object that will be sent and received by Discord.

    .DESCRIPTION
    Creates a Rich Presence object that will be sent and received by Discord. Use this class to build your presence and update it appropriately.

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
    [CmdletBinding()]
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
        $object = New-Object -TypeName DiscordRPC.RichPresence
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}