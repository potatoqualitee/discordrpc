function Set-DisConfiguration {
    <#
    .SYNOPSIS
    Creates a new XXX object

    .DESCRIPTION
    Creates a new XXX object

    .PARAMETER ApiEndpoint
    The Discord API endpoint that should be used

    .PARAMETER CdnHost
    The CDN endpoint

    .PARAMETER Enviroment
    The type of enviroment the connection on. Usually Production.

    .EXAMPLE
    An example

    .NOTES
    General notes
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [String]$ApiEndpoint,
        [String]$CdnHost,
        [String]$Enviroment
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Configuration")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Configuration
                $object.ApiEndpoint = $ApiEndpoint
                $object.CdnHost = $CdnHost
                $object.Enviroment = $Enviroment
            } catch {
                throw $_
            }
        }
    }
}
