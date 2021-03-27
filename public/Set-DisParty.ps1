function Set-DisParty {
    <#
    .SYNOPSIS
    Creates a new XXX object

    .DESCRIPTION
    Creates a new XXX object

    .PARAMETER ID
    A unique ID for the player's current party / lobby / group. If this is not supplied, they player will not be in a party and the rest of the information will not be sent.

    .PARAMETER Size
    The current size of the players party / lobby / group.

    .PARAMETER Max
    Parameter description

    .PARAMETER Privacy
    The maxium size of the party / lobby / group. This is required to be larger than Size. If it is smaller than the current party size, it will automatically be set too Size when the presence is sent.

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
