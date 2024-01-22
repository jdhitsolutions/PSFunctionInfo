Function Set-PSFunctionInfo {
    [CmdletBinding(SupportsShouldProcess)]
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
        [String]$FunctionName,

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
        [alias("FullName")]
        [String]$Path,

        [Parameter(HelpMessage = "Specify the new version.")]
        [String]$Version,
        [Parameter(HelpMessage = "Specify the new author.")]
        [String]$Author,
        [Parameter(HelpMessage = "Specify the new company information.")]
        [String]$CompanyName,
        [Parameter(HelpMessage = "Specify the new copyright information.")]
        [String]$Copyright,
        [Parameter(HelpMessage = "Specify the new description.")]
        [String]$Description,
        [Parameter(HelpMessage = "Specify the new tags as a comma-separated string. This will replace existing tags.")]
        [String]$Tags,
        [Parameter(HelpMessage = "Specify the new Source.")]
        [String]$Source
        )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        $Changes = "Version", "Author", "CompanyName", "Copyright", "Description", "Tags", "Source"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Loading function $FunctionName from $Path "

        $file = [System.Collections.Generic.list[String]]::New()
        Get-Content -Path $Path | ForEach-Object {
            $file.add($_)
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting PSFunctionInfo indices"

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
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Setting $item to $($PSBoundParameters[$item])"
                    $file[$index.$item] = "$item $($PSBoundParameters[$item])"
                }
            } #write the new data to the file

            #update LastUpdate
            $file[$index.LastUpdate] = "LastUpdate $(Get-Date -Format g)"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating $Path"
            $file | Set-Content -Path $Path
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Set-PSFunctionInfo
