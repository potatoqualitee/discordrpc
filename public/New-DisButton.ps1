function New-DisButton {
    <#
    .SYNOPSIS
    Creates a Rich Presence button object.

    .DESCRIPTION
    Creates a Rich Presence button object.

    .PARAMETER Label
    Text shown on the button

    .PARAMETER Url
    The URL opened when clicking the button.

    .EXAMPLE
    An example

#>
    [CmdletBinding()]
    param (
        [String]$Label,
        [String]$Url
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Button
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}