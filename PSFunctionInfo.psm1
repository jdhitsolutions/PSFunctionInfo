
Get-ChildItem $PSScriptRoot\functions\*.ps1 | ForEach-Object {
    . $_.FullName
}


Register-ArgumentCompleter -CommandName Get-PSFunctionInfo -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    #PowerShell code to populate $wordtoComplete
    Get-Childitem -path Function:\$wordToComplete* |
        ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.name)
        }
}