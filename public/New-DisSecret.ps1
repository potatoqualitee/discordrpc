function New-DisSecret {
    <#
    .SYNOPSIS
    Creates the secrets used for Join / Spectate. Secrets are obfuscated data of your choosing. They could be match ids, player ids, lobby ids, etc.

    .DESCRIPTION
    Creates the secrets used for Join / Spectate. Secrets are obfuscated data of your choosing. They could be match ids, player ids, lobby ids, etc.

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
    [CmdletBinding()]
    param (
        [String]$MatchSecret,
        [String]$JoinSecret,
        [String]$SpectateSecret
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Secrets
        foreach ($key in $PSBoundParameters.Keys) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}