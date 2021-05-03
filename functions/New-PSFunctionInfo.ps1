Function New-PSFunctionInfo {
    [cmdletbinding(SupportsShouldProcess)]
    [alias('npfi')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Specify the name of the function"
            )]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory, HelpMessage = "Specify the path that contains the function")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { Test-Path $_ })]
        [ValidatePattern("\.ps1$")]
        [string]$Path,
        [string]$Author = [System.Environment]::UserName,
        [string]$CompanyName,
        [string]$Copyright = (Get-Date).Year,
        [string]$Description,
        [ValidateNotNullOrEmpty()]
        [string]$Version = "1.0.0",
        [string[]]$Tags,
        [Parameter(HelpMessage = "Copy the metadata to the clipboard. The file is left untouched.")]
        [alias("clip")]
        [switch]$ToClipboard,
        [Parameter(HelpMessage = "Create a backup copy of the source file before inserting the metadata comment block.")]
        [switch]$Backup
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        [guid]$Guid = $(([guid]::NewGuid()).guid)
        [string]$updated = Get-Date -Format g
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating this metadata"
        $info = @"

<# PSFunctionInfo

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
"@

        Write-Verbose $info
        if ($ToClipboard) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Copying the metadata to clipboard"
            if ($pscmdlet.shouldprocess("function metadata", "Copy to clipboard")) {
                Set-Clipboard -Value $info
            }
        }
        else {
            #backup file if requested
            if ($Backup) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Backing up the source file $Path."
                Try {
                    backup_file -path $path
                }
                Catch {
                    Throw $_
                }
            }
            #get the contents of the script file
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting the file contents from $Path"

            $file = [System.Collections.Generic.list[string]]::New()
            Get-Content -Path $path | ForEach-Object {
                $file.add($_)
            }

            #find the function line
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Searching for Function $Name"
            $find = $file | Select-String -Pattern "^(\s+)?(F|f)unction $name(\s+|\{)?"
            if ($find.count -gt 1) {
                Write-Warning "Detected multiple matches for Function $name in $Path. Unable to insert metadata."
                #bail out
                return
            }
            elseif ($find.count -eq 1) {
                #$index = $file.findIndex( { $args[0] -match "^(\s+)?Function $name(\s+|\{)" })
                #the index for the file list will be 1 less than the pattern match
                $index = $find.Linenumber - 1
            }
            else {
                Write-Warning "Failed to find a function called $Name in $path."
                return
            }

            #find the opening { for the function
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting the position of the opening {"
            $i = $index
            do {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Testing index $i"
                if ($file[$i] -match "\{") {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found opening { at $i"
                    $found = $True
                }
                else {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] incrementing index"
                    $i++
                }
            } until ($found -OR $i -gt $file.count)

            if ($i -gt $file.count) {
                Write-Warning "Failed to find the opening { for Function $Name."
                return
            }

            #test for an existing PSFunctionInfo entry in the next 5 lines
            if ($file[$i..($i + 5)] | Select-String -Pattern "PSFunctionInfo" -Quiet) {
                Write-Warning "An existing PSFunctionInfo entry has been detected."
            }
            else {
                # insert after the opening {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Inserting metadata at position $($i+1)"
                $file.Insert(($i + 1), $info)

                #write the new data to the file
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $path"
                $file | Set-Content -Path $Path
            }

        } #else process the file
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close New-PSFunctionInfo