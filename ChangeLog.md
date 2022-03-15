# ChangeLog for PSFunctionInfo

## 1.1.0

+ Fixed DefaultDisplayPropertySet in types.ps1xml file.
+ Added online help links.
+ Updated `README`.

## 1.0.0

+ Restructured module layout.
+ Added a property set called `TagInfo`.
+ Added command `Edit-PSFunctionInfo` with an alias of `efpi`. ([Issue #7](https://github.com/jdhitsolutions/PSFunctionInfo/issues/7))
+ Added better error handling to `Get-PSFunctionInfo` where function can't be found.
+ Help updates.
+ First official release to the PowerShell Gallery.
+ Updated `README.md`.

## 0.6.0-preview

+ Fixed the `-Name` parameter argument completer in `Get-PSFunctionInfo`. The function parameter changed from `Name` to `FunctionName` which is why it broke. ([Issue #6](https://github.com/jdhitsolutions/PSFunctionInfo/issues/6))
+ Created private function `backup_file`.
+ Added a `-Backup` parameter to `New-PSFunctionInfo`. ([Issue #1](https://github.com/jdhitsolutions/PSFunctionInfo/issues/1))
+ Help updates
+ Updated `README.md`.

## 0.5.0-preview

+ Added an autocompleter for the `-Tag` parameter in `Get-PSFunctionInfo`. ([Issue #4](https://github.com/jdhitsolutions/PSFunctionInfo/issues/4))
+ Added a private function, `new_psfunctioninfo`, to create a new PSFunctionInfo object from the metadata block.
+ Changed `Name` parameter in `Get-PSFunctionInfo` to `FunctionName`. The parameter is positional, so it shouldn't make much difference. **This is a breaking change.**
+ Modified `Get-PSFunctionInfo` to get metadata from files. ([Issue #3](https://github.com/jdhitsolutions/PSFunctionInfo/issues/3))
+ Modified `PSFunctionInfo` class to not require Tags in the constructor.
+ Added missing online help links.
+ Added a table view called `tags` to `psfunctioninfor.format.ps1xml`.
+ Modified `psfunctioninfor.format.ps1xml` to reduce the `Alias` column to 15.
+ Added integration into the PowerShell ISE.
+ Added integration into VS Code. ([Issue #2](https://github.com/jdhitsolutions/PSFunctionInfo/issues/2))
+ Updated help documentation.
+ Updated `README.md`.

## 0.4.0-preview

+ Added `Set-PSFunctionInfoDefaults` and `Get-PSFunctionInfoDefaults` to store default values. The defaults are stored in a JSON file at `$home\psfunctioninfo-defaults.json`. If the file is found when the module is imported, it will be used to set $PSDefaultParameterValues for this module.
+ Added `Update-PSFunctionInfoDefaults` which can be used to update defaults if they are changed after the module has been loaded.
+ Added `about_PSFunctionInfo` help.
+ Minor help updates.
+ Updated `README.md`.

## 0.3.0-preview

+ Added online help links.
+ Published pre-release module to the PowerShell Gallery.
+ Updated `README.md`.

## 0.2.0

+ Modified `Source` view in `psfunctioninfo.format.ps1xml` to not limit the Description width.
+ Updated `New-PSFunctionInfo` to better handle different function layouts.
+ Added Verbose output to `Get-PSFunctionInfoTag`.
+ Help updates.
+ Added an argument completer for the `Name` parameter of `Get-PSFunctionInfo`.
+ Added alias `gpfi` for `Get-PSFunctionInfo`.
+ Added alias `npfi` for `New-PSFunctionInfo`.
+ Updated module manifest.
+ Updated `README.md`.

## 0.1.0

+ initial module files
