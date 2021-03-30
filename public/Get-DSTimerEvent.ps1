function Get-DSTimerEvent {
    <#
    .SYNOPSIS
    Gets details about all timers setup in Start-DSClient that refreshes rich presence

    .DESCRIPTION
    Gets details about all timers setup in Start-DSClient that refreshes rich presence

    .EXAMPLE
    Get-DSClient

#>
    [CmdletBinding()]
    param ()
    process {
        $allevents = Get-EventSubscriber -ErrorAction Ignore | Where-Object SourceIdentifier -match Discord
        foreach ($timerevent in $allevents) {
            [pscustomobject]@{
                Timer    = $timerevent.SourceObject
                Interval = $timerevent.SourceObject.Interval
                Event    = $timerevent
                Command  = $timerevent.Action.Command.Trim()
            }
        }
    }
}