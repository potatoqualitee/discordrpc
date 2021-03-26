function New-DisConfiguration {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER ApiEndpoint
    Parameter description

    .PARAMETER CdnHost
    Parameter description

    .PARAMETER Enviroment
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [String]$ApiEndpoint,
        [String]$CdnHost,
        [String]$Enviroment
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Configuration
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