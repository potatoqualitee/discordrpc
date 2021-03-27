function Set-DisSecret {
    <#
    .SYNOPSIS
    Creates a new XXX object

    .DESCRIPTION
    Creates a new XXX object

    .PARAMETER MatchSecret
    The unique match code to distinguish different games/lobbies. Use <see cref="M:DiscordRPC.Secrets.CreateSecret(System.Random)"/> to get an appropriately sized secret.

    .PARAMETER JoinSecret
    The secret data that will tell the client how to connect to the game to play. This could be a unique identifier for a fancy match maker or player id, lobby id, etc.

    .PARAMETER SpectateSecret
    The secret data that will tell the client how to connect to the game to spectate. This could be a unique identifier for a fancy match maker or player id, lobby id, etc.

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
