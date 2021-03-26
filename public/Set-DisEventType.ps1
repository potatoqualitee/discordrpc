function Set-DisEventType {
    <#

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [string]$None,
        [string]$Spectate,
        [string]$Join,
        [string]$JoinRequest
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.EventType")) {
            try {
                $object = New-Object -TypeName DiscordRPC.EventType
                $object.value__ = $value__
                $object.None = $None
                $object.Spectate = $Spectate
                $object.Join = $Join
                $object.JoinRequest = $JoinRequest
            } catch {
                throw $_
            }
        }
    }
}
