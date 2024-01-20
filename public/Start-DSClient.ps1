function Start-DSClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence

    .PARAMETER Template
    Use a template to provide the name and assets of a Product. When using a Template, consider specifying a ScriptBlock to show a richer presence.

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
     Update your client with new data every seconds

    .PARAMETER ScriptBlock
     The script to run on a timer, aliased to UpdateScript

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
        LargeImageKey  = "avatar"
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

    .EXAMPLE
    Change default applications to your liking:
    1: Go to %UserProfile%\Documents\WindowsPowerShell\Modules\discordrpc\0.0.2
    2: Open clientids.json or other-clientids.json
    3: Edit the default application that is already in there
    Note: You can change the values of LargeText/SmallText/Details to what you want
    (Don't change ClientID/LargeImage/SmallImage/Start, unless you know what you're doing)
	
    Example:
    {
        "Product": "Netflix",
        "ClientID": "499981204045430784",
        "LargeImage": "nflix_lg",
        "LargeText": null,
        "SmallImage": "play",
        "SmallText": "Watching",
        "Details": "Watching a movie",
        "Start":  "now"
    },
    After you changed the application to what you like/what you want it to show in Discord. Save it.
    Go to your PowerShell and use the command "Start-DSClient 'ProductName'"
    For the example above it would simply be: Start-DSClient Netflix


#>
    [CmdletBinding()]
    param (
        [String]$Template,
        [String]$ApplicationID,
        [String]$State,
        [String]$Details,
        [String]$LargeImageKey,
        [String]$LargeImageText,
        [String]$SmallImageKey,
        [String]$SmallImageText,
        [psobject]$Start,
        [psobject]$End,
        [String]$Label,
        [String]$Url,
        [ValidateSet("ConsoleLogger","FileLogger")]
        [String]$LoggerType,
        [ValidateSet("Trace","Info","None","Error","Warning")]
        [String]$LoggerLevel = "Info",
        [String]$LoggerPath,
        [Int]$TimerRefresh = 5,
        [DiscordRPC.Timestamps]$Timestamp,
        [Alias("UpdateScript")]
        [ScriptBlock]$ScriptBlock
    )
    process {
        $TimerRefresh = $TimerRefresh * 1000
        if ($Label -and -not $Url) {
            throw "You must specify URL when using Labels"
        }

        if (-not $Label -and $Url) {
            throw "You must specify Label when using URls"
        }

        if (-not $PSBoundParameters.Template -and -not $PSBoundParameters.ApplicationID) {
            $Template = "discordrpc"
        }

        if ($Template) {
            # saving as much time as possible for initial load
            if ($Template -eq "discordrpc") {
                $ApplicationID = "824593663883214948"
                $LargeImageKey = "avatar"
                $SmallImageKey = "icon"
            } else {
                if (-not $script:clientids) {
                    $script:clientids = Get-Content (Resolve-Path "$script:ModuleRoot\clientids.json") | ConvertFrom-Json
                }
                $product = $script:clientids | Where-Object Product -eq $Template

                if (-not $product) {
                    # try the other ones. this is to reduce the import time when loading the module
                    $product = Get-Content (Resolve-Path "$script:ModuleRoot\clientids.json") | ConvertFrom-Json | Where-Object Product -eq $Template
                }
                $ApplicationID = $product.ClientID

                if (-not $PSBoundParameters.LargeImageKey) {
                    $LargeImageKey = $product.LargeImage
                }
                if (-not $PSBoundParameters.LargeImageText) {
                    $LargeImageText = $product.LargeText
                }
                if (-not $PSBoundParameters.SmallImageKey) {
                    $SmallImageKey = $product.SmallImage
                }
                if (-not $PSBoundParameters.SmallImageText) {
                    $SmallImageText = $product.SmallText
                }
                if (-not $PSBoundParameters.Details) {
                    $Details= $product.Details
                }
		if (-not $PSBoundParameters.Start) {
                    $Start= $product.Start
                }
            }
        }

        $parms = @{
            LargeImageKey  = $LargeImageKey
            LargeImageText = $LargeImageText
            SmallImageKey  = $SmallImageKey
            SmallImageText = $SmallImageText
        }
        $assets = New-DSAsset @parms

        if ($script:rpcclient) {
            $null = Stop-DSClient
        }

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
            if ($End) {
                $timestamp = New-DSTimestamp -Start $Start -End $End
            } else {
                $timestamp = New-DSTimestamp -Start $Start
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
