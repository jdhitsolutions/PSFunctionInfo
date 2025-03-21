Get-ChildItem $PSScriptRoot\functions\*.ps1 | ForEach-Object {
    . $_.FullName
}

#load defaults if found
$defaults = Join-Path $home -ChildPath psfunctioninfo-defaults.json
if (Test-Path -path $defaults) {
    $d = Get-Content -Path $defaults | ConvertFrom-JSON
    $d.PSObject.properties | Foreach-Object {
        $global:PSDefaultParameterValues["New-PSFunctionInfo:$($_.name)"] = $_.value
    }
}

#region Add VSCode Shortcuts
if ($host.name -eq 'Visual Studio Code Host') {
    $global:PSDefaultParameterValues["New-PSFunctionInfo:Path"] = {$PSEditor.GetEditorContext().CurrentFile.Path}

    #create an argument completer for the Name parameter
    Register-ArgumentCompleter -CommandName New-PSFunctionInfo -ParameterName Name -ScriptBlock {
        param($commandName, $parameterName, $WordToComplete, $commandAst, $fakeBoundParameter)

        #PowerShell code to populate $WordToComplete
        $ASTTokens = $PSEditor.GetEditorContext().CurrentFile.tokens
        $NameList = @()
        for ($i=0;$i -lt $ASTTokens.count;$i++) {
            if ($ASTTokens[$i].text -eq 'function') {
                $NameList+= $ASTTokens[$i+1].text
            }
        }
        $NameList | Where-Object {$_ -like "$WordToComplete*"} |
            ForEach-Object {
                # completion text,listItem text,result type,Tooltip
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
    }
}
elseif ($host.name -eq 'Windows PowerShell ISE Host') {
    #create shortcut for the ISE
    $global:PSDefaultParameterValues["New-PSFunctionInfo:Path"] = {$PSIse.CurrentFile.FullPath}

    #add a menu item
    $sb = {
        Function PickList {
            # A WPF function picker for the PowerShell ISE
            Param([string[]]$Name)

            $title = "New-PSFunctionInfo"

            $form = New-Object System.Windows.Window
            #define what it looks like
            $form.Title = $Title
            $form.Height = 200
            $form.Width = 300
            $form.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen

            $grid = New-Object System.Windows.Controls.Grid

            $label = New-Object System.Windows.Controls.Label
            $label.Content = "Select a function from the list and click OK."
            $label.HorizontalAlignment = "left"
            $label.VerticalAlignment = "top"
            $grid.AddChild($label)

            $combo = New-Object System.Windows.Controls.ListBox
            $combo.AllowDrop = $true

            $combo.Width = 160
            $combo.Height = 75
            $combo.HorizontalAlignment = "left"
            $combo.VerticalAlignment = "top"
            $combo.Margin = "15,25,0,0"

            foreach ($item in $Name) {
                [void]$combo.items.Add($item)
            }
            $combo.SelectedIndex = 0

            $grid.AddChild($combo)
            #initialize an array to hold all processed objects

            $ok = New-Object System.windows.controls.button
            $ok.Content = "_OK"
            $ok.IsDefault = $True
            $ok.Width = 75
            $ok.Height = 25
            $ok.HorizontalAlignment = "left"
            $ok.Margin = "25,100,0,0"
            $OK.Add_Click( {
                    $global:SelectedPickItem = $combo.SelectedItem
                    #$combo.SelectedItem | Out-Default
                    $form.Close()
                })
            $grid.AddChild($ok)

            $cancel = New-Object System.Windows.Controls.Button
            $cancel.Content = "_Cancel"
            $cancel.Width = 75
            $cancel.Height = 25
            #$cancel.HorizontalAlignment = "right"
            $cancel.Margin = "150,100,0,0"
            $cancel.Add_Click( {
                    $form.Close()
                })

            $grid.AddChild($cancel)

            $form.AddChild($grid)
            [void]($form.ShowDialog())
        }

        if ($PSIse.CurrentFile.IsSaved) {
            $Path = $PSIse.CurrentFile.FullPath

            New-Variable ASTTokens -Force
            New-Variable astErr -Force
            $AST = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$ASTTokens, [ref]$astErr)

            $file = [System.Collections.Generic.list[string[]]]::new()
            Get-Content $path | ForEach-Object { $file.Add($_) }

            $name = @()
            for ($i = 0; $i -lt $ASTTokens.count; $i++) {
                if ($ASTTokens[$i].text -eq 'function') {
                    $name += $ASTTokens[$i + 1].text
                }
            } #for
            if ($name) {
                Remove-Variable -Name SelectedPickItem -ErrorAction SilentlyContinue
                PickList -name $name
                #| Out-GridView -Title "Select a function" -OutputMode Single

                if ($SelectedPickItem) {
                    New-PSFunctionInfo -Name $SelectedPickItem -path $path

                    $idx = $file.findIndex( { $args[0] -match "[Ff]unction(\s+)$SelectedPickItem" })
                    $idx++
                    #save and re-open the file
                    [void]$PSIse.CurrentPowerShellTab.files.Remove($PSIse.CurrentFile)
                    [void]$PSIse.CurrentPowerShellTab.Files.Add($path)
                    $r = $PSIse.CurrentPowerShellTab.Files.where( { $_.FullPath -eq $path })
                    $r.Editor.Focus()

                    if ($idx -ge 0) {
                        $r.Editor.SetCaretPosition($idx, 1)
                        $r.Editor.SelectCaretLine()
                        $r.Editor.EnsureVisible($idx)
                    }
                }
            } #if names found
            else {
                [System.Windows.MessageBox]::Show("No matching functions found in $Path", "New-PSFunctionInfo", "OK", "Information")
            }
        } #if saved
        else {
            [System.Windows.MessageBox]::Show("Please save your file first:$Path and then try again.", "New-PSFunctionInfo", "OK", "Warning")
        }
    }

    $PSIse.CurrentPowerShellTab.AddOnsMenu.Submenus.add("New-PSFunctionInfo", $sb, $Null)
}
#endregion

#region create argument completers
Register-ArgumentCompleter -CommandName Get-PSFunctionInfo -ParameterName FunctionName -ScriptBlock {
    param($commandName, $parameterName, $WordToComplete, $commandAst, $fakeBoundParameter)

    Get-ChildItem -path "Function:\$WordToComplete*" |
        ForEach-Object {
            # completion text,listItem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.name)
        }
}

Register-ArgumentCompleter -CommandName Get-PSFunctionInfo -ParameterName Tag -ScriptBlock {
    param($commandName, $parameterName, $WordToComplete, $commandAst, $fakeBoundParameter)

    (Get-PSFunctionInfoTag).where({$_ -like "$WordToComplete*"}) |
        ForEach-Object {
            # completion text,listItem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
#endregion

#region type extensions

Update-TypeData -TypeName PSFunctionInfo -MemberType ScriptProperty -MemberName Age -Value {
    New-TimeSpan -Start $this.LastUpdate -end (Get-Date)
} -Force

#endregion