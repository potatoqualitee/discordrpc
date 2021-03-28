$script:ModuleRoot = $PSScriptRoot


Add-Type -Path (Resolve-Path -Path "$PSScriptRoot\bin\net35\Newtonsoft.Json.dll") -ErrorAction Stop
Add-Type -Path (Resolve-Path -Path "$PSScriptRoot\bin\net35\DiscordRPC.dll") -ErrorAction Stop

function Import-ModuleFile {
    [CmdletBinding()]
    Param (
        [string]$Path
    )

    if ($doDotSource) { . $Path }
    else {
        $ExecutionContext.InvokeCommand.InvokeScript($false, ([scriptblock]::Create([io.file]::ReadAllText($Path))), $null, $null)
    }
}

# Detect whether at some level dotsourcing was enforced
if ($discord_dotsourcemodule) { $script:doDotSource }

# Import all public functions
foreach ($function in (Get-ChildItem "$ModuleRoot\public" -Filter "*.ps1" -Recurse -ErrorAction Ignore)) {
    . Import-ModuleFile -Path $function.FullName
}

$script:clientids = Get-Content (Resolve-Path "$PSScriptRoot\clientids.json") | ConvertFrom-Json

Register-ArgumentCompleter -ParameterName Template -CommandName Start-DSClient -ScriptBlock {
    param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
    $script:clientids.Product | Where-Object { $PSItem -like "$WordToComplete*" } | Select-Object -Unique | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($PSItem, $PSItem, "ParameterName", $PSItem)
    }
}

if ($global:discordrpcclient) {
    $script:rpcclient = $global:discordrpcclient
}