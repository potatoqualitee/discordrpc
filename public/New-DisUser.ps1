function New-DisUser {
    <#

#>
    [CmdletBinding()]
    param (
        [UInt64]$ID,
        [String]$Username,
        [Int32]$Discriminator,
        [String]$Avatar,
        [psobject]$Flags,
        [psobject]$Premium,
        [String]$CdnEndpoint
    )
    process {
        $object = New-Object -TypeName DiscordRPC.User
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