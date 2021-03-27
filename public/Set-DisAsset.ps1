function Set-DisAsset {
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

    .PARAMETER InputObject
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText,
        [Parameter(Mandatory)]
        [DiscordRPC.Assets[]]$InputObject
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Assets")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Assets
                $object.LargeImageKey = $LargeImageKey
                $object.LargeImageText = $LargeImageText
                $object.SmallImageKey = $SmallImageKey
                $object.SmallImageText = $SmallImageText
            } catch {
                throw $_
            }
        }
    }
}
