function Set-DisTimestamp {
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
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [datetime]$Start,
        [datetime]$End,
        [uint64]$StartUnixMilliseconds,
        [uint64]$EndUnixMilliseconds
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Timestamps")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Timestamps
                $object.Start = $Start
                $object.End = $End
                $object.StartUnixMilliseconds = $StartUnixMilliseconds
                $object.EndUnixMilliseconds = $EndUnixMilliseconds
            } catch {
                throw $_
            }
        }
    }
}
