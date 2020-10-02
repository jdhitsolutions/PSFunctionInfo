---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version:
schema: 2.0.0
---

# Get-PSFunctionInfo

## SYNOPSIS

Get metadata for stand-alone functions

## SYNTAX

### name (Default)

```yaml
Get-PSFunctionInfo [[-Name] <String>] [<CommonParameters>]
```

### all

```yaml
Get-PSFunctionInfo [-All] [<CommonParameters>]
```

## DESCRIPTION

Display function metadata. The default behavior is to display loaded functions that don't belong to a module. Items like versioning belong to the module, not the individual function.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSFunctionInfo

Name                           Version    Source                         Module
----                           -------    ------                         ------
Get-QOTD                       2.0.0      C:\scripts\Get-QOTD.ps1
Tee-MyObject                   1.0.0      C:\scripts\Tee-MyObject.ps1
Publish-Project                2.3.0      C:\scripts\Publish-Project.ps1
Get-Status                     1.2.0      C:\scripts\getstat.ps1
Out-Copy                       2.0.0      C:\scripts\Out-Copy.ps1
Convert-Expression             1.0.0      C:\scripts\Convert-Expression…
Add-BackupEntry                1.1.0      C:\scripts\PSBackup\Add-Backu…
Get-UTCString                  2.0.0      C:\scripts\JDH-Functions.ps1
Set-FunctionDescription        1.0.0      C:\scripts\JDH-Functions.ps1
Start-GitBash                  1.0.0      C:\scripts\JDH-Functions.ps1
Get-DiskFree                   1.0.0      C:\scripts\JDH-Functions.ps1
Test-IsAdministrator           1.0.0      C:\scripts\JDH-Functions.ps1
dw                             1.1.0      C:\scripts\JDH-Functions.ps1
Set-Title                      1.0.0      C:\scripts\JDH-Functions.ps1
Save-Title                     1.0.0      C:\scripts\JDH-Functions.ps1
Get-LastBoot                   1.0.0      C:\scripts\JDH-Functions.ps1
Get-ModifiedFile               1.1.0      C:\scripts\JDH-Functions.ps1
Get-MyFunctions                1.0.0      C:\scripts\JDH-Functions.ps1
```

### Example 2

```powershell
PS C:\> Get-PSFunctionInfo get* | Select Name,Source

Name             Source
----             ------
Get-QOTD         C:\scripts\Get-QOTD.ps1
Get-Status       C:\scripts\getstat.ps1
Get-UTCString    C:\Scripts\JDH-Functions.ps1
Get-DiskFree     C:\Scripts\JDH-Functions.ps1
Get-LastBoot     C:\Scripts\JDH-Functions.ps1
Get-ModifiedFile C:\Scripts\JDH-Functions.ps1
Get-MyFunctions  C:\Scripts\JDH-Functions.ps1
```

## PARAMETERS

### -All

Get all functions regardless of whether or not they belong to a module.

```yaml
Type: SwitchParameter
Parameter Sets: all
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specify the name of a loaded function.
The default is all functions that don't belong to a module.

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSFunctionInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[New-PSFunctionInfo](New-PSFunctionInfo.md)
