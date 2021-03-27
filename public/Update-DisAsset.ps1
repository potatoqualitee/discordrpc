function Update-DisAsset {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence.

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence.

    .PARAMETER InputObject
    Parameter description

    .EXAMPLE
    An example

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [Parameter(Mandatory)]
        [DiscordRPC.Assets]$Asset
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on client.CurrentPresence")) {
            try {
                $prescence = $script:rpcclient.CurrentPresence
                if ($prescence) {
                    $prescence.Assets = $Asset
                    $script:rpcclient.SetPresence($presence)
                }
            } catch {
                throw $_
            }
        }
    }
}
