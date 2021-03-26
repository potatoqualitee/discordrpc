function New-DisRichPresence {
    <#

#>
    [CmdletBinding()]
    param (
        [DiscordRPC.Button[]]$Buttons,
        [String]$State,
        [String]$Details,
        [DiscordRPC.Timestamps]$Timestamps,
        [DiscordRPC.Assets]$Assets,
        [DiscordRPC.Party]$Party,
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        $object = New-Object -TypeName DiscordRPC.RichPresence
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