function New-DisLogger {
    <#
    .SYNOPSIS
    Logs the outputs to console or file

    .DESCRIPTION
    Logs the outputs to console or file

    .PARAMETER Type
    The type of logger: ConsoleLogger or FileLogger

    ConsoleLogger logs the outputs to the console
    FileLogger logs the outputs to the console

    .PARAMETER Level
     The level of logging: Trace, Info, None, Error, Warning

    .PARAMETER Path
     The path to the log file when the Type is FileLogger

    .PARAMETER ColorOutput
     Colors the output when the Type is ConsoleLogger

    .EXAMPLE
    $logger = New-DisLogger -Type ConsoleLogger -Level Error
    New-DisClient -ApplicationID 12345678901234567 -Logger $logger

#>
    [CmdletBinding()]
    param (
        [ValidateSet("ConsoleLogger","FileLogger")]
        [String]$Type,
        [ValidateSet("Trace","Info","None","Error","Warning")]
        [String]$Level = "Info",
        [String]$Path,
        [Switch]$ColorOutput
    )
    process {
        if ($Type -eq "ConsoleLogger") {
            if ($Path) {
                throw "Path can only be used with FileLogger"
            }
            New-Object -TypeName DiscordRPC.Logging.ConsoleLogger $Level, $ColorOutput
        } else {
            if ($ColorOutput) {
                throw "ColorOutput can only be used with ConsoleLogger"
            }
            New-Object -TypeName DiscordRPC.Logging.ConsoleLogger $Path, $Level
        }
    }
}