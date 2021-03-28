function Get-DSTimerEvent {
    <#
    .SYNOPSIS
    Gets details about the timer setup in Start-DSClient that refreshes rich presence

    .DESCRIPTION
    Gets details about the timer setup in Start-DSClient that refreshes rich presence

    .EXAMPLE
    Get-DSClient

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