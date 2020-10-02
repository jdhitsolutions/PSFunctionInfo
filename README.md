# PSFunctionInfo

## Synopsis

This module contains a set of PowerShell commands to add and manage metadata in stand-alone PowerShell functions.

## Description

The purpose of this code is to provide a way to get version and other metadata information for functions loaded into your PowerShell session that may not belong to a module. I have a number of stand-alone functions and I'd like to have version and source information. The code isn't concerned with loading, running or finding functions. It queries whatever is in the Function: psdrive. If the function belongs to a module, then I'll use the module version and source. Otherwise, I want to be able to define the metadata.

![Get a single function](assets/get-psfunctioninfo-1.png)

The default behavior is to show all functions that __don't__ belong to a module.

![Get stand-alone functions](assets/get-psfunctioninfo-2.png)

This code is a prototype for a [suggestion](https://github.com/PowerShell/PowerShell/issues/11667) I made for PowerShell 7.
