# discordrpc
Discord Rich Presence Client written in PowerShell

A Discord RPC Client which is used to send Rich Presence updates.



```powershell
$parms = @{
    ApplicationID  = "824593663883214948"
    LargeImageKey  = "psavatar"
    LargeImageText = "Summoners Rift"
    SmallImageKey  = "icon"
    SmallImageText = "Lvl 7"
    Label          = "Potato 🥔"
    Url            = "https://github.com/potatoqualitee/discordrpc"
    Details        = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
    State          = (Split-Path -Path $pwd -Leaf)
    LoggerType     = "ConsoleLogger"
    LoggerLevel    = "Info"
    TimerRefresh   = 10000
    Start          = "Now"
    ScriptBlock    = {
        Update-DSAsset -LargeImageText "Timer worked!" -SmallImageText "Lvl 10"
        Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
    }
}

Start-DSClient @parms
```