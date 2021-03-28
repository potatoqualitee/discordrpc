function Start-DSClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .PARAMETER ApplicationID
    The Application ID of the RPC Client

    This uses the discordrpc module's client id by default, but you can use your own by creating an application at https://discord.com/developers/applications/

    .PARAMETER State
    The user's current Party status. For example, "Playing Solo" or "With Friends"

    .PARAMETER Details
    What the user is currently doing. For example, "Competitive - Total Mayhem"

    .PARAMETER LargeImageKey
    Name of the uploaded image for the large profile artwork

    .PARAMETER LargeImageText
    The tooltip for the large square image. For example, "Summoners Rift" or "Horizon Lunar Colony".

    .PARAMETER SmallImageKey
    Name of the uploaded image for the small profile artwork

    .PARAMETER SmallImageText
    The tooltip for the small circle image. For example, "LvL 6" or "Ultimate 85%".

    .PARAMETER Start
    The time that match started. Setting the value to "Now" will show "00:01 elapsed".

    .PARAMETER End
    The time the match will end. When included (not-null), the time in the rich presence will be shown as "00:01 remaining". This will override the "elapsed" to "remaining".

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button

    .PARAMETER LoggerType
    The type of logger: ConsoleLogger or FileLogger

    ConsoleLogger logs the outputs to the console
    FileLogger logs the outputs to file

    .PARAMETER LoggerLevel
     The level of logging: Trace, Info, None, Error, Warning

    .PARAMETER LoggerPath
     The path to the log file when the Type is FileLogger

    .PARAMETER TimerRefresh
     Update your client with new data ever x milliseconds

    .PARAMETER ScriptBlock
     The script to run on a timer


    .EXAMPLE
    $parms = @{
        ApplicationID  = "824593663883214948"
        Details        = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
        State          = (Split-Path -Path $pwd -Leaf)
    }
    Start-DSClient @parms

    .EXAMPLE
    $parms = @{
        ApplicationID  = "824593663883214948"
        LargeImageKey  = "psavatar"
        LargeImageText = "Summoners Rift"
        SmallImageKey  = "icon"
        SmallImageText = "Lvl 7"
        Label          = "Potato 🥔"
        Url            = "https://github.com/potatoqualitee/discordrpc"
        Details        = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
        State          = (Split-Path -Path $pwd -Leaf)
        LoggerLevel    = "Info"
        TimerRefresh   = 5000
        Start          = "Now"
        ScriptBlock    = {
            Update-DSAsset -LargeImageText "Timer worked!" -SmallImageText "Lvl 10"
            Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
        }
    }

    Start-DSClient @parms


#>
    [CmdletBinding()]
    param (
        [String]$ApplicationID = "824593663883214948",
        [String]$State,
        [String]$Details,
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText,
        [psobject]$Start,
        [datetime]$End,
        [String]$Label,
        [String]$Url,
        [ValidateSet("ConsoleLogger","FileLogger")]
        [String]$LoggerType,
        [ValidateSet("Trace","Info","None","Error","Warning")]
        [String]$LoggerLevel = "Info",
        [String]$LoggerPath,
        [Int]$TimerRefresh = 5000,
        [ScriptBlock]$ScriptBlock
    )
    process {
        if ($Label -and -not $Url) {
            throw "You must specify URL when using Labels"
        }
        if (-not $Label -and $Url) {
            throw "You must specify Label when using URls"
        }

        $parms = @{
            LargeImageKey  = $LargeImageKey
            LargeImageText = $LargeImageText
            SmallImageKey  = $SmallImageKey
            SmallImageText = $SmallImageText
        }
        $assets = New-DSAsset @parms

        if ($LoggerType) {
            $parms = @{
                Type  = $LoggerType
                Level = $LoggerLevel
                Path  = $LoggerPath
            }
            $logger = New-DSLogger @parms
            $script:rpcclient = New-DSClient -ApplicationID $ApplicationID -Logger $Logger
        } else {
            $script:rpcclient = New-DSClient -ApplicationID $ApplicationID
        }


        if ($Label -and $Url) {
            $button = New-DSButton -Label $Label -Url $Url
        }

        if ($Start -or $End) {
            if ($Start -eq "Now") {
                $timestamp = [DiscordRPC.Timestamps]::Now
            } else {
                if ($End) {
                    $timestamp = New-DSTimestamp -Start $Start -End $End
                } else {
                    $timestamp = New-DSTimestamp -Start $Start
                }
            }
        }

        $parms = @{
            Assets     = $assets
            State      = $State
            Details    = $Details
            Timestamps = $timestamp
            Buttons    = $button
        }
        $presence = New-DSRichPresence @parms

        if (-not $script:rpcclient.IsInitialized) {
            $null = $script:rpcclient.Initialize()
        }

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