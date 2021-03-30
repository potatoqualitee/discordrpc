function New-DSButton {
    <#
    .SYNOPSIS
    Creates a Rich Presence button object

    .DESCRIPTION
    Creates a Rich Presence button object

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button

    .EXAMPLE
    $button = New-DSButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $presence = New-DSRichPresence -Buttons $button

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$Label,
        [Parameter(Mandatory)]
        [String]$Url
    )
    process {

        if ($Label.Length -gt 31) {
            $PSBoundParameters.Label = $Label.SubString(0,30)
        }
        $object = New-Object -TypeName DiscordRPC.Button
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}