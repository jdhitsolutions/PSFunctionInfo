# https://gist.github.com/jdhitsolutions/65070cd51b5cfb572bc6375f67bcbc3d


#TODO - Need an update or set command?
#TODO - Add an alias property
#TODO - add a custom table view to group by source
#  Get-PSFunctionInfo | sort source | ft -GroupBy source -Property Name,Version,Description,Tags


#define an object class for the Get-PSFunctionInfo commmand
class PSFunctionInfo {
    [string]$Name
    [version]$Version
    [string]$Description
    [string]$Author
    [string]$Source
    [string]$Module
    [string]$CompanyName
    [string]$Copyright
    [guid]$Guid
    [string[]]$Tags
    [datetime]$LastUpdate
    [string]$Commandtype

    PSFunctionInfo($Name, $Source) {
        $this.Name = $Name
        $this.Source = $Source
    }
    PSFunctionInfo($Name,$Author, $Version,$Source,$Description,$Module,$CompanyName,$Copyright,$Tags,$Guid,$LastUpdate,$Commandtype) {
        $this.Name = $Name
        $this.author = $Author
        $this.Version = $Version
        $this.Source = $Source
        $this.Description = $Description
        $this.Module = $Module
        $this.CompanyName = $CompanyName
        $this.Copyright = $Copyright
        $this.Tags = $Tags
        $this.guid = $Guid
        $this.LastUpdate = $LastUpdate
        $this.CommandType = $Commandtype
    }
}
Function New-PSFunctionInfo {
    #TODO - New-PSFunctionInfo Guid and Updated should be set inside the function. Not parameters.
    #TODO Add parameter validation for path to make sure it is .ps1 file
    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Specify name of the function")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory, HelpMessage = "Specify the path that contains the function")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path $_})]
        [string]$Path,
        [string]$Author = [System.Environment]::UserName,
        [string]$CompanyName,
        [string]$Copyright,
        [string]$Description,
        [string]$Version = "1.0.0",
        [guid]$Guid = $(([guid]::NewGuid()).guid),
        [string[]]$Tags,
        [datetime]$Updated = $(Get-Date),
        [Parameter(HelpMessage = "Copy the metadata to the clipboard. The file is left untouched.")]
        [alias("clip")]
        [switch]$ToClipboard
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $Name in $Path with this metadata"
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
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Copying to metadata to clipboard"
            if ($pscmdlet.shouldprocess("function metadata", "Copy to clipboard")) {
                Set-Clipboard -value $info
            }
        }
        else {

            #get the contents of the script file
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting the file contents"
            $c = Get-Content -Path $path

            #find the line that begins the function
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Finding the line containing Function $Name"

            $m = $c | Select-String "Function $Name"
            if ($m.Line) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found on line $($m.linenumber)"
                $ln = $m.LineNumber - 1
                #create a temporary file
                $tmp = [System.IO.Path]::GetTempFileName()
                #copy lines of the file up to the function definition line
                $c[0..$ln] | Out-File -FilePath $tmp -whatIf:$false

                #add the function info metadata
                $Info | Out-File -FilePath $tmp -Append -whatif:$False
                #go to the next line
                $ln++
                #copy the rest of the file to the temp file
                $c[$ln..($c.Length)] | Out-File -FilePath $tmp -Append -whatif:$false

                #copy the temp file to the new file
                if ($pscmdlet.shouldprocess($Path, "Update function info for $Name")) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Writing updated file"
                    Copy-Item -Path $tmp -Destination $path -Force
                }
            }
            else {
                Write-Warning "Could not find the function $name in $Path."
            }
        } #else process the file
    } #process

    End {
        #clean up the temp file
        If ($tmp -AND (Test-Path $tmp)) {
            Remove-Item $tmp -whatif:$False
        }
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"

    } #end

} #close New-PSFunctionInfo


Function Get-PSFunctionInfo {
#TODO: Add parameter to filter by tag
    [cmdletbinding(DefaultParameterSetName="name")]
    [outputtype("PSFunctionInfo")]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Specify the name of a function. The default is all functions that don't belong to a module.",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName="name"
            )]
        [string]$Name = "*",
        [Parameter(
            HelpMessage="Get all functions",
            ParameterSetName="all"
            )]
        [switch]$All
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #a regex pattern that will be used to parse the metadata from the function definition
        [regex]$rx = "(?<property>\w+)\s+(?<value>.*)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting loaded function(s): $Name"

         # filter out this module
        $functions = (Get-ChildItem -path Function:\$Name).where({$_.source -ne 'PSFunctionInfo'})
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $($functions.count) functions"
        Foreach ($fun in $functions) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $($fun.name)"
            $definition = $fun.definition -split "`n"
            $m = $definition | Select-String -Pattern "#(\s+)?PSFunctionInfo"
            if ($m.count -gt 1) {
               Write-Warning "Multiple matches found for PSFunctionInfo in $($fun.name). Will only process the first one."
            }
            if ($m) {
                #get the starting line number
                $i = $m[0].LineNumber

                $meta = While ($definition[$i] -notmatch "#\>") {
                    $raw = $definition[$i]
                    if ($raw -match "\w+") {
                        $raw
                    }
                    $i++
                }

                #Define a hashtable that will eventually become a custom object
                $h = @{
                    Name        = $fun.name
                    CommandType = $fun.CommandType
                    Module      = $fun.Module
                }
                #parse the metadata using regular expressions
                for ($i = 0; $i -lt $meta.count; $i++) {
                    $groups = $rx.Match($meta[$i]).groups
                    $h.add($groups[1].value, $groups[2].value.trim())
                }
                #check for required properties
                if ( -Not ($h.ContainsKey("Source")) ) {
                    $h.add("Source","")
                }
                if (-Not ($h.ContainsKey("version"))) {
                    $h.add("Version", "")
                }
                $h | Out-String | Write-Verbose
                #write the custom object to the pipeline
                $fi = New-Object -typename PSFunctionInfo -ArgumentList $h.name,$h.version
                #update the object with hash table properties
               foreach ($key in $h.keys) {
                   Write-Verbose "Updating $key"
                   $fi.$key = $h.$key
               }
               $fi
                #clear the variable so it doesn't get reused
                Remove-Variable m,h

            } #if metadata found
            else {
                #insert the custom type name and write the object to the pipeline
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] No function metadata found for $($fun.name)."
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a PSFunctionInfo object "
                $fi = New-Object PSFunctionInfo -ArgumentList $fun.name,$fun.source
                $fi.version = $fun.version
                $fi.module = $fun.Module
                $fi.Commandtype = $fun.CommandType
                $fi.Description = $fun.Description

                #Write the object depending on the parameter set and if it belongs to a module AND has a source
                if ($pscmdlet.ParameterSetName -eq 'Name' -AND (-not $fi.module) -AND ($if.source)) {
                    $fi
                }
                elseif ($pscmdlet.ParameterSetName -eq 'All') {
                    $fi
                }
            }
        } #foreach

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"

    } #end

} #close Get-PSFunctionInfo

# Update-FormatData $PSScriptRoot\PSFunctionInfo.format.ps1xml
# Update-TypeData -appendpath $PSScriptRoot\PSFunctionInfo.types.ps1xml

<#
PS C:\> Get-PSFunctionInfo get* | Where author

Name                                Version    Source                         Module
----                                -------    ------                         ------
Get-QOTD                            1.0.0      C:\scripts\Get-QOTD.ps1
Get-Status                          1.0.0      C:\scripts\getstat.ps1
Get-UTCString                       1.0.0      C:\scripts\JDH-Functions.ps1
Get-DiskFree                        1.0.0      C:\scripts\JDH-Functions.ps1
Get-LastBoot                        1.0.0      C:\scripts\JDH-Functions.ps1
Get-MyFunctions                     1.0.0      C:\scripts\JDH-Functions.ps1
Get-PSFunctionInfo                  2.1.0      C:\scripts\PSFunctionInfo.ps1

PS C:\> get-psfunctioninfo get-qotd | select *


Name        : Get-QOTD
Version     : 1.0.0
Source      : C:\scripts\Get-QOTD.ps1
CompanyName : JDH IT Solutions
Copyright   : 2020
Description : Get a quote of the day
LastUpdate  : 1/27/2020 11:46:19 AM
Module      :
Author      : Jeff
Guid        : 16b5d672-4778-46d9-bbe5-08e7860e4e8a
Tags        : {Web,profile}
Commandtype : Function

PS C:\> get-psfunctioninfo get-f*

Name                                Version    Source                         Module
----                                -------    ------                         ------
Get-FileHash                        3.1.0.0    Microsoft.PowerShell.Utility   Microsoft.PowerShell.Utility
Get-Foo                             1.0.0      d:\temp\foo.ps1

#>


