function Update-DisAsset {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence.

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence.

    .PARAMETER InputObject
    The updated asset object

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
                $script:rpcclient
            } catch {
                throw $_
            }
        }
    }
}