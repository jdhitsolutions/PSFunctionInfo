Function Get-PSFunctionInfoDefaults {
    [CmdletBinding()]
    [OutputType("PSFunctionInfoDefault")]

    Param()
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        $OutFile = Join-Path $home -ChildPath psfunctioninfo-defaults.json
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Testing $OutFile"
        If (Test-Path -Path $OutFile) {
            Get-Content -Path $OutFile | ConvertFrom-Json |
            ForEach-Object {
                $_.PSObject.TypeNames.insert(0, 'PSFunctionInfoDefault')
                $_
            }
        }
        else {
            Write-Warning "No default file found at $OutFile. Use Set-PSFunctionInfoDefaults to create it."
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Get-PSFunctionInfoDefaults
