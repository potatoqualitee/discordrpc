function Set-DisButton {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Label
    Parameter description

    .PARAMETER Url
    Parameter description

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
