function New-DisBaseRichPresence {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER State
    Parameter description

    .PARAMETER Details
    Parameter description

    .PARAMETER Timestamps
    Parameter description

    .PARAMETER Assets
    Parameter description

    .PARAMETER Party
    Parameter description

    .PARAMETER Secrets
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [String]$State,
        [String]$Details,
        [DiscordRPC.Timestamps]$Timestamps,
        [DiscordRPC.Assets]$Assets,
        [DiscordRPC.Party]$Party,
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        $object = New-Object -TypeName DiscordRPC.BaseRichPresence
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