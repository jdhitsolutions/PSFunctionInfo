#
# Module manifest for module 'PSFunctionInfo'

@{

    RootModule           = 'PSFunctionInfo.psm1'
    ModuleVersion        = '1.5.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = 'fc506e57-f58e-44bb-b3a0-ec6f08d0c8f7'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2020-2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands to add metadata to stand-alone functions, i.e. those not published in a module. The commands in this module work in Windows PowerShell and PowerShell 7.'
    PowerShellVersion    = '5.1'
    TypesToProcess       = 'types\psfunctioninfo.types.ps1xml'
    FormatsToProcess     = 'formats\psfunctioninfo.format.ps1xml'
    FunctionsToExport    = @(
        'Get-PSFunctionInfo',
        'New-PSFunctionInfo',
        'Get-PSFunctionInfoTag',
        'Set-PSFunctionInfoDefaults',
        'Get-PSFunctionInfoDefaults',
        'Update-PSFunctionInfoDefaults',
        'Edit-PSFunctionInfo',
        'Set-PSFunctionInfo',
        'Remove-PSFunctionInfo'
    )
    AliasesToExport      = 'gpfi', 'npfi', 'epfi','spfi','rpf1'
    PrivateData          = @{
        PSData = @{
            Tags                     = @('function', 'scripting', 'profile')
            LicenseUri               = 'https://github.com/jdhitsolutions/PSFunctionInfo/blob/main/License.txt'
            ProjectUri               = 'https://github.com/jdhitsolutions/PSFunctionInfo'
            IconUri                  = 'https://raw.githubusercontent.com/jdhitsolutions/PSFunctionInfo/main/images/psfunctioninfo-icon.png'
            RequireLicenseAcceptance = $false
        } # End of PSData hashtable

    } # End of PrivateData hashtable

}

