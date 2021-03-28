function Update-DSRichPresence {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence

    .PARAMETER Buttons
    The buttons to display in the presence

    .PARAMETER State
    The user's current Party status. For example, "Playing Solo" or "With Friends".

    .PARAMETER Details
    What the user is currently doing. For example, "Competitive - Total Mayhem"

    .PARAMETER Timestamps
    The time elapsed / remaining time data

    .PARAMETER Assets
    The names of the images to use and the tooltips to give those images

    .PARAMETER Party
    The party the player is currently in. The ID must be set for this to be included in the RichPresence update.

    .PARAMETER Secrets
    The secrets used for Join / Spectate. Secrets are obfuscated data of your choosing. They could be match ids, player ids, lobby ids, etc. Make this object null if you do not wish too / unable too implement the Join / Request feature.

    .EXAMPLE
    $timestamp = [DiscordRPC.Timestamps]::Now
    $button = New-DSButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $params = @{
        Timestamp = $timestamp
        Buttons = $button
    }
    Update-DSRichPresence @params

#>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Button[]]$Buttons,
        [Parameter(ValueFromPipeline)]
        [psobject]$State,
        [Parameter(ValueFromPipeline)]
        [psobject]$Details,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Timestamps]$Timestamps,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Assets]$Assets,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Party]$Party,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DSClient or Start-DSClient"
        }
        $prescence = $script:rpcclient.CurrentPresence

        if (-not $Buttons) {
            $Buttons = $prescence.Buttons
        }
        if (-not $State) {
            $State = $prescence.State
        }
        if (-not $Details) {
            $Details = $prescence.Details
        }
        if (-not $Timestamps) {
            $Timestamps = $prescence.Timestamps
        }
        if (-not $Assets) {
            $Assets = $prescence.Assets
        }
        if (-not $Party) {
            $Party = $prescence.Party
        }
        if (-not $Secrets) {
            $Secrets = $prescence.Secrets
        }

        $params = @{
            Buttons    = $Buttons
            State      = $State
            Details    = $Details
            Timestamps = $Timestamps
            Assets     = $Assets
            Party      = $Party
            Secrets    = $Secrets
        }

        $newprescence = New-DSRichPresence @params
        try {
            $script:rpcclient.SetPresence($newprescence)
            $null = $script:rpcclient.SynchronizeState()
            $script:rpcclient.CurrentPresence
        } catch {
            throw $_
        }
    }
}