# PSFunctionInfo

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSFunctionInfo.png?style=plastic&logo=powershell&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSFunctionInfo/) ![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSFunctionInfo.png?style=plastic&&logo=powershell&label=Downloads)

## Synopsis

![documents](images/psfunctioninfo-icon.png)

This module contains a set of PowerShell commands to add and manage metadata in stand-alone PowerShell functions.

## Installation

You can install this module from the PowerShell Gallery.

```powershell
Install-Module PSFunctionInfo -Force [-scope CurrentUser]
```

Or using `PSResourceGet`:

```powershell
Install-PSResource PSFunctionInfo  [-scope CurrentUser]
```

The module should work on both Windows PowerShell and PowerShell 7, even cross-platform, except for a few PowerShell ISE related commands.

## Description

The purpose of this code is to provide a way to get versioning and other metadata information for functions that do not belong to a module. This is information you want to get after the function has been loaded into your PowerShell session. I have numerous stand-alone functions. These functions don't belong to a module, so there is no version or source information. However, I'd like to have that type of information for non-module functions.

The code in this module isn't concerned with loading, running, or finding functions. By default, [Get-PSFunctionInfo](docs/Get-PSFunctionInfo.md) queries whatever is in the `Function:` PSDrive. If the PowerShell function belongs to a module, then you'll get the module version and source. Otherwise, the command will use the function metadata.

![Get a single function](images/get-psfunctioninfo-1.png)

The default behavior is to show all functions that __don't__ belong to a module and excluding a few common functions that PowerShell defines.

![Get stand-alone functions](images/get-psfunctioninfo-2.png)

You can also get currently loaded functions by tag. Use `Get-PSFunctionInfoTag` to get a list of tags currently in use.

![Get functions by tag](images/get-psfunctioninfo-3.png)

The PSFunctionInfo object includes a PropertySet called `AuthorInfo`.

```dos
PS C:\> Get-PSFunctionInfo -Tag modules | Select-Object -property AuthorInfo

Name        : Test-HelpLink
Version     : 0.9.0
Source      : C:\scripts\update-helplinks.ps1
CompanyName : JDH IT Solutions, Inc.
Copyright   : (c) JDH IT Solutions, Inc.
Description : Test if help file is missing the online link
LastUpdate  : 4/23/2024 9:21:00 AM
```

Or you can use the `TagInfo` property set. This gives you the same result as using the `tag` named view with `Format-Table`.,

```powershell
Get-PSFunctionInfo | Select-Object taginfo
```

Finally, you can also search .ps1 files for PSFunctionInfo metadata.

![Get function info from file](images/get-psfunctioninfo-file.png)

## Creating PSFunctionInfo

Use the [New-PSFunctionInfo](docs/New-PSFunctionInfo.md) command to insert the metadata tag into your script file.

```powershell
New-PSFunctionInfo -Path c:\scripts\Test-ConsoleColors.ps1 -Description "show console color combinations" -Name Test-ConsoleColor -Author "Jeff Hicks" -CompanyName "JDH IT Solutions" -Copyright "2024 JDH IT Solutions, Inc." -Tags "scripting","console"
```

The default behavior is to insert the metadata tag immediately after the opening brace (`{`) into the file. __This command will update the file__. Or you can use the `ToClipBoard` parameter which will copy the metadata to the clipboard. You can then manually insert it into your script file that defines the function. You should avoid changing the formatting of the comment block.

You should get something like this:

```text

<# PSFunctionInfo

Version 1.0.0
Author Jeff Hicks
CompanyName JDH IT Solutions
Copyright 2024 JDH IT Solutions, Inc.
Description show console color combinations
Guid 8e43a9d9-1df6-48c7-8595-7363087aba43
Tags scripting,console
LastUpdate 2/22/2024 10:43 AM
Source C:\scripts\Test-ConsoleColors.ps1

#>
```

This command will __not work__ with functions defined in a single line like:

```powershell
Function Get-Foo { Get-Date }
```

However, you could run `New-PSFunctionInfo` with the `ToClipboard` parameter and manually edit your function to insert the metadata.

```powershell
Function Get-Foo {

<# PSFunctionInfo

Version 1.0.0
Author Jeff Hicks
CompanyName JDH IT Solutions
Copyright 2024 JDH IT Solutions, Inc.
Description Get Foo Stuff
Guid 490595c6-6a0c-4572-baf4-f808c010de70
Tags scripting,console
LastUpdate 2/21/2024 10:41 AM
Source C:\scripts\FooStuff.ps1

#>
    Get-Date
}
```

### Backup

Because creating a PSFunctionInfo metadata comment block modifies the file, you might feel safer with a file backup. `New-PSFunctionInfo` has a `-BackupParameter` which will create a backup copy of the source file before inserting the metadata comment block. The file will be created in the same directory, appending an extension of .bak1. If there are previous backups, the number will increment, i.e. .bak2. You have to manually delete the backup files.

The `-Backup` parameter has no effect if you use `-Clipboard`.

## PSFunctionInfo Defaults

Because you might define function metadata often and want to maintain consistency, you can define a set of default values for `New-PSFunctionInfo`. Use the command, [Set-PSFunctionInfoDefaults](docs/Set-PSFunctionInfoDefaults):

```powershell
Set-PSFunctionInfoDefaults -Tags "stand-alone" -Copyright "(c) JDH IT Solutions, Inc." -author "Jeff Hicks" -company "JDH IT Solutions, Inc."
```

The defaults will be stored in a JSON file (`$HOME\psfunctioninfo-defaults.json`). When you import this module, the values from this file will be used to define entries in `$PSDefaultParameterValues`. Or, run [Update-PSFunctionInfoDefaults](docs/Update-PSFunctionInfoDefaults) to update parameter defaults.

You can use [Get-PSFunctionInfoDefaults](docs/Get-PSFunctionInfoDefaults.md) to see the current values.

```powershell
PS C:\> Get-PSFunctionInfoDefaults

Version     : 0.9.0
CompanyName : JDH IT Solutions, Inc.
Author      : Jeffery Hicks
Tags        : {stand-alone}
Copyright   : (c) JDH IT Solutions, Inc.
```

## Editor Integration

When you import the module into an editor, you will get additional features to make it easier to insert PSFunctionInfo metadata into your file. It is recommended that you explicitly import the module into the editor's integrated console session. You could add an `Import-Module PSFunctionInfo` command into the editor's PowerShell profile script.

### Visual Studio Code

If you have an open file, in the integrated PowerShell console, you can run `New-PSFunctionInfo` and press <kbd>TAB</kbd> to tab-complete the detected functions in the current file. The file path will automatically be detected. You can enter other values such as version, or simply press <kbd>ENTER</kbd> to insert the metadata, which you can then edit.

![VSCode integration](images/psfunctioninfo-vscode.png)

This example is taking advantage of saved defaults. See [`Set-PSFunctionInfoDefaults`](docs/Set-PSFunctionInfoDefaults.md)

### PowerShell ISE

When you import the module in the PowerShell ISE, it will add a menu shortcut.

![ISE Menu](images/ise-psfunction-menu.png)

With a loaded file, you could run `New-PSFunctionInfo` in the console specifying the function name. The Path will be auto-detected. Or use the menu shortcut which will give you a graphical "function picker"

![function picker](images/ise-function-picker.png)

Select a function and click <kbd>OK</kbd>. The metadata block will be inserted into the file. This will not work with a file that has unsaved changes. When you insert new function metadata, the file in the ISE will be closed, re-opened and focus should jump to the function.

![ISE metadata](images/ise-psfunctioninfo.png)

### Editing Source Files

The module has a command called [Edit-PSFunctionInfo](docs/Edit-PSFunctionInfo.md) which will open a source file in your preferred editor. The command has an alias of `epfi`. The default editor selection is VS Code, but you can specify the PowerShell ISE or Notepad.

You can either specify a loaded function by name:

```powershell
Edit-PSFunctionInfo Get-QOTD
```

Or pipe to it.

```powershell
Get-PSFunctionInfo Get-QOTD | Edit-PSFunctionInfo -editor ise
```

Once opened, you will need to navigate to the appropriate function and metadata section.

It is assumed you will normally edit function metadata when editing the script file. But you can use [`Set-PSFunctionInfo](docs/Set-PSFunctionInfo.md) to make changes from the console.

```powershell
PS C:\> Set-PSFunctionInfo -Name Get-EventlogInfo -Path c:\work\LogTools.ps1 -Tags "profile,eventlog" -Version "1.2.1"
```

If you want to clear an existing value, set the parameter value to `$null`.

```powershell
PS C:\> Set-PSFunctionInfo -Name Get-EventlogInfo -Path c:\work\LogTools.ps1 -Source $null
```

## Background

This code is a prototype for a [suggestion](https://github.com/PowerShell/PowerShell/issues/11667) I made for PowerShell 7. Early versions of this code were published as [https://gist.github.com/jdhitsolutions/65070cd51b5cfb572bc6375f67bcbc3d](https://gist.github.com/jdhitsolutions/65070cd51b5cfb572bc6375f67bcbc3d "view the Github gist")

This module was first described at <https://jdhitsolutions.com/blog/powershell/8343/a-better-way-to-manage-powershell-functions/>.

## Related Modules

:bulb: You might also be interested in the [PSFunctionTools](https://github.com/jdhitsolutions/PSFunctionTools) module which contains a set of PowerShell 7 tools for automating and accelerating script and module development.

## Roadmap

- Add function metadata by file, auto-detecting the function name.
- Consider a bulk removal command to clean PSFunctionInfo metadata from files.
