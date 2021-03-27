function Update-DisTimestamp {
    <#
    .SYNOPSIS
    Sets properties for the timestamp structure representing the start and endtimes of a match.

    .DESCRIPTION
    Sets properties for the timestamp structure representing the start and endtimes of a match.

    .PARAMETER Start
    The time that match started. When included (not-null), the time in the rich presence will be shown as "00:01 elapsed".

    .PARAMETER End
    The time the match will end. When included (not-null), the time in the rich presence will be shown as "00:01 remaining". This will override the "elapsed" to "remaining".

    .PARAMETER StartUnixMilliseconds
    Converts between DateTime and Milliseconds to give the Unix Epoch Time for the Timestamp Start

    .PARAMETER EndUnixMilliseconds
    Converts between DateTime and Milliseconds to give the Unix Epoch Time  for the Tiemstamp End

    .EXAMPLE
    Update-DisTimestamp -Start (Get-Date).AddMinutes(-3) -End (Get-Date).AddMinutes(3)

    Updates the timestamp
#>
    [CmdletBinding()]
    param (
        [datetime]$Start,
        [datetime]$End,
        [uint64]$StartUnixMilliseconds,
        [uint64]$EndUnixMilliseconds
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        try {
            $timestamp = New-DisTimestamp @PSBoundParameters
            Update-DisRichPresence -Timestamps $timestamp
        } catch {
            throw $_
        }
    }
}