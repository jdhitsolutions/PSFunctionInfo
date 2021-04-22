
Get-ChildItem $PSScriptRoot\functions\*.ps1 | ForEach-Object {
    . $_.FullName
}

#load defaults if found
$defaults = Join-Path $home -ChildPath psfunctioninfo-defaults.json
if (Test-Path -path $defaults) {
    $d = Get-Content -Path $defaults | ConvertFrom-JSON
    $d.psobject.properties | Foreach-Object {
        $global:PSDefaultParameterValues["New-PSFunctionInfo:$($_.name)"] = $_.value
    }
}

#create an argument completer
Register-ArgumentCompleter -CommandName Get-PSFunctionInfo -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Childitem -path Function:\$wordToComplete* |
        ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.name)
        }
}