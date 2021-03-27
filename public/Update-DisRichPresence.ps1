function Update-DisRichPresence {
    <#
    .SYNOPSIS
    Sets information about the pictures used in the Rich Presence.

    .DESCRIPTION
    Sets information about the pictures used in the Rich Presence.

    .PARAMETER InputObject
    The presence object

    .EXAMPLE
    $timestamp = [DiscordRPC.Timestamps]::Now
    $button = New-DisButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
    $params = @{
        Timestamp = $timestamp
        Buttons = $button
    }
    Update-DisRichPresence @params

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    param (
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Button[]]$Buttons,
        [Parameter(ValueFromPipeline)]
        [String]$State,
        [Parameter(ValueFromPipeline)]
        [String]$Details,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Timestamps]$Timestamps,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Assets]$Assets,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Party]$Party,
        [Parameter(ValueFromPipeline)]
        [DiscordRPC.Secrets]$Secrets
    )
    process {
        if (-not $script:rpcclient) {
            throw "Please New-DisClient or Start-DisClient"
        }
        if ($Pscmdlet.ShouldProcess("Setting properties on client.CurrentPresence")) {
            $prescence = $script:rpcclient.CurrentPresence

            if (-not $Buttons) {
                $Buttons = $prescence.Buttons
            }
            if (-not $State) {
                $State = $prescence.State
            }
            if (-not $Details) {
                $Details = $prescence.Details
            }
            if (-not $Timestamps) {
                $Timestamps = $prescence.Timestamps
            }
            if (-not $Assets) {
                $Assets = $prescence.Assets
            }
            if (-not $Party) {
                $Party = $prescence.Party
            }
            if (-not $Secrets) {
                $Secrets = $prescence.Secrets
            }

            $params = @{
                Buttons    = $Buttons
                State      = $State
                Details    = $Details
                Timestamps = $Timestamps
                Assets     = $Assets
                Party      = $Party
                Secrets    = $Secrets
            }

            $newprescence = New-DisRichPresence @params
            try {
                $script:rpcclient.SetPresence($newprescence)
                $null = $script:rpcclient.SynchronizeState()
                $script:rpcclient.CurrentPresence
            } catch {
                throw $_
            }
        }
    }
}