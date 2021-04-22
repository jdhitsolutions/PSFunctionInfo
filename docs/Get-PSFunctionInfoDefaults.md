---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version:
schema: 2.0.0
---

# Get-PSFunctionInfoDefaults

## SYNOPSIS

Get defined PSFunctionInfo defaults.

## SYNTAX

```yaml
Get-PSFunctionInfoDefaults [<CommonParameters>]
```

## DESCRIPTION

You can store default values for PSFunctionInfo commands using Set-PSFunctionInfoDefaults. The data is stored in a JSON file at $home\psfunctioninfo-defaults.json. Use Get-PSFunctionInfoDefaults to view.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSFunctionInfoDefaults


Version     : 0.9.0
CompanyName : JDH IT Solutions, Inc.
Author      : Jeffery Hicks
Tags        : {stand-alone}
Copyright   : (c) JDH IT Solutions, Inc.
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSFunctionInfoDefault

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSFunctionInfoDefaults](Set-PSFunctionInfoDefaults.md)

[Update-PSFunctionInfoDefaults](Update-PSFunctionInfoDefaults.md)