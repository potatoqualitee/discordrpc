function Update-DisButton {
    <#
    .SYNOPSIS
    Updates the Rich Presence button object.

    .DESCRIPTION
    Updates the Rich Presence button object.

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button.

    .PARAMETER Append
    Add a new button instead of replacing

    .EXAMPLE
    $button = New-DisButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $presence = New-DisRichPresence -Buttons $button

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$Label,
        [String]$Url,
        [Switch]$Append
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on client.CurrentPresence")) {
            try {
                $button = @()
                $button += New-DisButton @PSBoundParameters
                if ($Append) {
                    $button += $script:rpcclient.CurrentPresence.Buttons
                }
                Update-DisRichPresence -Buttons $button
            } catch {
                throw $_
            }
        }
    }
}