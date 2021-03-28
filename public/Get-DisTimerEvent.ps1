function Get-DisTimerEvent {
    <#
    .SYNOPSIS
    Gets details about the timer setup in Start-DisClient that refreshes rich presence

    .DESCRIPTION
    Gets details about the timer setup in Start-DisClient that refreshes rich presence

    .EXAMPLE
    Get-DisClient

#>
    [CmdletBinding()]
    param ()
    process {
        $timerevent = Get-EventSubscriber -SourceIdentifier Discord -ErrorAction Ignore
        if ($timerevent) {
            [pscustomobject]@{
                Timer    = $timerevent.Timer
                Interval = $timerevent.Timer.Interval
                Event    = $timerevent
                Command  = $timerevent.Action.Command.Trim()
            }
        }
    }
}