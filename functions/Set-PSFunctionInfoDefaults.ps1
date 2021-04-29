<#
Version $Version
Author $Author
CompanyName $CompanyName
Copyright $Copyright
Description $Description
Guid $Guid
Tags $($Tags -join ",")
LastUpdate $Updated
Source $(Convert-Path $Path)
#>

Function Set-PSFunctionInfoDefaults {
    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(ValueFromPipelineByPropertyName, HelpMessage = "Enter the default author name.")]
        [string]$Author,
        [Parameter(ValueFromPipelineByPropertyName, HelpMessage = "Enter the default company name.")]
        [string]$CompanyName,
        [Parameter(ValueFromPipelineByPropertyName, HelpMessage = "Enter the default copyright string")]
        [string]$Copyright,
        [Parameter(ValueFromPipelineByPropertyName, HelpMessage = "Enter the default version")]
        [string]$Version,
        [Parameter(ValueFromPipelineByPropertyName, HelpMessage = "Enter the default tag(s).")]
        [string[]]$Tags
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $Outfile = Join-Path $home -ChildPath psfunctioninfo-defaults.json

        #remove common and optional parameters if bound
        $common = [System.Management.Automation.Cmdlet]::CommonParameters
        $option = [System.Management.Automation.Cmdlet]::OptionalCommonParameters

        $option | ForEach-Object {
            #Write-Verbose "Testing for $_"
            if ($PSBoundParameters.ContainsKey($_)) {
                Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Removing $_"
                [void]$PSBoundParameters.remove($_)
            }
        }
        $common | ForEach-Object {
            #Write-Verbose "Testing for $_"
            if ($PSBoundParameters.ContainsKey($_)) {
                Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ]Removing $_"
                [void]$PSBoundParameters.remove($_)
            }
        }

        #get existing defaults
        if (Test-Path -Path $outfile) {
            Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Getting current defaults"
            $current = Get-PSFunctionInfoDefaults
        }
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using these new defaults"
        $PSBoundParameters | Out-String | Write-Verbose

        if ($current) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating current defaults"
            $PSBoundParameters.GetEnumerator() | ForEach-Object {
                if ($current.$($_.key)) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS]  ...$($_.key)"
                    $current.$($_.key) = $_.value
                }
                else {
                    #add new values
                    Add-Member -InputObject $current -MemberType NoteProperty -Name $_.key -Value $_.value -Force
                }
            }

            $defaults = $current
        }
        else {
            $defaults = $PSBoundParameters
        }
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Saving results to $Outfile"
        $defaults | Out-String | Write-Verbose
        $defaults | ConvertTo-Json | Out-File -FilePath $Outfile -Force
    } #process

    End {
        If (-Not $WhatIfPreference) {
            Write-Verbose "[$((Get-Date).TimeofDay) END    ] Re-import the module or run Update-PSFunctionInfoDefaults to load the new values."
        }
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Set-PSFunctionInfoDefaults