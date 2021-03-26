function New-DisEventType {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER None
    Parameter description

    .PARAMETER Spectate
    Parameter description

    .PARAMETER Join
    Parameter description

    .PARAMETER JoinRequest
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [string]$None,
        [string]$Spectate,
        [string]$Join,
        [string]$JoinRequest
    )
    process {
        $object = New-Object -TypeName DiscordRPC.EventType
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