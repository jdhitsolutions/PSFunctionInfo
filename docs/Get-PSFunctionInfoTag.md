---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://bit.ly/3atA4ba
schema: 2.0.0
---

# Get-PSFunctionInfoTag

## SYNOPSIS

Get a list of function tags.

## SYNTAX

```yaml
Get-PSFunctionInfoTag [<CommonParameters>]
```

## DESCRIPTION

PSFunctionInfo metadata can contain tags. Get-PSFunctionInfoTag will create a list of all tags currently in use. The tag list is built from the functions currently loaded into your PowerShell session.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSFunctionInfoTag
backup
cim
console
directory
git
powershellget
profile
secrets
Web
```

Get a list of current tags.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSFunctionInfo](Get-PSFunctionInfo.md)
