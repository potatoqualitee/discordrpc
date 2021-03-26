function New-DisTimestamp {
    <#

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