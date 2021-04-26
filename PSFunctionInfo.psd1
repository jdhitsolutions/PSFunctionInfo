#
# Module manifest for module 'PSFunctionInfo'

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSFunctionInfo.psm1'

# Version number of this module.
ModuleVersion = '0.5.0'

# Supported PSEditions
CompatiblePSEditions = @('Desktop','Core')

# ID used to uniquely identify this module
GUID = 'fc506e57-f58e-44bb-b3a0-ec6f08d0c8f7'

# Author of this module
Author = 'Jeff Hicks'

# Company or vendor of this module
CompanyName = 'JDH Information Technology Solutions, Inc.'

# Copyright statement for this module
Copyright = '(c) 2020-2021 JDH Information Technology Solutions, Inc.'

# Description of the functionality provided by this module
Description = 'A set of PowerShell commands to add metadata to stand-alone functions.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = 'types\psfunctioninfo.types.ps1xml'

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'formats\psfunctioninfo.format.ps1xml'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-PSFunctionInfo', 'New-PSFunctionInfo','Get-PSFunctionInfoTag','Set-PSFunctionInfoDefaults','Get-PSFunctionInfoDefaults','Update-PSFunctionInfoDefaults'

# Variables to export from this module
#VariablesToExport = ''

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'gpfi','npfi'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("function","scripting","profile")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/jdhitsolutions/PSFunctionInfo/blob/main/License.txt'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/jdhitsolutions/PSFunctionInfo'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        Prerelease = '-preview'

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

