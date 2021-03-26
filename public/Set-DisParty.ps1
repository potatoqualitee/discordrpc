function Set-DisParty {
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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$ID,
        [Int32]$Size,
        [Int32]$Max,
        [DiscordRPC.Party+PrivacySetting]$Privacy
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Party")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Party
                $object.ID = $ID
                $object.Size = $Size
                $object.Max = $Max
                $object.Privacy = $Privacy
            } catch {
                throw $_
            }
        }
    }
}
