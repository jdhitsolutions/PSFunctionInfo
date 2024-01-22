

Function Remove-PSFunctionInfo {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("None")]
    [alias("rpfi")]
    Param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = "Specify the name of a function that doesn't belong to a module.",
            ValueFromPipelineByPropertyName
        )]
        [alias("Name")]
        [String]$FunctionName,
        [Parameter(
            Mandatory,
            HelpMessage = "Specify the source .ps1 file for the function.",
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
        [alias("FullName","source")]
        [String]$Path
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Loading file $path"
        $file = [System.Collections.Generic.list[String]]::New()
        Get-Content -Path $path | ForEach-Object {
            $file.add($_)
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting PSFunctionInfo indices for $FunctionName"

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
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Removing lines $($index.OpenIndex) to $($index.CloseIndex)"
            $file.RemoveRange($index.OpenIndex,($index.CloseIndex-$index.OpenIndex+1))
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating $path"
            $file | Set-Content -Path $Path
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"

    } #end

} #close Remove-PSFunctionInfo
