---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://bit.ly/3dFmdRb
schema: 2.0.0
---

# Get-PSFunctionInfo

## SYNOPSIS

Get metadata for stand-alone functions.

## SYNTAX

```yaml
Get-PSFunctionInfo [[-Name] <String>] [-Tag <String>] [<CommonParameters>]
```

## DESCRIPTION

Display function metadata. The default behavior is to display loaded functions that don't belong to a module. Items like versioning belong to the module, not the individual function.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSFunctionInfo

Name                      Version    Alias                Source
----                      -------    -----                ------
prompt
Get-QOTD                  2.0.0      qotd                 C:\scripts\Get-QOTD.ps1
Get-Status                2.1.0      gst                  C:\scripts\getstat.ps1
Get-StatusString          1.1.0      gss                  C:\scripts\getstat.ps1
Convert-Expression        1.0.0      spoof                C:\scripts\Convert-Expression.ps1
Add-BackupEntry           1.3.0      abe                  C:\scripts\PSBackup\Add-BackupEntry.ps1
Get-MyBackupFile          1.0.0      gbf                  C:\scripts\PSBackup\Get-MyBackupFile.ps1
ConvertTo-ASCIIArt                   cart
Test-IsAdministrator      1.0.0                           C:\Scripts\JDH-Functions.ps1
Open-VSCode               2.0.0      code                 C:\Scripts\JDH-Functions.ps1
...
```

### Example 2

```powershell
PS C:\> Get-PSFunctionInfo -name get* | Select Name,Source

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

Get function information by the function name.

### Example 3

```powershell
PS C:\> Get-PSFunctionInfo | Sort Source | Format-Table -View Source


   Source:

Name                      Version    Description
----                      -------    -----------
tm                                   profile-defined
Hide-Git                             profile-defined
Get-LogStamp                         profile-defined
dt                                   profile-defined
ConvertTo-ASCIIArt                   profile-defined
prompt


   Source: C:\scripts\Convert-Expression.ps1

Name                      Version    Description
----                      -------    -----------
Convert-Expression        1.0.0      Spoof command output


   Source: C:\Scripts\JDH-Functions.ps1

Name                      Version    Description
----                      -------    -----------
Get-DiskFree              1.0.0      My version of the df command
Get-ModifiedFile          1.1.0      find all files of modified within a given..
Get-LastFile              2.1.0      Get files sorted by last modified date
Get-LastBoot              1.0.0      Get the last boot up time
...
```

Use the custom table view called Source.

### Example 4

```powershell
PS C:\> Get-PSFunctionInfo -Tag cim

Name                      Version    Alias                Source
----                      -------    -----                ------
Get-Status                2.1.0      gst                  C:\scripts\getstat.ps1
Get-StatusString          1.1.0      gss                  C:\scripts\getstat.ps1
```

Get functions by tag.

### Example 5

```powershell
PS C:\> get-psfunctioninfo Get-qotd | Select-Object *

Name        : Get-QOTD
Version     : 2.0.0
Source      : C:\scripts\Get-QOTD.ps1
CompanyName : JDH IT Solutions
Copyright   : 2020
Description : Get a quote of the day
LastUpdate  : 5/21/2020 5:56:01 PM
Module      :
Path        : C:\scripts\Get-QOTD.ps1
Alias       : qotd
Author      : Jeff
Guid        : 16b5d672-4778-46d9-bbe5-08e7860e4e8a
Tags        : {Web,profile}
Commandtype : Function
```

Get all properties for a single function.

## PARAMETERS

### -Name

Specify the name of a loaded function.
The default is all functions that don't belong to a module.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: *
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Tag

Specify a tag

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSFunctionInfo

## NOTES

This function has an alias of gpfi.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[New-PSFunctionInfo](New-PSFunctionInfo.md)
