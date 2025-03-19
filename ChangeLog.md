# ChangeLog for PSFunctionInfo

## [Unreleased]

## [1.5.0] - 2025-03-19

### Added

- Added a default formatted list view for `Get-PSFunctionInfo` output.
- Added a script property type extension for `PSFunctionInfo` objects to show `Age`.

### Changed

- Replaced bitly online help links
- Refined filtering regex for PSFunctionInfo objects to exclude functions that end in a colon. These are typically PSDrive shortcuts. __This is a potential breaking change.__
- Converted changelog to new format.
- Updated help documentation.

## [1.4.0] - 2024-01-22

### Changed

- Code cleanup
- Modified `Get-PSFunctionInfo` to sort functions by name.
- Help updates
- Updated `README`

### Added

- Added a warning to `Set-PSFunctionInfoDefaults` if the command is run without specifying any parameters.

## [1.3.0] - 2022-07-22

### Changed

- Updated missing online help links.
- Help documentation updates.
- Updated `README.md`.

## [1.2.0] - 2022-07-22

### Added

- Added custom error messages to `ValidateScript()` parameter attributes.
- Added a `NoSource` parameter to `New-PSFunctionInfo` to not include the source path.
- Added `Set-PSFunctionInfo` and its alias `spfi`.
- Added `Remove-PSFunctionInfo` and its alias `rpfi`.

### Changed

- Help updates.
- Updated `README.md`.

## [1.1.0] - 2022-03-15

### Added

- Added online help links.

### Updated

- Updated `README.md`.

### Fixed

- Fixed DefaultDisplayPropertySet in types.ps1xml file.

## [1.0.0] - 2020-10-02

First official release to the PowerShell Gallery.

### Added

- Added a property set called `TagInfo`.
- Added command `Edit-PSFunctionInfo` with an alias of `efpi`. ([Issue #7](https://github.com/jdhitsolutions/PSFunctionInfo/issues/7))
- Added better error handling to `Get-PSFunctionInfo` where function can't be found.

### Changed

- Restructured module layout.
- Help updates.
- Updated `README.md`.

## [0.6.0] - 2021-04-27

Preview release

### Added

- Added a `-Backup` parameter to `New-PSFunctionInfo`. ([Issue #1](https://github.com/jdhitsolutions/PSFunctionInfo/issues/1))
- Created private function `backup_file`.

### Changed

- Help updates
- Updated `README.md`.

### Fixed

- Fixed the `-Name` parameter argument completer in `Get-PSFunctionInfo`. The function parameter changed from `Name` to `FunctionName` which is why it broke. ([Issue #6](https://github.com/jdhitsolutions/PSFunctionInfo/issues/6))

## [0.5.0] - 2021-04-26

Preview release

### Added

- Added an auto completer for the `-Tag` parameter in `Get-PSFunctionInfo`. ([Issue #4](https://github.com/jdhitsolutions/PSFunctionInfo/issues/4))
- Added missing online help links.
- Added a table view called `tags` to `psfunctioninfo.format.ps1xml`.
- Added integration into the PowerShell ISE.
- Added a private function, `new_psfunctioninfo`, to create a new PSFunctionInfo object from the metadata block.
- Added integration into VS Code. ([Issue #2](https://github.com/jdhitsolutions/PSFunctionInfo/issues/2))

### Changed

- Changed `Name` parameter in `Get-PSFunctionInfo` to `FunctionName`. The parameter is positional, so it shouldn't make much difference. **This is a breaking change.**
- Modified `Get-PSFunctionInfo` to get metadata from files. ([Issue #3](https://github.com/jdhitsolutions/PSFunctionInfo/issues/3))
- Modified `PSFunctionInfo` class to not require Tags in the constructor.
- Modified `psfunctioninfo.format.ps1xml` to reduce the `Alias` column to 15.
- Updated help documentation.
- Updated `README.md`.

## [0.4.0] - 2021-04-22

Preview release

### Added

- Added `Set-PSFunctionInfoDefaults` and `Get-PSFunctionInfoDefaults` to store default values. The defaults are stored in a JSON file at `$home\psfunctioninfo-defaults.json`. If the file is found when the module is imported, it will be used to set $PSDefaultParameterValues for this module.
- Added `Update-PSFunctionInfoDefaults` which can be used to update defaults if they are changed after the module has been loaded.
- Added `about_PSFunctionInfo` help.

### Changed

- Minor help updates.
- Updated `README.md`.

## 0.3.0 - 2021-04-21

Preview release published to the PowerShell Gallery.

### Added

- Added online help links.

### Changed

- Updated `README.md`.

## 0.2.0 - 2021-04-21

### Added

- Added Verbose output to `Get-PSFunctionInfoTag`.
- Added an argument completer for the `Name` parameter of `Get-PSFunctionInfo`.
- Added alias `gpfi` for `Get-PSFunctionInfo`.
- Added alias `npfi` for `New-PSFunctionInfo`.

## Changed

- Modified `Source` view in `psfunctioninfo.format.ps1xml` to not limit the Description width.
- Updated `New-PSFunctionInfo` to better handle different function layouts.
- Help updates.
- Updated module manifest.
- Updated `README.md`.

## 0.1.0 - 2021-03-10

- initial module files

[Unreleased]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.5.0..HEAD
[1.5.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.4.0..v1.5.0
[1.4.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.3.0..v1.4.0
[1.3.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.1.0..v1.2.0
[1.1.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v1.0.0..v1.1.0
[1.0.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v0.6.0..v1.0.0
[0.6.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v0.5.0..v0.6.0
[0.5.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v0.4.0..v0.5.0
[0.4.0]: https://github.com/jdhitsolutions/PSFunctionInfo/compare/v0.3.0..v0.4.0