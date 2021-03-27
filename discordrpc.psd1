﻿#
# Module manifest for module 'discordprc'
#
@{

    # Script module or binary module file associated with this manifest.
    RootModule         = 'discordrpc.psm1'

    # Version number of this module.
    ModuleVersion      = '0.0.1'

    # ID used to uniquely identify this module
    GUID               = '8b98fc3b-5e98-4816-a472-bf5ccef601e5'

    # Author of this module
    Author             = 'Chrissy LeMaire'

    # Copyright statement for this module
    Copyright          = 'Copyright (c) 2021, licensed under MIT'

    # Description of the functionality provided by this module
    Description        = "A Discord RPC Client which is used to send Rich Presence updates and receive Join / Spectate events."

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion  = '5.1'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules    = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @()

    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess   = @()

    # Functions to export from this module
    FunctionsToExport  = @(
        'New-DisAsset',
        'New-DisBaseRichPresence',
        'New-DisButton',
        'New-DisConfiguration',
        'New-DisDiscordRpcClient',
        'New-DisEventType',
        'New-DisParty',
        'New-DisRichPresence',
        'New-DisSecret',
        'New-DisTimestamp',
        'New-DisUser',
        'Set-DisAsset',
        'Set-DisBaseRichPresence',
        'Set-DisButton',
        'Set-DisConfiguration',
        'Set-DisDiscordRpcClient',
        'Set-DisEventType',
        'Set-DisParty',
        'Set-DisRichPresence',
        'Set-DisSecret',
        'Set-DisTimestamp',
        'Set-DisUser'
    )

    # Cmdlets to export from this module
    CmdletsToExport    = @()

    # Variables to export from this module
    VariablesToExport  = @()

    # Aliases to export from this module
    AliasesToExport    = @()

    PrivateData        = @{
        # PSData is module packaging and gallery metadata embedded in PrivateData
        # It's for rebuilding PowerShellGet (and PoshCode) NuGet-style packages
        # We had to do this because it's the only place we're allowed to extend the manifest
        # https://connect.microsoft.com/PowerShell/feedback/details/421837
        PSData = @{
            # The primary categorization of this module (from the TechNet Gallery tech tree).
            Category     = "Utilities"

            # Keyword tags to help users find this module via navigations and search.
            Tags         = @('discord','chat','discordrpc')

            # The web address of an icon which can be used in galleries to represent this module
            IconUri      = ""

            # The web address of this module's project or support homepage.
            ProjectUri   = "https://github.com/potatoqualitee/discordrpc"

            # The web address of this module's license. Points to a page that's embeddable and linkable.
            LicenseUri   = "https://opensource.org/licenses/MIT"

            # Release notes for this particular version of the module
            ReleaseNotes = ""

            # If true, the LicenseUrl points to an end-user license (not just a source license) which requires the user agreement before use.
            # RequireLicenseAcceptance = ""

            # Indicates this is a pre-release/testing version of the module.
            IsPrerelease = 'True'
        }
    }
}
