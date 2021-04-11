function New-DSClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .PARAMETER ApplicationID
    The Application ID of the RPC Client

    This uses discordrpc's client id by default, but you can use your own by creating an application at https://discord.com/developers/applications/

    .PARAMETER Logger
     The logger used this client and its associated components

    .PARAMETER Presence
     The rich presence

    .PARAMETER SkipIdenticalPresence
    Skips sending presences that are identical to the current one

    .PARAMETER ShutdownOnly
    Forces the connection to shutdown gracefully instead of just aborting the connection

    .EXAMPLE
    Clear-DSTimestamp

    Clears the timestamp from the client
#>
    [CmdletBinding()]
    param (
        [String]$ApplicationID = "824593663883214948",
        [DiscordRPC.Logging.ILogger]$Logger,
        [DiscordRPC.RichPresence]$Presence,
        [Switch]$SkipIdenticalPresence,
        [Switch]$ShutdownOnly
    )
    process {
        $script:rpcclient = New-Object -TypeName DiscordRPC.DiscordRpcClient $ApplicationID
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            if ($key -eq "ApplicationID") { continue }
            if ($key -eq "Presence") {
                $script:rpcclient.SetPresence($Presence)
            } else {
                $script:rpcclient.$key = $PSBoundParameters[$key]
            }
        }
        if (-not $script:rpcclient.IsInitialized) {
            $null = $script:rpcclient.Initialize()
        }
        $script:rpcclient
    }
}