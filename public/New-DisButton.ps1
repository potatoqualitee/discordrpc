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

    .NOTES
    General notes
#>
    [CmdletBinding()]
    param (
        [String]$Label,
        [String]$Url
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Button
        if ($PSBoundParameters.Count) {
            foreach ($param in $PSBoundParameters) {
                $key = $param.Keys
                if ($key -and $param.Values) {
                    $object.$key = $param.Values
                }
            }
        }
        $object
    }
}