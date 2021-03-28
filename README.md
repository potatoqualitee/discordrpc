<img align="left" src=https://user-images.githubusercontent.com/8278033/112738954-e3222000-8f67-11eb-8bcf-fa59b1daa3b1.png alt="discordrpc logo">discordrpc is a Discord Rich Presence Client written in PowerShell that allows you to change your presence to let people know that you're playing with PowerShell.

After seeing the [Discord Presence](https://marketplace.visualstudio.com/items?itemName=icrawl.discord-vscode) plugin for VS Code, I was inspired to do something similar with PowerShell.

![image](https://user-images.githubusercontent.com/8278033/112739127-094cbd80-8f72-11eb-9f01-4554c0387b2d.png)

I made it as flexible as possible, so you can make your presence all your own, even changing the icons that show up. Like most of the modules I write, I also included a wrapper command to make getting started easy.

## Sup
have you ensured you have "Game Activity" enabled in your discord settings?

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

Discord RPC is a library for interfacing your game with a locally running Discord desktop client.

[Lachee](https://github.com/Lachee) wrote [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)

- [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/) these powershell commands wrap that library
- [Discord Developer Portal](https://discord.com/developers/applications/) want your own assets to set your own app name and icons? Create an app!



[discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)