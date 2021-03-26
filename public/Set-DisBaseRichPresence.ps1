function Set-DisBaseRichPresence {
    <#

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$State,
        [String]$Details,
        [DiscordRPC.Timestamps]$Timestamps,
        [DiscordRPC.Assets]$Assets,
        [DiscordRPC.Party]$Party,
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.BaseRichPresence")) {
            try {
                $object = New-Object -TypeName DiscordRPC.BaseRichPresence
                $object.State = $State
                $object.Details = $Details
                $object.Timestamps = $Timestamps
                $object.Assets = $Assets
                $object.Party = $Party
                $object.Secrets = $Secrets
            } catch {
                throw $_
            }
        }
    }
}
