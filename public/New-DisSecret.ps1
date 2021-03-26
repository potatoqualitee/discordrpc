function New-DisSecret {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MatchSecret
    Parameter description

    .PARAMETER JoinSecret
    Parameter description

    .PARAMETER SpectateSecret
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [String]$MatchSecret,
        [String]$JoinSecret,
        [String]$SpectateSecret
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Secrets
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