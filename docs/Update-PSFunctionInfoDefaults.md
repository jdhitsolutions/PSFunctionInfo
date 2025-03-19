---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://jdhitsolutions.com/yourls/065d5b
schema: 2.0.0
---

# Update-PSFunctionInfoDefaults

## SYNOPSIS

Refresh $PSDefaultParameterValues with PSFunctionInfo defaults.

## SYNTAX

```yaml
Update-PSFunctionInfoDefaults [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

You can store default values for PSFunctionInfo commands using Set-PSFunctionInfoDefaults. The data is stored in a JSON file at $home\psfunctioninfo-defaults.json. When you import the PSFunctionInfo module, this file will be imported and used to set entries in $PSDefaultParameterValues. If you modify the defaults, you can refresh your $PSDefaultParameterValues by running Update-PSFunctionInfoDefaults.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PSFunctionInfoDefaults -author "Gladys Kravitz"
PS C:\> Update-PSFunctionInfoDefaults
```

This example updates the default Author parameter value. The second command refreshes $PSDefaultParameterValues.

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

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Set-PSFunctionInfoDefaults](Set-PSFunctionInfoDefaults.md)

[Get-PSFunctionInfoDefaults](Get-PSFunctionInfoDefaults.md)
