function Set-DisConfiguration {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER ApiEndpoint
    Parameter description

    .PARAMETER CdnHost
    Parameter description

    .PARAMETER Enviroment
    Parameter description

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
