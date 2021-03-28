<img align="left" src=https://user-images.githubusercontent.com/8278033/112738954-e3222000-8f67-11eb-8bcf-fa59b1daa3b1.png alt="discordrpc logo">discordrpc is a Discord Rich Presence Client written in PowerShell that allows you to change your presence to let people know that you're playing with PowerShell.

discordrpc works on PowerShell Core. This means that you can run all commands on <strong>Windows</strong>, <strong>Linux</strong> and <strong>macOS</strong>.

After seeing the [Discord Presence](https://marketplace.visualstudio.com/items?itemName=icrawl.discord-vscode) plugin for VS Code, I was inspired to do something similar with PowerShell.

I made `discordrpc` as flexible as possible, so you can make your presence all your own, even changing the icons that show up. Like most of the modules I write, I also included a wrapper command to make getting started easy.

This is what mine looked like while testing:

<p align="center"><img src=https://user-images.githubusercontent.com/8278033/112739127-094cbd80-8f72-11eb-9f01-4554c0387b2d.png></p>


## Installer

Run the following to install discordrpc from the PowerShell Gallery:

```powershell
Install-Module discordrpc -Scope CurrentUser
```

### Add to profile

`discordrpc` loads fast enough to add to your profile so everyone can always see when you're hanging out in PowerShell. Type `notepad $profile` then add these params and call the command.

```powershell
$params = @{
    LargeImageKey  = "psavatar"
    LargeImageText = "Summoners Rift"
    SmallImageKey  = "icon"
    SmallImageText = "Lvl 7"
    Details        = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
    State          = (Split-Path -Path $pwd -Leaf)
    Start          = "Now"
    UpdateScript   = {
        # show the directory you are in. you can do anything here.
        Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
    }
}

Start-DSClient @params
```

## More advanced

```powershell
$params = @{
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
    UpdateScript   = {
        Update-DSAsset -LargeImageText "Timer worked!" -SmallImageText "Lvl 10"
        Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
    }
}

Start-DSClient @params
```

## Usage scenarios

- Deploy standardized implementations
- Manage Nessus and tenable.sc at scale
- Manage some objects that are not available in the web interface

## Usage examples

this and that

# Simplified deployment

# Known Issues

I can't get the link to click. I don't know what's up.

# Reference

Discord RPC is a library for interfacing your game with a locally running Discord desktop client.

[Lachee](https://github.com/Lachee) wrote [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)

- [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/) these powershell commands wrap that library
- [Discord Developer Portal](https://discord.com/developers/applications/) want your own assets to set your own app name and icons? Create an app!



[discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)