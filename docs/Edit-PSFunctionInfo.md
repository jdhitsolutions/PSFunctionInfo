---
external help file: PSFunctionInfo-help.xml
Module Name: PSFunctionInfo
online version:
schema: 2.0.0
---

# Edit-PSFunctionInfo

## SYNOPSIS

Open a source file in your preferred editor.

## SYNTAX

### name (Default)

```yaml
Edit-PSFunctionInfo [-Name] <String> [-Editor <String>] [<CommonParameters>]
```

### source

```yaml
Edit-PSFunctionInfo [-Source <String>] [[-Name] <String>] [-Editor <String>] [<CommonParameters>]
```

## DESCRIPTION

You can use Edit-PSFunctionInfo to open the source file for a given function with PSFunctionInfo metadata. You can either specify a loaded function by name, or pipe a Get-PSFunctionInfo expression to Edit-PSFunctionInfo. Once the function is opened in the editor, you will need to navigate to the function itself.

The editor choices are VS Code, PowerShell ISE, or Notepad. Of course they are also dependent on your operating system and if you have installed it.

## EXAMPLES

### Example 1

```powershell
PS C:\> Edit-PSFunctionInfo -name Set-Title -editor ise
```

Open the source file for the Set-Title function and open in the PowerShell ISE.

### Example 2

```powershell
PS C:\> Get-PSFunctionInfo *git* | Edit-PSFunctionInfo
```

Get all functions with git in the name and edit them with the default editor.

## PARAMETERS

### -Editor

Specify the editor you want to use.
On non-Windows systems enter the value in lower case.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: code, ise, notepad

Required: False
Position: Named
Default value: code
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The name of a loaded function, presumably with PSFunctionInfo metadata.

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: source
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specify the path to the source file.

```yaml
Type: String
Parameter Sets: source
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### None

## NOTES

This command has an alias of epfi.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSFunctionInfo](Get-PSFunctionInfo.md)

[New-PSFunctionInfo](New-PSFunctionInfo.md)