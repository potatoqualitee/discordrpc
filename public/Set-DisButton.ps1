function Set-DisButton {
    <#
    .SYNOPSIS
     Sets properties for a Rich Presence button.

    .DESCRIPTION
     Sets properties for a Rich Presence button.

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$Label,
        [String]$Url
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Button")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Button
                $object.Label = $Label
                $object.Url = $Url
            } catch {
                throw $_
            }
        }
    }
}
