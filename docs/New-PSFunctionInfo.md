---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version: https://bit.ly/3avf181
schema: 2.0.0
---

# New-PSFunctionInfo

## SYNOPSIS

Create function metadata

## SYNTAX

```yaml
New-PSFunctionInfo [-Name] <String> -Path <String> [-Author <String>] [-CompanyName <String>] [-Copyright <String>] [-Description <String>]
[-Version <String>] [-Guid <Guid>] [-Tags <String[]>] [-Updated <DateTime>] [-ToClipboard] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will create a function metadata comment block and insert it into the source script file. Or you can copy it to the clipboard and insert it yourself. There are no commands to modify or remove the function metatdata once it has been inserted into the file. It is assumed that if you update the function, you can manually update (or remove) the metadata at the same time.

NOTE: This command will not work properly with one-line function declarations like Function Get-This { Get-Date }. It is also expected that you don't have multiple versions of the function in the same file.

Do not modify spacing or formatting of the function metadata.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PSFunctionInfo -Path c:\scripts\Test-ConsoleColors.ps1 -Description "show console color combinations" -Name Test-ConsoleColor -Author "Jeff Hicks" -CompanyName "JDH IT Solutions" -Copyright "2021 JDH IT Solutions, Inc." -Tags "scripting","console"
```

Insert function metadata into the script file before the [cmdletbinding()] tag. This example will produce this comment block:

PSFunctionInfo

Version 1.0.0

Author Jeff Hicks

CompanyName JDH IT Solutions

Copyright 2021 JDH IT Solutions, Inc.

Description show console color combinations

Guid e07e256e-a2d6-4acc-a1cf-5d8d1be7db27

Tags scripting,console

LastUpdate 10/02/2020 10:34:18

Source C:\Scripts\Test-ConsoleColors.ps1

### Example 2

```powershell
PS C:\> New-PSFunctionInfo -Path c:\scripts\Test-ConsoleColors.ps1 -Description "show console color combinations" -Name Test-ConsoleColor -Author "Jeff Hicks" -CompanyName "JDH IT Solutions" -Copyright "2021 JDH IT Solutions, Inc." -Tags "scripting","console" -toclipboard
```

This will create the same metadata as the first example. Except it will be copied to the clipboard and not to the file.

## PARAMETERS

### -Author

Specify the function author.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user name
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyName

Specify a company or organization.

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

Specify a copyright for the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: the current year
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specify a brief function description.

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

### -Guid

The metadata requires a GUID. This is set automatically.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: a newly created Guid
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specify name of the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specify the path to the .ps1 file that contains the function. The path must end in .ps1.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Specify an array of optional tags.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToClipboard

Copy the metadata to the clipboard.
The file is left untouched.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: clip

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Updated

Specify a datetime. The default is the current date and time. When manually updating, you should use a command like Get-Date -format g. Whatever date format you use, the string must be able to be treated as a [datetime] object.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current date and time.
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version

Specify a version number. It is recommended to use a standard version numbering system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1.0.0
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

This function has an alias of npfi.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSFunctionInfo](Get-PSFunctionInfo.md)
