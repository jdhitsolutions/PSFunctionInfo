---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://bit.ly/2QgCu6g
schema: 2.0.0
---

# Set-PSFunctionInfoDefaults

## SYNOPSIS

Store default values for PSFunctionInfo commands.

## SYNTAX

```yaml
Set-PSFunctionInfoDefaults [[-Author] <String>] [[-CompanyName] <String>]
[[-Copyright] <String>] [[-Version] <String>] [[-Tags] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Because you might define function metadata often, and want to maintain consistency, you can define a set of default values for New-PSFunctionInfo.  Set-PSFunctionInfoDefaults will create a JSON file at $home\psfunctioninfo-defaults.json. When you import this module, these values will be used to define entries in $PSDefaultParameterValues. Or, run Update-PSFunctionInfoDefaults to update parameter defaults.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PSFunctionInfoDefaults -Copyright "(c) JDH IT Solutions, Inc." -author "Jeff Hicks" -company "JDH IT Solutions, Inc."
```

## PARAMETERS

### -Author

Enter the default author name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CompanyName

Enter the default company name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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

Enter the default copyright string.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tags

Enter the default tag(s).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Version

Enter the default version.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

### System.String[]

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSFunctionInfoDefaults](Get-PSFunctionInfoDefaults.md)

[Update-PSFunctionInfoDefaults](Update-PSFunctionInfoDefaults.md)
