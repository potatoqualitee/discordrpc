function Update-DSAsset {
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
    Update-DSAsset -SmallImageText "Lvl 8"

    Update just the small image text

    .EXAMPLE
    Update-DSAsset -LargeImageText "Summoners Rift" -SmallImageText "Lvl 8"

    Update more

#>
    [CmdletBinding()]
    param (
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DSClient or Start-DSClient"
        }
        try {
            $prescence = $script:rpcclient.CurrentPresence

            if ($LargeImageKey -or $LargeImageText) {
                if (-not $LargeImageKey) {
                    $LargeImageKey = $prescence.Assets.LargeImageKey
                }
                if (-not $LargeImageText) {
                    $LargeImageText = $prescence.Assets.LargeImageText
                }

                # Check for Discord limitation on LargeImageKey length
                if ($LargeImageKey.Length -gt 32) {
                    throw "LargeImageKey cannot be longer than 32 characters due to Discord limitations.`nPlease consider using Imgur for shorter links."
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
