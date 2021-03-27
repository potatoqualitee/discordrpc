
try {
    Add-Type -Path (Resolve-Path -Path "C:\github\discordrpc\bin\net35\Newtonsoft.Json.dll") -ErrorAction Stop
    Add-Type -Path (Resolve-Path -Path "C:\github\discordrpc\bin\net35\DiscordRPC.dll") -ErrorAction Stop
} catch {
    throw $PSItem
}
#$client.Deinitialize(); $client.Dispose(); Get-EventSubscriber -SourceIdentifier Discord | Unregister-Event


import-module discordrpc -force
$assets = New-DisAsset -LargeImageKey psavatar -LargeImageText "Summoners Rift" -SmallImageKey icon -SmallImageText "Lvl 7"
$timestamp = New-DisTimestamp -Start (Get-Date).AddMinutes(-3) -End (Get-Date).AddMinutes(3)
$timestamp = [DiscordRPC.Timestamps]::Now
$button = New-DisButton -Label "Presence by PowerShell" -Url https://github.com/potatoqualitee/discordrpc/
$presence = New-DisRichPresence -Asset $assets -State "Playing PowerShell" -Details "Some details" -Timestamp $timestamp -Buttons $button
#$logger = New-DisLogger -Type ConsoleLogger -Level Info
$client = New-DisClient -ApplicationID 824593663883214948 -Presence $presence #-Logger $logger



$timestamp = [DiscordRPC.Timestamps]::FromTimeSpan(10)
Set-DisTimestamp -Timestamp $timestamp

$timer = New-Object System.Timers.Timer 5000
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