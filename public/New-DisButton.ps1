function New-DisButton {
    <#

#>
    [CmdletBinding()]
    param (
        [String]$Label,
        [String]$Url
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Button
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