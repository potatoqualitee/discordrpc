function Set-DisUser {
    <#

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [UInt64]$ID,
        [String]$Username,
        [Int32]$Discriminator,
        [String]$Avatar,
        [psobject]$Flags,
        [psobject]$Premium,
        [String]$CdnEndpoint
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.User")) {
            try {
                $object = New-Object -TypeName DiscordRPC.User
                $object.ID = $ID
                $object.Username = $Username
                $object.Discriminator = $Discriminator
                $object.Avatar = $Avatar
                $object.Flags = $Flags
                $object.Premium = $Premium
                $object.CdnEndpoint = $CdnEndpoint
            } catch {
                throw $_
            }
        }
    }
}