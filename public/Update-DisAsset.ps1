function Update-DisAsset {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence.

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence.

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
    $assets = New-DisAsset -LargeImageText "Summoners Rift" -SmallImageText "Lvl 8"
    $assets | Update-DisAsset

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on client.CurrentPresence")) {
            try {
                $prescence = $script:rpcclient.CurrentPresence

                if ($LargeImageText -or $LargeImageText) {
                    if (-not $LargeImageKey) {
                        $LargeImageKey = $prescence.Assets.LargeImageKey
                    }
                    if (-not $LargeImageText) {
                        $LargeImageText = $prescence.Assets.LargeImageText
                    }
                    $null = $script:rpcclient.UpdateLargeAsset($LargeImageKey, $LargeImageText)
                }

                if ($SmallImageKey -or $SmallImageText) {
                    if (-not $SmallImageKey) {
                        $SmallImageKey = $prescence.Assets.SmallImageKey
                    }
                    if (-not $SmallImageText) {
                        $SmallImageText = $prescence.Assets.SmallImageText
                    }
                    $null = $script:rpcclient.UpdateSmallAsset($SmallImageKey, $SmallImageText)
                }

                $null = $script:rpcclient.SynchronizeState()
                $script:rpcclient.CurrentPresence.Assets
            } catch {
                throw $_
            }
        }
    }
}