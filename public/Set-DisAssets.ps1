function Set-DisAssets {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER LargeImageKey
    Parameter description

    .PARAMETER LargeImageText
    Parameter description

    .PARAMETER SmallImageKey
    Parameter description

    .PARAMETER SmallImageText
    Parameter description

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
