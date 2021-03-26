function Set-DisSecrets {
    <#

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$MatchSecret,
        [String]$JoinSecret,
        [String]$SpectateSecret
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Secrets")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Secrets
                $object.MatchSecret = $MatchSecret
                $object.JoinSecret = $JoinSecret
                $object.SpectateSecret = $SpectateSecret
            } catch {
                throw $_
            }
        }
    }
}
