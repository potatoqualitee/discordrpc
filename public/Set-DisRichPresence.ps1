function Set-DisRichPresence {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Buttons
    Parameter description

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
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
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.RichPresence")) {
            try {
                $object = New-Object -TypeName DiscordRPC.RichPresence
                $object.Buttons = $Buttons
                $object.State = $State
                $object.Details = $Details
                $object.Timestamps = $Timestamps
                $object.Assets = $Assets
                $object.Party = $Party
                $object.Secrets = $Secrets
            } catch {
                throw $_
            }
        }
    }
}
