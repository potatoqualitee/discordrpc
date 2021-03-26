function Set-DisDiscordRpcClient {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER HasRegisteredUriScheme
    Parameter description

    .PARAMETER ApplicationID
    Parameter description

    .PARAMETER SteamID
    Parameter description

    .PARAMETER ProcessID
    Parameter description

    .PARAMETER MaxQueueSize
    Parameter description

    .PARAMETER IsDisposed
    Parameter description

    .PARAMETER Logger
    Parameter description

    .PARAMETER AutoEvents
    Parameter description

    .PARAMETER SkipIdenticalPresence
    Parameter description

    .PARAMETER TargetPipe
    Parameter description

    .PARAMETER CurrentPresence
    Parameter description

    .PARAMETER Subscription
    Parameter description

    .PARAMETER CurrentUser
    Parameter description

    .PARAMETER Configuration
    Parameter description

    .PARAMETER IsInitialized
    Parameter description

    .PARAMETER ShutdownOnly
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [Switch]$HasRegisteredUriScheme,
        [String]$ApplicationID,
        [String]$SteamID,
        [Int32]$ProcessID,
        [Int32]$MaxQueueSize,
        [Switch]$IsDisposed,
        [DiscordRPC.Logging.ILogger]$Logger,
        [Switch]$AutoEvents,
        [Switch]$SkipIdenticalPresence,
        [Int32]$TargetPipe,
        [DiscordRPC.RichPresence]$CurrentPresence,
        [DiscordRPC.EventType]$Subscription,
        [DiscordRPC.User]$CurrentUser,
        [DiscordRPC.Configuration]$Configuration,
        [Switch]$IsInitialized,
        [Switch]$ShutdownOnly
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.DiscordRpcClient")) {
            try {
                $object = New-Object -TypeName DiscordRPC.DiscordRpcClient
                $object.HasRegisteredUriScheme = $HasRegisteredUriScheme
                $object.ApplicationID = $ApplicationID
                $object.SteamID = $SteamID
                $object.ProcessID = $ProcessID
                $object.MaxQueueSize = $MaxQueueSize
                $object.IsDisposed = $IsDisposed
                $object.Logger = $Logger
                $object.AutoEvents = $AutoEvents
                $object.SkipIdenticalPresence = $SkipIdenticalPresence
                $object.TargetPipe = $TargetPipe
                $object.CurrentPresence = $CurrentPresence
                $object.Subscription = $Subscription
                $object.CurrentUser = $CurrentUser
                $object.Configuration = $Configuration
                $object.IsInitialized = $IsInitialized
                $object.ShutdownOnly = $ShutdownOnly
            } catch {
                throw $_
            }
        }
    }
}
