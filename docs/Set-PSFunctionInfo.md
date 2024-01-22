---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://bit.ly/3OBoaxi
schema: 2.0.0
---

# Set-PSFunctionInfo

## SYNOPSIS

Set PSFunctionInfo values.

## SYNTAX

```yaml
Set-PSFunctionInfo [-FunctionName] <String> -Path <String> [-Version <String>] [-Author <String>] [-CompanyName <String>] [-Copyright <String>] [-Description <String>] [-Tags <String>] [-Source <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Normally, if you want to update an existing PSFunctionInfo metadata entry, you would do this while editing the file. However, you could use this command to make changes from the command prompt. If you want to remove a setting, use $Null as the parameter value. The LastUpdate value will be automatically updated to reflect the current date and time.

If you update the metadata, you won't see any changes until you manually reload the function into your PowerShell session.

. (Get-PSFunctionInfo Get-EventlogInfo).Source

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PSFunctionInfo -Name Get-EventlogInfo -Path c:\work\LogTools.ps1 -Tags "profile,eventlog" -Version "1.2.1"
```

Update PSFunctionInfo for the Get-EventlogInfo function in the specified file.

### Example 2

```powershell
PS C:\> Set-PSFunctionInfo -Name Test-Eventlog -Path c:\work\LogTools.ps1 -Source $null
```

Clear the PSFunctionInfo Source value for the Test-Eventlog function.

## PARAMETERS

### -Author

Specify the new author.

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

### -CompanyName

Specify the new company information.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Copyright

Specify the new copyright information.

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

### -Description

Specify the new description. This should be a single line of text.

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

### -FunctionName

Specify the name of a function that doesn't belong to a module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Path

Specify  the .ps1 file that contains the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases: fullname

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Source

Specify the new Source.

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

### -Tags

Specify the new tags as a comma-separated string.
This will replace existing tags.

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

### -Version

Specify the new version number.

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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSFunctionInfo](Get-PSFunctionInfo.md)

[Edit-PSFunctionInfo](Edit-PSFunctionInfo.md)

[Remove-PSFunctionInfo](Remove-PSFunctionInfo.md)
