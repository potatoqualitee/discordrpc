function New-DisClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence and receive Join / Spectate events.

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence and receive Join / Spectate events.

    .PARAMETER ApplicationID
    The Application ID of the RPC Client.

    .PARAMETER Logger
     The logger used this client and its associated components.

    .PARAMETER SkipIdenticalPresence
    Skips sending presences that are identical to the current one.

    .PARAMETER ShutdownOnly
    Forces the connection to shutdown gracefully instead of just aborting the connection.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$ApplicationID,
        [DiscordRPC.Logging.ILogger]$Logger,
        [Switch]$SkipIdenticalPresence,
        [Switch]$ShutdownOnly
    )
    process {
        # $client.Logger = (New-Object DiscordRPC.Logging.ConsoleLogger)
        $object = New-Object -TypeName DiscordRPC.DiscordRpcClient $ApplicationID
        foreach ($key in $PSBoundParameters.Keys) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}