function Start-DisClient {
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

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$ApplicationID,
        [String]$Logger,
        [Switch]$SkipIdenticalPresence,
        [Switch]$ShutdownOnly,
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText,
        [DiscordRPC.Button[]]$Buttons,
        [String]$State,
        [String]$Details,
        [DiscordRPC.Timestamps]$Timestamps,
        [DiscordRPC.Assets]$Assets,
        [DiscordRPC.Party]$Party,
        [DiscordRPC.Secrets]$Secrets,
        [ValidateSet("ConsoleLogger","FileLogger")]
        [String]$LoggingType,
        [ValidateSet("Trace","Info","None","Error","Warning")]
        [String]$LoggingLevel = "Info",
        [String]$LoggingPath,
        [Switch]$ColorOutput,
        [ScriptBlock]$ScriptBlock
    )
    process {
        #fix string
        # add params from assets
        $script:rpcclient = New-Object -TypeName DiscordRPC.DiscordRpcClient $ApplicationID
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            if ($key -eq "ApplicationID") { continue }
            $script:rpcclient.$key = $PSBoundParameters[$key]
        }
        $script:rpcclient.Initialize()
        $script:rpcclient
    }
}