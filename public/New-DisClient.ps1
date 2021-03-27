function New-DisClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .PARAMETER ApplicationID
    The Application ID of the RPC Client

    .PARAMETER Logger
     The logger used this client and its associated components

    .PARAMETER Presence
     The rich presence

    .PARAMETER SkipIdenticalPresence
    Skips sending presences that are identical to the current one

    .PARAMETER ShutdownOnly
    Forces the connection to shutdown gracefully instead of just aborting the connection

    .EXAMPLE
    $client = New-DisClient -ApplicationID 824593663883214948

    A simple client

    .EXAMPLE
    $assets = New-DisAsset -LargeImageKey psavatar -LargeImageText "Summoners Rift" -SmallImageKey icon -SmallImageText "Lvl 7"
    $timestamp = New-DisTimestamp -Start (Get-Date).AddMinutes(-3) -End (Get-Date).AddMinutes(3)
    $timestamp = [DiscordRPC.Timestamps]::Now
    $button = New-DisButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $party = New-DisParty -Size 10 -Privacy Public -Max 100
    $presence = New-DisRichPresence -Asset $assets -State "presence.ps1" -Details "Some details" -Timestamp $timestamp -Buttons $button -Party $party
    $logger = New-DisLogger -Type ConsoleLogger -Level Info
    $client = New-DisClient -ApplicationID 824593663883214948 -Presence $presence -Logger $logger

    A blinged out client

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$ApplicationID,
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
        $null = $script:rpcclient.Initialize()
        $script:rpcclient
    }
}