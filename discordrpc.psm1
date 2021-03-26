$script:ModuleRoot = $PSScriptRoot
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

# Import all internal functions
foreach ($function in (Get-ChildItem "$ModuleRoot\private\" -Filter "*.ps1" -Recurse -ErrorAction Ignore)) {
    . Import-ModuleFile -Path $function.FullName
}

# Import all public functions
foreach ($function in (Get-ChildItem "$ModuleRoot\public" -Filter "*.ps1" -Recurse -ErrorAction Ignore)) {
    . Import-ModuleFile -Path $function.FullName
}

if ( -not (Test-Path variable:Script:NessusConn )) {
    $script:NessusConn = New-Object System.Collections.ArrayList
}

$PSDefaultParameterValues['*:UseBasicParsing'] = $true
$PSDefaultParameterValues['*:TimeoutSec'] = 300

Register-ArgumentCompleter -ParameterName Tool -CommandName New-TNQuery -ScriptBlock {
    param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
    $list = "alertName"
    $list | Where-Object { $PSItem -like "$WordToComplete*" } | Select-Object -Unique | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($PSItem, $PSItem, "ParameterName", $PSItem)
    }
}
