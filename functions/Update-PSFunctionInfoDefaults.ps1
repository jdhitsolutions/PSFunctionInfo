Function Update-PSFunctionInfoDefaults {
    [CmdletBinding(SupportsShouldProcess)]
    Param()

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        $defaults = Join-Path $home -ChildPath psfunctioninfo-defaults.json
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating PSDefaultParameterValues "
        if (Test-Path -Path $defaults) {
            $d = Get-Content -Path $defaults | ConvertFrom-Json
            $d.PSObject.properties | ForEach-Object {
                if ($PSCmdlet.ShouldProcess($_.name)) {
                    $global:PSDefaultParameterValues["New-PSFunctionInfo:$($_.name)"] = $_.value
                }
            }
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Update-PSFunctionInfoDefaults
