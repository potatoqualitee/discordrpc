<img align="left" src=https://user-images.githubusercontent.com/8278033/112738725-df8d9980-8f65-11eb-89ef-331e15fcf183.png alt="discordrpc logo">discordrpc is a Discord Rich Presence Client written in PowerShell.

Discord RPC is a library for interfacing your game with a locally running Discord desktop client. It's known to work on Windows, macOS, and Linux. 

have you ensured you have "Game Activity" enabled in your discord settings?

[discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)

```powershell
$parms = @{
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

## Installer

discordrpc works on PowerShell Core. This means that you can run all commands on <strong>Windows</strong>, <strong>Linux</strong> and <strong>macOS</strong>.

Run the following to install discordrpc from the PowerShell Gallery (to install on a server or for all users, remove the `-Scope` parameter and run in an elevated session):

```powershell
Install-Module discordrpc -Scope CurrentUser
```

## Add to profile

This is fast enough to add to your profile. `notepad $profile` then add your params and call the command

```powershell
$parms = @{
    LargeImageKey  = "psavatar"
    LargeImageText = "Summoners Rift"
    SmallImageKey  = "icon"
    SmallImageText = "Lvl 7"
    Details        = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
    State          = (Split-Path -Path $pwd -Leaf)
    Start          = "Now"
    ScriptBlock    = {
        # show the directory you are in
        Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
    }
}

Start-DSClient @parms
```

## Usage scenarios

- Deploy standardized implementations
- Manage Nessus and tenable.sc at scale
- Manage some objects that are not available in the web interface

## Usage examples

this and that

## Support

* PowerShell v5.1 and above
* Windows, macOS and Linux

# Simplified deployment

# Known Issues

I can't get the link to click. I don't know what's up.

# Reference

- [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/) these powershell commands wrap that library
- [Discord Developer Portal](https://discord.com/developers/applications/) want your own assets to set your own app name and icons? Create an app!
