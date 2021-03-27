function New-DisConfiguration {
    <#
    .SYNOPSIS
    Creates the configuration of the current RPC connection

    .DESCRIPTION
    Creates the configuration of the current RPC connection

    .PARAMETER ApiEndpoint
    The Discord API endpoint that should be used

    .PARAMETER CdnHost
    The CDN endpoint

    .PARAMETER Enviroment
    The type of enviroment the connection on. Usually Production.

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