

Function Set-PSFunctionInfo {
    [cmdletbinding(SupportsShouldProcess)]
    [alias("spfi")]

    Param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = "Specify the name of a function that doesn't belong to a module.",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias("Name")]
        [ValidateNotNullOrEmpty()]
        [string]$FunctionName,
        [Parameter(
            Mandatory,
            HelpMessage = "Specify  the .ps1 file that contains the function.",
            ValueFromPipelineByPropertyName
        )]
        [ValidatePattern('\.ps1$')]
        [ValidateScript( {
                if (Test-Path $_) {
                    return $True
                }
                else {
                    Throw "Cannot find the specified file $_."
                    return $False
                }
            })]
        [alias("fullname")]
        [string]$Path,
        [Parameter(HelpMessage = "Specify the new version.")]
        [string]$Version,
        [Parameter(HelpMessage = "Specify the new author.")]
        [string]$Author,
        [Parameter(HelpMessage = "Specify the new company information.")]
        [string]$CompanyName,
        [Parameter(HelpMessage = "Specify the new copyright information.")]
        [string]$Copyright,
        [Parameter(HelpMessage = "Specify the new description.")]
        [string]$Description,
        [Parameter(HelpMessage = "Specify the new tags as a comma-separated string. This will replace existing tags.")]
        [string]$Tags,
        [Parameter(HelpMessage = "Specify the new Source.")]
        [string]$Source
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $Changes = "Version", "Author", "CompanyName", "Copyright", "Description", "Tags", "Source"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Loading function $FunctionName from $Path "

        $file = [System.Collections.Generic.list[string]]::New()
        Get-Content -Path $path | ForEach-Object {
            $file.add($_)
        }
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting PSFunctionInfo indices"

        Try {
            $index = _getInfoIndex -File $file -Name $FunctionName -ErrorAction Stop
            <#
            Name                           Value
            ----                           -----
            Name                           get-eventloginfo
            Version                        11
            Author                         12
            Company                        13
            Copyright                      14
            Description                    100
            Tags                           102
            Source                         104
            LastUpdate                     18
            OpenIndex                      9
            CloseIndex                     21
            #>
        }
        Catch {
            Throw $_
        }

        if ($index) {
            $index | Out-String | Write-Verbose
            #process changes
            foreach ($item in $changes) {
                if ($PSBoundParameters.ContainsKey($item)) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Setting $item to $($PSBoundParameters[$item])"
                    $file[$index.$item] = "$item $($PSBoundParameters[$item])"
                }
            } #write the new data to the file

            #update Lastupdate
            $file[$index.LastUpdate] = "LastUpdate $(Get-Date -Format g)"
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $path"
            $file | Set-Content -Path $Path
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Set-PSFunctionInfo