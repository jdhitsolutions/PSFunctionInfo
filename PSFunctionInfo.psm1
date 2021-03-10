
Get-ChildItem $PSScriptRoot\functions\*.ps1 | ForEach-Object {
    . $_.FullName
}
