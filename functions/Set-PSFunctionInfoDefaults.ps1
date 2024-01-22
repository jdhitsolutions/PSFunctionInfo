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
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the default author name."
            )]
        [String]$Author,
        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the default company name."
            )]
        [String]$CompanyName,
        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the default copyright string"
            )]
        [String]$Copyright,
        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the default version"
            )]
        [String]$Version,
        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the default tag(s)."
            )]
        [string[]]$Tags
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        $OutFile = Join-Path $home -ChildPath psfunctioninfo-defaults.json

        #remove common and optional parameters if bound
        $common = [System.Management.Automation.Cmdlet]::CommonParameters
        $option = [System.Management.Automation.Cmdlet]::OptionalCommonParameters

        $option | ForEach-Object {
            #Write-Verbose "Testing for $_"
            if ($PSBoundParameters.ContainsKey($_)) {
                Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Removing $_"
                [void]$PSBoundParameters.remove($_)
            }
        }
        $common | ForEach-Object {
            #Write-Verbose "Testing for $_"
            if ($PSBoundParameters.ContainsKey($_)) {
                Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ]Removing $_"
                [void]$PSBoundParameters.remove($_)
            }
        }

        #get existing defaults
        if (Test-Path -Path $OutFile) {
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Getting current defaults"
            $current = Get-PSFunctionInfoDefaults
        }
    } #begin

    Process {
        if ($PSBoundParameters.Keys.Count -eq 0) {
            Write-Warning "No parameters were specified. Exiting."
            return
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using these new defaults"
        $PSBoundParameters | Out-String | Write-Verbose

        if ($current) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating current defaults"
            $PSBoundParameters.GetEnumerator() | ForEach-Object {
                if ($current.$($_.key)) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS]  ...$($_.key)"
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
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Saving results to $OutFile"
        $defaults | Out-String | Write-Verbose
        $defaults | ConvertTo-Json | Out-File -FilePath $OutFile -Force
    } #process

    End {
        If (-Not $WhatIfPreference) {
            Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Re-import the module or run Update-PSFunctionInfoDefaults to load the new values."
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Set-PSFunctionInfoDefaults
