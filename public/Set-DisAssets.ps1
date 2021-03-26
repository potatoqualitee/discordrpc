function Set-DisAssets {
    <#

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
