function New-DisConfiguration {
    <#

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