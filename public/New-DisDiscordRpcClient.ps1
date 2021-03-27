function New-DisDiscordRpcClient {
    <#
    .SYNOPSIS
    Creates a new Discord RPC Client which can be used to send Rich Presence and receive Join / Spectate events.

    .DESCRIPTION
    Creates a new Discord RPC Client which can be used to send Rich Presence and receive Join / Spectate events.

    .PARAMETER HasRegisteredUriScheme
    Gets a value indicating if the client has registered a URI Scheme. If this is false, Join / Spectate events will fail.

    .PARAMETER ApplicationID
    The Application ID of the RPC Client.

    .PARAMETER SteamID
    Gets the Steam ID of the RPC Client. This value can be null if none was supplied.

    .PARAMETER ProcessID
    Gets the ID of the process used to run the RPC Client. Discord tracks this process ID and waits for its termination. Defaults to the current application process ID.

    .PARAMETER MaxQueueSize
    The maximum size of the message queue received from Discord.

    .PARAMETER IsDisposed
    The dispose state of the client object.

    .PARAMETER Logger
     The logger used this client and its associated components.

    .PARAMETER AutoEvents
    Indicates if the client will automatically invoke the events without Invoke having to be called.

    .PARAMETER SkipIdenticalPresence
    Skips sending presences that are identical to the current one.

    .PARAMETER TargetPipe
    The pipe the discord client is on, ranging from 0 to 9. Use -1 to scan through all pipes.

    .PARAMETER CurrentPresence
    The current presence that the client has.

    .PARAMETER Subscription
    Current subscription to events.

    .PARAMETER CurrentUser
    The current discord user. This is updated with the ready event and will be null until the event is fired from the connection.

    .PARAMETER Configuration
    The current configuration the connection is using. Only becomes available after a ready event.

    .PARAMETER IsInitialized
    Represents if the client has been initalized

    .PARAMETER ShutdownOnly
    Forces the connection to shutdown gracefully instead of just aborting the connection.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
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
        $object = New-Object -TypeName DiscordRPC.DiscordRpcClient
        if ($PSBoundParameters.Count) {
            foreach ($param in $PSBoundParameters) {
                $key = $param.Keys
                if ($key -and $param.Values) {
                    $object.$key = $param.Values
                }
            }
        }
        $object
    }
}