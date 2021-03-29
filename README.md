<img align="left" src=https://user-images.githubusercontent.com/8278033/112738954-e3222000-8f67-11eb-8bcf-fa59b1daa3b1.png alt="discordrpc logo"><p>&nbsp;</p>discordrpc is a Discord Rich Presence Client written in PowerShell that allows you to change your presence to let people know that you're playing with PowerShell.

discordrpc works on PowerShell Core. This means that you can run all commands on <strong>Windows</strong>, <strong>Linux</strong> and <strong>macOS</strong>.

<p>&nbsp;</p>

After seeing the [Discord Presence](https://marketplace.visualstudio.com/items?itemName=icrawl.discord-vscode) plugin for VS Code, I was inspired to do something similar with PowerShell.

I made `discordrpc` as flexible as possible, so you can make your presence all your own, even changing the icons that show up. A wrapper command has also been included to make getting started easy.

<p align="center"><img src=./presence.png></p>

## Install

Ensure that Discord is running and that "Game Activity" enabled in your settings.

### Install from PowerShell Gallery

Run the following to install discordrpc from the PowerShell Gallery:

```powershell
Install-Module discordrpc -Scope CurrentUser
```

### Add to profile

`discordrpc` loads fast enough to add to your profile so everyone can always see when you're hanging out in PowerShell. Type `notepad $profile` then add these params and call the command.

```powershell
$params = @{
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

That will show results similar to the image above. Want to add your own integration? Let's take a look at YouTube and Plex.


## Image Options
The following images are available to use within your configuration. If you'd like me to add any more, let me know.

| Image                                                                                                                                     | Key    |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| <img src="https://user-images.githubusercontent.com/8278033/112764560-68114600-9009-11eb-8a38-4d0729579b5d.png" width="128" height="128"> | avatar |
| <img src="https://user-images.githubusercontent.com/8278033/112764591-837c5100-9009-11eb-910a-137a56e0277d.png" width="128" height="128"> | icon   |

## Highlights

* You don't just have to show up as Playing PowerShell, you can also select from a variety of templates within `Start-DSClient`
* If you don't find an application that matches your needs, you can [create your own application](https://discord.com/developers/applications/) and use your own title and "assets" or icons/images
* You can use the wrapper command for ease or use the underlying commands individually for granular control

## Usage examples

### Integrate with other apps

#### Twitch
Here's a sample for Twitch using my other module [tvbot](https://github.com/potatoqualitee/twitch).

```powershell
$stream = Get-TvStream
$username = $stream.UserName
$params = @{
    Template       = "Twitch"
    Details        = $stream.Title
    State          = "$($stream.ViewerCount) Viewers"
    Start          = $stream.StartedAt
    Label          = "Watch Stream"
    Url            = "https://twitch.tv/$username"
    TimerRefresh   = 30
    UpdateScript   = {
        if (-not (Get-TvStream)) {
            Stop-DSClient
        }
    }
}

Start-DSClient @params
```

If I'm livestreaming, it'll appear like this..

<p align="center"><img src=./twitch.png width="334" height="429"></p>

#### Bigger combo command

In the command below, you can use a custom [application ID](https://discord.com/developers/applications/), customize your timer, see info messages and more.

```powershell
$params = @{
    ApplicationID  = "824593663883214948"
    LargeImageKey  = "avatar"
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

This setup will show logs in the console, which is inconvenient unless you are debugging something.

#### Build your presence, step by step

Here's the code I used while testing the module. You can use this to see how different settings can change the presence.

```powershell
$assets = New-DSAsset -LargeImageKey avatar -LargeImageText "Summoners Rift" -SmallImageKey icon -SmallImageText "Lvl 7"
$timestamp = New-DSTimestamp -Start (Get-Date).AddMinutes(-3) -End (Get-Date).AddMinutes(3)
$button = New-DSButton -Label "Potato 🥔" -Url https://github.com/potatoqualitee/discordrpc
$party = New-DSParty -Size 10 -Privacy Public -Max 100
$presence = New-DSRichPresence -Asset $assets -State "presence.ps1" -Details "Some details" -Timestamp $timestamp -Buttons $button -Party $party
$logger = New-DSLogger -Type ConsoleLogger -Level Info
$client = New-DSClient -ApplicationID 824593663883214948 -Presence $presence -Logger $logger
```

#### See what other commands are available

```powershell
Get-Command -Module discordrpc
```

#### Get help

A lot of help has been included. If you want to know more about a command such as `New-DSLogger` run the following:

```powershell
Get-Help New-DSLogger
Get-Help New-DSLogger -Examples
```

# Known Issues

I can't get the potato link to click. I don't know what's up.

# Reference

Discord RPC is a library for interfacing your game with a locally running Discord desktop client. This PowerShell module wraps [Lachee's](https://github.com/Lachee) C# library, [discord-rpc-csharp](https://github.com/Lachee/discord-rpc-csharp/)


You can visit the [Discord Developer Portal](https://discord.com/developers/applications/) to learn more or create your own assets to set your own app name and icons. You'll need to change the `ApplicationID` to the client key you are provided.

When searching for a [list of Client IDs](https://github.com/potatoqualitee/discordrpc/blob/main/clientids.json) already available on Discord, I found the [PreMiD app](https://premid.app/), which is a mature product to show a bunch of rich presences (though not PowerShell). If you'd like to create your own Rich Presence for an app, the code in [their repo](https://github.com/PreMiD) may provide good strategies.