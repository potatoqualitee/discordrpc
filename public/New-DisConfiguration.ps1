function New-DisConfiguration {
    <#
    .SYNOPSIS
    Creates the configuration of the current RPC connection

    .DESCRIPTION
    Creates the configuration of the current RPC connection

    .PARAMETER ApiEndpoint
    The Discord API endpoint that should be used

    .PARAMETER CdnHost
    The CDN endpoint

    .PARAMETER Enviroment
    The type of enviroment the connection on. Usually Production.

    .EXAMPLE
    New-DisConfiguration -ApiEndpoint https://asdfadf.com -CdnHost https://asdfasdf -Enviroment Production

    Creates a new endpoint object

#>
    [CmdletBinding()]
    param (
        [String]$ApiEndpoint,
        [String]$CdnHost,
        [String]$Enviroment
    )
    process {
        $object = New-Object -TypeName DiscordRPC.Configuration
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}