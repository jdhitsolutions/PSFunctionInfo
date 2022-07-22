---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version:
schema: 2.0.0
---

# Remove-PSFunctionInfo

## SYNOPSIS

Remove PSFunctoinInfo metatdata.

## SYNTAX

```yaml
Remove-PSFunctionInfo [-FunctionName] <String> -Path <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this function to remove the PSFunctionInfo metadata for a given function.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-PSFunctionInfo Test-Eventlog -path c:\work\eventlogtools.ps1
```

Remove the entry for the given function.

### Example 2

```powershell
PS C:\> Get-PSFunctioninfo -Path c:\work\tools.ps1 | Remove-PSFunctionInfo
```

Get PSFUnctionInfo for all functions from the specified file and remove them. This assumes that every function has a source value that reflects c:\work\tools.ps1. Otherwise, you could specify the Path parameter with Remove-PSFunctionInfo.

## PARAMETERS

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

### -FunctionName

Specify the name of a function that doesn't belong to a module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specify the source .ps1 file for the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases: fullname, source

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[Set-PSFunctionInfo](Set-PSFunctionInfo.md)

[Get-PSFunctionInfo](Get-PSFunctionInfo.md)
