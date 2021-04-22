# ChangeLog for PSFunctionInfo

## 0.4.0

+ Added `Set-PSFunctionInfoDefaults` and `Get-PSFunctionInfoDefaults` to store default values. The defaults are stored in a JSON file at `$home\psfunctioninfo-defaults.json`. If the file is found when the module is imported, it will be used to set $PSDefaultParameterValues for this module.
+ Added `Update-PSFunctionInfoDefaults` which can be used to update defaults if they are changed after the module has been loaded.
+ Added `about_PSFunctionInfo` help.
+ Minor help updates.
+ Updated `README.md`.

## 0.3.0

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
