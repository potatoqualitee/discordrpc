function New-DisParty {
    <#

#>
    [CmdletBinding()]
    param (
        [String]$ID,
        [Int32]$Size,
        [Int32]$Max,
        [DiscordRPC.Party+PrivacySetting]$Privacy
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Party
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