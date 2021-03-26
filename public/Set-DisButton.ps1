function Set-DisButton {
    <#

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
