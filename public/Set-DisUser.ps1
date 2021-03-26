function Set-DisUser {
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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
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
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.User")) {
            try {
                $object = New-Object -TypeName DiscordRPC.User
                $object.ID = $ID
                $object.Username = $Username
                $object.Discriminator = $Discriminator
                $object.Avatar = $Avatar
                $object.Flags = $Flags
                $object.Premium = $Premium
                $object.CdnEndpoint = $CdnEndpoint
            } catch {
                throw $_
            }
        }
    }
}