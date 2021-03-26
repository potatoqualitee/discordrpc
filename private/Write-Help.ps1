Function Write-Help {
    function Get-Header ($text) {
        $start = $text.IndexOf('<#')
        $text.SubString(0, $start - 2)
    }

    function Format-Help ($text) {
        $name = $file.basename
        $command = Get-Command $name
        $verb = $command.Verb
        $noun = $command.Noun.TrimStart("Dis")
        $noun = ($noun -csplit "([A-Z][a-z]+)" | Where-Object { $_ }) -join " "
        $noun = $noun.ToLower()
        $params = $command.parameters.keys | Where-Object { $_ -notin [System.Management.Automation.PSCmdlet]::CommonParameters }

        switch ($verb) {
            "Add" {
                $synopsis = "$($verb)s a list of $($noun.ToLower())s"
            }
            "Connect" {
                $synopsis = "$($verb)s to a Nessus or tenable.sc server"
            }
            "ConvertFrom" {
                $synopsis = "Converts Nessus and tenable.sc responses to a readable format"
            }
            "Copy" {
                $synopsis = "Copies a list of $($noun)s"
            }
            "Initalize" {
                $synopsis = "Initalizes a new Nessus or tenable.sc server with username/password and license"
            }
            "New" {
                $synopsis = "Creates new $($noun)s"
            }
            "Wait" {
                $synopsis = "Waits for a Nessus server to be ready"
            }
            "Set" {
                $synopsis = "Sets properties for $($noun)s"
            }
            default {
                # Get, Disable, Edits, Enables, Exports
                $synopsis = "$($verb)s a list of $($noun)s"
            }
        }

        "    .SYNOPSIS
        $synopsis

    .DESCRIPTION
        $synopsis
        "

        foreach ($param in $params) {
            switch ($param) {
                "EnableException" {
                    $description = "By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
        This avoids overwhelming you with 'sea of red' exceptions, but is inconvenient because it basically disables advanced scripting.
        Using this switch turns this 'nice by default' feature off and enables you to catch exceptions with your own try/catch."
                }
                "ComputerName" {
                    $description = "The network name or IP address of the Nessus or tenable.sc server"
                }
                "Port" {
                    $description = "The port of the Nessus or tenable.sc server. Defaults to 8834 which is the default port for Nessus."
                }
                "Credential" {
                    $description = "The credential object (from Get-Credential) used to log into the target server. Specifies a user account that has permission to send the request. "
                }
                "UseDefaultCredential" {
                    $description = "Indicates that the command uses the credentials of the current user to send the web request. This can't be used with Authentication or Credential and may not be supported on all platforms."
                }
                "AcceptSelfSignedCert" {
                    $description = "Accept self-signed certs"
                }
                "SessionObject" {
                    $description = "Optional parameter to force using specific SessionObjects. By default, each command will connect to all connected servers that have been connected to using Connect-TNServer"
                }
                "PolicyId" {
                    $description = "The ID of the target policy"
                }
                "PolicyUUID" {
                    $description = "The UUID of the target policy"
                }
                "PluginId" {
                    $description = "The ID of the target plugin"
                }
                "FamilyId" {
                    $description = "The ID of the target family"
                }
                "ScanId" {
                    $description = "The ID of the target scan"
                }
                "UserId" {
                    $description = "The ID of the target user"
                }
                "GroupId" {
                    $description = "The ID of the target group"
                }
                "RuleId" {
                    $description = "The ID of the target rule"
                }
                "Email" {
                    $description = "The email address of the target user"
                }
                "Name" {
                    $description = "The name of the target $($noun.ToLower())"
                }
                "Type" {
                    $description = "The type of $($noun.ToLower())"
                }
                "FileName" {
                    $description = "The filename of the target $($noun.ToLower())"
                }
                "Organization" {
                    $description = "The name of the target organization"
                }
                "Password" {
                    $description = "The required password. This is a securestring type. The easiest way to get this is by using (Get-Credential).Password which extracts the password in a secure manner (and does not care about the username.)"
                }
                default {
                    $description = "Description for $param"
                }
            }

            "    .PARAMETER $param
        $description
        "
        }

        "    .EXAMPLE
        PS C:\> $name

        $synopsis
        "
    }

    function Get-Body ($text) {
        $end = $text.IndexOf('#>')
        $text.SubString($end, $text.Length - $end)
    }

    $files = Get-ChildItem -Recurse C:\github\discord\public\New-DisAssets.ps1

    foreach ($file in $files.FullName) {
        write-warning "$file"
        $text = ($file | Get-Content -Raw).Trim()
        Set-Content -Path $file.FullName -Encoding UTF8 -Value (Get-Header $text).TrimEnd()
        Add-Content -Path $file.FullName -Encoding UTF8 -Value "<#".Trim()
        Add-Content -Path $file.FullName -Encoding UTF8 -Value (Format-Help $text)
        Add-Content -Path $file.FullName -Encoding UTF8 -Value (Get-Body $text).TrimEnd() -NoNewline
    }
}