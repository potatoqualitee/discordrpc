function Clear-DisTimestamp {
    <#
    .SYNOPSIS
    Sets the start and end time of CurrentPresence to null and sends it to Discord

    .DESCRIPTION
    Sets the start and end time of CurrentPresence to null and sends it to Discord

    .EXAMPLE
    Clear-DisTimestamp

    Clears the timestamp

#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on Timestamp")) {
            try {
                $null = $script:rpcclient.UpdateClearTime()
                $script:rpcclient.CurrentPresence
            } catch {
                throw $_
            }
        }
    }
}
