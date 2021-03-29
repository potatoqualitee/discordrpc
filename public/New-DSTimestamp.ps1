function New-DSTimestamp {
    <#
    .SYNOPSIS
    Creates an object representing the start and endtimes of a match.

    .DESCRIPTION
    Creates an object representing the start and endtimes of a match.

    .PARAMETER Start
    The time that match started. When included (not-null), the time in the rich presence will be shown as "00:01 elapsed".

    Note this must be in local time, as it automatically gets changed to universal time

    .PARAMETER End
    The time the match will end. When included (not-null), the time in the rich presence will be shown as "00:01 remaining". This will override the "elapsed" to "remaining".

    Note this must be in local time, as it automatically gets changed to universal time

    .PARAMETER StartUnixMilliseconds
    Converts between DateTime and Milliseconds to give the Unix Epoch Time for the Timestamp Start

    .PARAMETER EndUnixMilliseconds
    Converts between DateTime and Milliseconds to give the Unix Epoch Time  for the Tiemstamp End

    .EXAMPLE
    $timestamp = New-DSTimestamp -Start (Get-Date).AddMinutes(-3) -End (Get-Date).AddMinutes(3)

    Creates a timestamp object that has a specific match length and counts down but not like Spotify

    .EXAMPLE
    $timestamp = [DiscordRPC.Timestamps]::Now
    $presence = New-DSRichPresence -Asset $assets -Details "Some details" -Timestamp $timestamp -Buttons $button -Party $party
    $client = New-DSClient -ApplicationID 824593663883214948 -Presence $presence #-Logger $logger

    Starts a nice lil timestamp that shows elapsed

    .EXAMPLE
    $timestamp = [DiscordRPC.Timestamps]::FromTimeSpan(10)

    Starts a timestamp to say you've been on longer i think

#>
    [CmdletBinding()]
    param (
        [psobject]$Start,
        [psobject]$End,
        [uint64]$StartUnixMilliseconds,
        [uint64]$EndUnixMilliseconds
    )
    process {
        if ($Start -eq "Now") {
            $object = [DiscordRPC.Timestamps]::Now
        } else {
            $object = New-Object -TypeName DiscordRPC.Timestamps
            if ($Start) {
                $Start = $Start.ToUniversalTime()
                $object.Start = $Start
            }
            if ($End) {
                $End = $End.ToUniversalTime()
                $object.End = $End
            }
            if ($StartUnixMilliseconds) {
                $object.StartUnixMilliseconds = $StartUnixMilliseconds
            }
            if ($EndUnixMilliseconds) {
                $object.EndUnixMilliseconds = $EndUnixMilliseconds
            }
        }
        $object
    }
}