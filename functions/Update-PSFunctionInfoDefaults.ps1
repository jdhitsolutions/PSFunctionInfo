Function Update-PSFunctionInfoDefaults {
    [cmdletbinding(SupportsShouldProcess)]
    Param( )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $defaults = Join-Path $home -ChildPath psfunctioninfo-defaults.json
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating PSDefaultParameterValues "
        if (Test-Path -Path $defaults) {
            $d = Get-Content -Path $defaults | ConvertFrom-Json
            $d.psobject.properties | ForEach-Object {
                if ($pscmdlet.ShouldProcess($_.name)) {
                    $global:PSDefaultParameterValues["New-PSFunctionInfo:$($_.name)"] = $_.value
                }
            }
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Update-PSFunctionInfoDefaults