
try {
    Add-Type -Path (Resolve-Path -Path "C:\github\discordrpc\bin\net35\Newtonsoft.Json.dll") -ErrorAction Stop
    Add-Type -Path (Resolve-Path -Path "C:\github\discordrpc\bin\net35\DiscordRPC.dll") -ErrorAction Stop
} catch {
    throw $PSItem
}
#$client.Deinitialize(); $client.Dispose(); Get-EventSubscriber -SourceIdentifier Discord | Unregister-Event

$client = New-Object DiscordRpc.DiscordRpcClient 824593663883214948
$presence = New-Object DiscordRPC.RichPresence
$timer = New-Object System.Timers.Timer 5000

$assets = New-Object DiscordRPC.Assets
$assets.LargeImageKey = "psavatar"
$assets.LargeImageText = "Whaaat"
$assets.SmallImageKey = "icon"


#$presence.Buttons = ""
$presence.State = "Playing PowerShell"
$presence.Details = "Some details"
#$presence.Timestamps = New-Object DiscordRPC.Timestamps (Get-Date)
$presence.Assets = $assets
#$client.UpdateClearTime()

$client.SetPresence($presence)
$client.Initialize()

$timer.Enabled = $true
$timer.AutoReset = $true

# timers require global variables
$global:timervars = [pscustomobject]@{
    Client   = $client
    Presence = $presence
}
$null = Register-ObjectEvent -InputObject $timer -EventName Elapsed -SourceIdentifier Discord -Action {
    $global:timervars.Presence.State = "Playing PowerShell"
    $global:timervars.Presence.Details = (Get-Date)
    $global:timervars.Presence.Timestamps = New-Object DiscordRPC.Timestamps (Get-Date)
    $global:timervars.Presence.Assets = $assets
    $global:timervars.Client.SetPresence($global:timervars.Presence)
}

$timer.Start()