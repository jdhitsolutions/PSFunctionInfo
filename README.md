# PSFunctionInfo

## Synopsis

This module contains a set of PowerShell commands to add and manage metadata in stand-alone PowerShell functions.

## Installation

You can install a __prelease__ version of this module from the PowerShell Gallery. You may need to update the PowerShellGet module to allow installing prerelease modules.

```powershell
Install-Module PSFunctionInfo -AllowPrerelease
```

The module should work on both Windows PowerShell and PowerShell 7.x, even cross-platform.

## Description

The purpose of this code is to provide a way to get versioning and other metadata information for functions that may not belong to a module. This is information you want to get after the function has been loaded into your PowerShell session. I have numerous stand-alone functions. These functions don't belong to a module, so there is no version or source information. However, I'd like to use that type of information for non-module files.

The code in this module isn't concerned with loading, running, or finding functions. It queries whatever is in the `Function:` PSDrive. If the PowerShell function belongs to a module, then you'll get the module version and source. Otherwise, you can use the function metadata.

![Get a single function](assets/get-psfunctioninfo-1.png)

The default behavior is to show all functions that __don't__ belong to a module.

![Get stand-alone functions](assets/get-psfunctioninfo-2.png)

You can also get functions by tag. Use `Get-PSFunctionInfoTag` to get a list of tags currently in use.

![Get functions by tag](assets/get-psfunctioninfo-3.png)

## Creating PSFunctionInfo

Use the `New-PSFunctionInfo` command to insert the metadata tag into your script file.

```powershell
New-PSFunctionInfo -Path c:\scripts\Test-ConsoleColors.ps1 -Description "show console color combinations" -Name Test-ConsoleColor -Author "Jeff Hicks" -CompanyName "JDH IT Solutions" -Copyright "2021 JDH IT Solutions, Inc." -Tags "scripting","console"
```

The default behavior is to insert the metadata tag immediately after the opening brace ({) into the file. **This command will update the file**. Or you can use the `ToClipBoard` parameter which will copy the metatadata to the clipboard and you can manually insert it into your script file that defines the function.

You should get something like this:

```text

<# PSFunctionInfo

Version 1.0.0
Author Jeff Hicks
CompanyName JDH IT Solutions
Copyright 2021 JDH IT Solutions, Inc.
Description show console color combinations
Guid 8e43a9d9-1df6-48c7-8595-7363087aba43
Tags scripting,console
LastUpdate 4/21/2021 10:43 AM
Source C:\scripts\Test-ConsoleColors.ps1

#>
```

This command not work with functions defined in a single line like this:

```powershell
Function Get-Foo { Get-Date }
```

You can still run `New-PSFunctionInfo` with the `ToClipboard` parameter and manually edit your function to insert the metadata.

```powershell
Function Get-Foo {

<# PSFunctionInfo

Version 1.0.0
Author Jeff Hicks
CompanyName JDH IT Solutions
Copyright 2021 JDH IT Solutions, Inc.
Description Get Foo Stuff
Guid 490595c6-6a0c-4572-baf4-f808c010de70
Tags scripting,console
LastUpdate 4/21/2021 10:4f AM
Source C:\scripts\FooStuff.ps1

#>
    Get-Date
}
```

There are no commands to modify or remove function metadata. It is assumed that when you update the function, you can update or remove the metadata.

## Background

This code is a prototype for a [suggestion](https://github.com/PowerShell/PowerShell/issues/11667) I made for PowerShell 7. Early versions of this code were published as [https://gist.github.com/jdhitsolutions/65070cd51b5cfb572bc6375f67bcbc3d](https://gist.github.com/jdhitsolutions/65070cd51b5cfb572bc6375f67bcbc3d "view the Github gist")

## Roadmap

+ Add VS Code integration
+ Extract function metadata from files directly
+ Add function metadata by file, autodetecting the function name.

Last Updated 2021-04-21 15:57:36Z
