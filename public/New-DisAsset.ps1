function New-DisAsset {
    <#
    .SYNOPSIS
    Creates an object used for the pictures used in the Rich Presence.

    .DESCRIPTION
    Creates an object used for the pictures used in the Rich Presence.

    Assets are set at https://discord.com/developers/applications/

    .PARAMETER LargeImageKey
    Name of the uploaded image for the large profile artwork.

    .PARAMETER LargeImageText
    The tooltip for the large square image. For example, "Summoners Rift" or "Horizon Lunar Colony".

    .PARAMETER SmallImageKey
    Name of the uploaded image for the small profile artwork.

    .PARAMETER SmallImageText
    The tooltip for the small circle image. For example, "LvL 6" or "Ultimate 85%".

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Assets
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}