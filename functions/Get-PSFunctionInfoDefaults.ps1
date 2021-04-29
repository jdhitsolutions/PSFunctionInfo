Function Get-PSFunctionInfoDefaults {
    [cmdletbinding()]
    [outputtype("PSFunctionInfoDefault")]

    Param( )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $Outfile = Join-Path $home -ChildPath psfunctioninfo-defaults.json
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Testing $outfile"
        If (Test-Path -Path $outfile) {
            Get-Content -Path $outfile | ConvertFrom-Json |
            ForEach-Object {
                $_.psobject.typenames.insert(0, 'PSFunctionInfoDefault')
                $_
            }
        }
        else {
            Write-Warning "No default file found at $outfile. Use Set-PSFunctionInfoDefaults to create it."
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Get-PSFunctionInfoDefaults