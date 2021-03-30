function Stop-DSClient {
    <#
    .SYNOPSIS
    Stops the client and removes the rich presence

    .DESCRIPTION
    Stops the client and removes the rich presence

    .EXAMPLE
    Stop-DSClient

    Stops the client
#>
    [CmdletBinding()]
    param ()
    process {
        if (-not $script:rpcclient) {
            throw "No client running"
        }
        $null = $script:rpcclient.ClearPresence()
        $null = $script:rpcclient.Deinitialize
        $null = $script:rpcclient.Dispose()
        Remove-Variable -Scope Global -Name discordrpcclient -ErrorAction Ignore
        Remove-Variable -Scope Script -Name rpcclient -ErrorAction Ignore
        $global:discordrpcclient = $script:rpcclient = $null

        if (Get-EventSubscriber -SourceIdentifier Discord -ErrorAction Ignore) {
            $null = Get-EventSubscriber -SourceIdentifier Discord -ErrorAction Ignore | Unregister-Event
        }
    }
}