function Set-DisTimestamp {
    <#
    .SYNOPSIS
    Sets properties for the timestamp structure representing the start and endtimes of a match.

    .DESCRIPTION
    Sets properties for the timestamp structure representing the start and endtimes of a match.

    .PARAMETER Timestamp

    .EXAMPLE
    An example

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [Parameter(Mandatory)]
        [DiscordRPC.Timestamps]$Timestamp
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on client.CurrentPresence")) {
            try {
                $prescence = $script:rpcclient.CurrentPresence
                if ($prescence) {
                    $prescence.Timestamps = $Timestamp
                    $script:rpcclient.SetPresence($presence)
                }
            } catch {
                throw $_
            }
        }
    }
}