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
        [String]$ApplicationID = "824593663883214948",
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText,
        [datetime]$Start = (([DiscordRPC.Timestamps]::Now).Start),
        [datetime]$End,
        [String]$Label,
        [String]$Url,
        [String]$State,
        [String]$Details,
        [ValidateSet("ConsoleLogger","FileLogger")]
        [String]$LoggerType,
        [ValidateSet("Trace","Info","None","Error","Warning")]
        [String]$LoggerLevel = "Info",
        [String]$LoggerPath,
        [Int]$TimerRefresh = 5000,
        [ScriptBlock]$ScriptBlock
    )
    process {
        if ($ScriptBlock -and $ScriptBlock.ToString() -notmatch "global:timervars.Client") {
            throw 'ScriptBlock must use $global:timervars.Client to manage the client. Please check the docs for more information.'
        }

        $script:rpcclient = New-Object -TypeName DiscordRPC.DiscordRpcClient $ApplicationID

        $parms = @{
            LargeImageKey  = $LargeImageKey
            LargeImageText = $LargeImageText
            SmallImageKey  = $SmallImageKey
            SmallImageText = $SmallImageText
        }
        $assets = New-DisAsset @parms

        $parms = @{
            Type  = $LoggerType
            Level = $LoggerLevel
            Path  = $LoggerPath
        }
        $logger = New-DisLogger @parms

        $button = New-DisButton -Label $Label -Url $Url
        $timestamp = New-DisTimestamp -Start $Start -End $End

        $parms = @{
            Assets     = $assets
            State      = $State
            Details    = $Details
            Timestamps = $timestamp
            Buttons    = $button
            Logger     = $logger
        }
        $presence = New-DisRichPresence @parms

        $script:rpcclient.Initialize()
        $script:rpcclient.SetPresence($presence)

        if ($ScriptBlock) {
            # timers require global variables
            $global:discordrpcclient = $script:rpcclient

            if (Get-EventSubscriber -SourceIdentifier Discord -ErrorAction Ignore) {
                $null = Get-EventSubscriber -SourceIdentifier Discord -ErrorAction Ignore | Unregister-Event
            }

            $timer = New-Object System.Timers.Timer $TimerRefresh
            $timer.Enabled = $true
            $timer.AutoReset = $true

            $params = @{
                InputObject      = $timer
                EventName        = "Elapsed"
                SourceIdentifier = "Discord"
                Action           = $ScriptBlock
            }

            $null = Register-ObjectEvent @params
            $null = $timer.Start()
        }
        $script:rpcclient
    }
}