function New-DisUser {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER ID
    Parameter description

    .PARAMETER Username
    Parameter description

    .PARAMETER Discriminator
    Parameter description

    .PARAMETER Avatar
    Parameter description

    .PARAMETER Flags
    Parameter description

    .PARAMETER Premium
    Parameter description

    .PARAMETER CdnEndpoint
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
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