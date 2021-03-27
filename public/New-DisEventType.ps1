function New-DisEventType {
    <#
    .SYNOPSIS
    Creates a new XXX object

    .DESCRIPTION
    Creates a new XXX object

    .PARAMETER None
    Parameter description

    .PARAMETER Spectate
    Parameter description

    .PARAMETER Join
    Parameter description

    .PARAMETER JoinRequest
    Parameter description

    .EXAMPLE
    An example

#>
    [CmdletBinding()]
    param (
        [string]$None,
        [string]$Spectate,
        [string]$Join,
        [string]$JoinRequest
    )
    process {
        $object = New-Object -TypeName DiscordRPC.EventType
        foreach ($key in ($PSBoundParameters.Keys | Where-Object { $PSItem -notin [System.Management.Automation.PSCmdlet]::CommonParameters })) {
            $object.$key = $PSBoundParameters[$key]
        }
        $object
    }
}