function New-DisTimestamp {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Start
    Parameter description

    .PARAMETER End
    Parameter description

    .PARAMETER StartUnixMilliseconds
    Parameter description

    .PARAMETER EndUnixMilliseconds
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [datetime]$Start,
        [datetime]$End,
        [uint64]$StartUnixMilliseconds,
        [uint64]$EndUnixMilliseconds
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Timestamps
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