function Set-DisSecret {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MatchSecret
    Parameter description

    .PARAMETER JoinSecret
    Parameter description

    .PARAMETER SpectateSecret
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
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
