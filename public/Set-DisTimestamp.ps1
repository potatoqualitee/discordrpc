function Set-DisTimestamp {
    <#

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [datetime]$Start,
        [datetime]$End,
        [uint64]$StartUnixMilliseconds,
        [uint64]$EndUnixMilliseconds
    )
    process {
        if ($Pscmdlet.ShouldProcess("Setting properties on DiscordRPC.Timestamps")) {
            try {
                $object = New-Object -TypeName DiscordRPC.Timestamps
                $object.Start = $Start
                $object.End = $End
                $object.StartUnixMilliseconds = $StartUnixMilliseconds
                $object.EndUnixMilliseconds = $EndUnixMilliseconds
            } catch {
                throw $_
            }
        }
    }
}
