function Update-DSButton {
    <#
    .SYNOPSIS
    Updates the Rich Presence button

    .DESCRIPTION
    Updates the Rich Presence button

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button

    .PARAMETER Append
    Add a new button instead of replacing

    .EXAMPLE
    $button = New-DSButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $presence = New-DSRichPresence -Buttons $button

#>
    [CmdletBinding()]
    param (
        [String]$Label,
        [String]$Url,
        [Switch]$Append
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DSClient or Start-DSClient"
        }
        try {
            $button = @()
            $button += New-DSButton @PSBoundParameters
            if ($Append) {
                $button += $script:rpcclient.CurrentPresence.Buttons
            }
            Update-DSRichPresence -Buttons $button
        } catch {
            throw $_
        }
    }
}