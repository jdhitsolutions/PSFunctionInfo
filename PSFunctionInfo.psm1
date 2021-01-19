
Get-ChildItem $PSScriptRoot\functions\*.ps1 | foreach-Object {
    . $_.FullName
}

Update-TypeData -typeName PSFunctionInfo -MemberType ScriptProperty -MemberName Alias -Value { (Get-Alias -Definition $this.Name -ErrorAction SilentlyContinue).name } -force

<#
PS C:\> Get-PSFunctionInfo get* | Where author

Name                                Version    Source                         Module
----                                -------    ------                         ------
Get-QOTD                            1.0.0      C:\scripts\Get-QOTD.ps1
Get-Status                          1.0.0      C:\scripts\getstat.ps1
Get-UTCString                       1.0.0      C:\scripts\JDH-Functions.ps1
Get-DiskFree                        1.0.0      C:\scripts\JDH-Functions.ps1
Get-LastBoot                        1.0.0      C:\scripts\JDH-Functions.ps1
Get-MyFunctions                     1.0.0      C:\scripts\JDH-Functions.ps1
Get-PSFunctionInfo                  2.1.0      C:\scripts\PSFunctionInfo.ps1

PS C:\> get-psfunctioninfo get-qotd | select *


Name        : Get-QOTD
Version     : 1.0.0
Source      : C:\scripts\Get-QOTD.ps1
CompanyName : JDH IT Solutions
Copyright   : 2020
Description : Get a quote of the day
LastUpdate  : 1/27/2020 11:46:19 AM
Module      :
Author      : Jeff
Guid        : 16b5d672-4778-46d9-bbe5-08e7860e4e8a
Tags        : {Web,profile}
Commandtype : Function

PS C:\> get-psfunctioninfo get-f*

Name                                Version    Source                         Module
----                                -------    ------                         ------
Get-FileHash                        3.1.0.0    Microsoft.PowerShell.Utility   Microsoft.PowerShell.Utility
Get-Foo                             1.0.0      d:\temp\foo.ps1

#>


