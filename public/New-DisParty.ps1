function New-DisParty {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER ID
    Parameter description

    .PARAMETER Size
    Parameter description

    .PARAMETER Max
    Parameter description

    .PARAMETER Privacy
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
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