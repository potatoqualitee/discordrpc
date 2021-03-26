function New-DisEventType {

    <#

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