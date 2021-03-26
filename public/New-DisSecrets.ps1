function New-DisSecrets {
    <#

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