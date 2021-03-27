function Update-DisAsset {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence.

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence.

    .PARAMETER LargeImageKey
    Name of the uploaded image for the large profile artwork.

    .PARAMETER LargeImageText
    The tooltip for the large square image. For example, "Summoners Rift" or "Horizon Lunar Colony".

    .PARAMETER SmallImageKey
    Name of the uploaded image for the small profile artwork.

    .PARAMETER SmallImageText
    The tooltip for the small circle image. For example, "LvL 6" or "Ultimate 85%".

    .EXAMPLE
    Update-DisAsset -SmallImageText "Lvl 8"

    Update just the small image text

    .EXAMPLE
    Update-DisAsset -LargeImageText "Summoners Rift" -SmallImageText "Lvl 8"

    Update more

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