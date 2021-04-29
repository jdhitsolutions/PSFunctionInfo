Function Edit-PSFunctionInfo {
    [cmdletbinding(DefaultParameterSetName="name")]
    [Outputtype("None")]
    [Alias("epfi")]
    Param(
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName,HelpMessage = "Specify the path to the source file.",ParameterSetName="source")]
        [ValidateNotNullOrEmpty()]
        [string]$Source,
        [parameter(HelpMessage = "Specify the name of a loaded function.")]
        [Parameter(Mandatory,Position=0,ParameterSetName="name")]
        [string]$Name,
        [Parameter(HelpMessage = "Specify the editor you want to use. On non-Windows systems enter the value in lower case.")]
        [ValidateSet("code","ise","notepad")]
        [string]$Editor = "code"
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"

        Switch ($Editor) {
            "code" {
                $EditorName = "VSCode"
                Try {
                    #need to allow for VSCode cross-platform
                    if ($IsCoreCLR -AND (-Not $IsWindows)) {
                        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Testing for VS Code on non-Windows platforms"
                        $cmd = (Get-Command -Name code -ErrorAction stop).name
                    }
                    else {
                        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Testing for VS Code on Windows platforms"
                        $cmd =(Get-Command -Name code.cmd -ErrorAction stop).name
                    }
                    $editorOK = $True
                    if ($host.name -eq "Visual Studio Code Host") {
                        #use the internal psedit command
                        $sb = [scriptblock]::Create('Param($path) psedit $path')
                    }
                    else {
                        $sb = [scriptblock]::Create("Param(`$path) $cmd `$path")
                    }
                }
                Catch {
                    $editorOK = $False
                }
            }
            "ise" {
                $EditorName = "PowerShell ISE"
                Try {
                    Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Testing for the PowerShell ISE"
                    [void](Get-Command -Name powershell_ise.exe -ErrorAction stop)
                    $editorOK = $True
                    if ($host.name -eq "Windows PowerShell ISE Host") {
                        #use the internal psedit command
                        $sb = [scriptblock]::Create('Param($path) psedit $path')
                    }
                    else {
                        $sb = [scriptblock]::Create('Param($path) powershell_ise.exe $path')
                    }
                }
                Catch {
                    $editorOK = $False
                }
            }
            "notepad" {
                $EditorName = "Notepad"
                Try {
                    Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Testing for Notepad."
                    [void](Get-Command -Name "notepad.exe" -ErrorAction stop)
                    $editorOK = $True
                    $sb = [scriptblock]::Create('Param($path) notepad.exe $path')
                }
                Catch {
                    $editorOK = $False
                }
            }
        } #switch
        If (-Not $editorOK) {
            Write-Warning "Failed to find $EditorName."
        }
    } #begin

    Process {
        if ($Name) {
            Try {
                $f = Get-PSFunctionInfo -functionname $Name -ErrorAction Stop
                $source = $f.source
            }
            Catch {
                Write-Warning "Can't find a function called $Name."
            }
        }

        If ((Test-Path -path $source) -AND $editorOK) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Opening $Source in $EditorName"
            Invoke-Command -ScriptBlock $sb  -ArgumentList $source
        }
        else {
            Write-Warning "Failed to load function source."
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Edit-PSFunctionInfo