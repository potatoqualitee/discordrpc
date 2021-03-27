function New-DisParty {
    <#
    .SYNOPSIS
    Creates a new object for the structure representing the party the player is in.

    .DESCRIPTION
    Creates a new object for the structure representing the party the player is in.

    .PARAMETER ID
    A unique ID for the player's current party / lobby / group. If this is not supplied, they player will not be in a party and the rest of the information will not be sent.

    .PARAMETER Size
    The current size of the players party / lobby / group.

    .PARAMETER Max
    The maxium size of the party / lobby / group. This is required to be larger than Size. If it is smaller than the current party size, it will automatically be set too Size when the presence is sent.

    .PARAMETER Privacy
    Privacy of the party

    .EXAMPLE
    $party = New-DisParty -Size 10 -Privacy Public -Max 100

#>
    [CmdletBinding()]
    param (
        [String]$ID = (New-Guid),
        [Int32]$Size,
        [Int32]$Max,
        [DiscordRPC.Party+PrivacySetting]$Privacy
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Party
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object.Id = $ID
        $object
    }
}