#region define an object class for the Get-PSFunctionInfo commmand

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

    #this class has no methods

    #constructors
    PSFunctionInfo($Name, $Source) {
        $this.Name = $Name
        $this.Source = $Source
    }
    PSFunctionInfo($Name, $Author, $Version, $Source, $Description, $Module, $CompanyName, $Copyright, $Tags, $Guid, $LastUpdate, $Commandtype) {
        $this.Name = $Name
        $this.Author = $Author
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
#endregion


#TODO - Create a VSCode task?

Function New-PSFunctionInfo {
    [cmdletbinding(SupportsShouldProcess)]
    [alias('npfi')]
    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Specify the name of the function")]
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
        [switch]$ToClipboard
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
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS]  Testing index $i"
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

#get function info from non-module functions
Function Get-PSFunctionInfo {
    [cmdletbinding(DefaultParameterSetName = "name")]
    [outputtype("PSFunctionInfo")]
    [alias("gpfi")]

    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Specify the name of a function that doesn't belong to a module.",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "name"
        )]
        [string]$Name = "*",
        [Parameter(HelpMessage = "Specify a tag")]
        [string]$Tag
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"

        #a regex pattern that will be used to parse the metadata from the function definition
        [regex]$rx = "(?<property>\w+)\s+(?<value>.*)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using parameter set $($pscmdlet.ParameterSetName)"
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting function $Name"

        # filter out functions with a module source and that pass the private filtering test
        $functions = (Get-ChildItem -Path Function:\$Name).where( { -Not $_.source -And (test_functionname $_.name) })
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $($functions.count) functions"
        Foreach ($fun in $functions) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] $($fun.name)"
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
                if (-Not ($h.ContainsKey("Source")) ) {
                    $h.add("Source", "")
                }
                if (-Not ($h.ContainsKey("version"))) {
                    $h.add("Version", "")
                }
                # $h | Out-String | Write-Verbose
                #write the custom object to the pipeline
                $fi = New-Object -TypeName PSFunctionInfo -ArgumentList $h.name, $h.version

                #update the object with hash table properties
                foreach ($key in $h.keys) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $key"
                    $fi.$key = $h.$key
                }
                if ($tag) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for tag $tag"
                    # write-verbose "$($fi.name) tag: $($fi.tags)"
                    if ($fi.tags -match $tag) {
                        $fi
                    }
                }
                else {
                    $fi
                }
                #clear the variable so it doesn't get reused
                Remove-Variable m, h

            } #if metadata found
            else {
                #insert the custom type name and write the object to the pipeline
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a new and temporary PSFunctionInfo object."
                $fi = New-Object PSFunctionInfo -ArgumentList $fun.name, $fun.source
                $fi.version = $fun.version
                $fi.module = $fun.Module
                $fi.Commandtype = $fun.CommandType
                $fi.Description = $fun.Description

                #Write the object depending on the parameter set and if it belongs to a module AND has a source
                if (-Not $tag) {
                    $fi
                }
            }
        } #foreach

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Get-PSFunctionInfo

Function Get-PSFunctionInfoTag {
    [cmdletbinding()]
    [outputtype("String")]
    Param()

    Write-Verbose "[$((Get-Date).TimeofDay)] Starting $($myinvocation.mycommand)"
    $taglist = [System.Collections.Generic.list[string]]::new()

    Write-Verbose "[$((Get-Date).TimeofDay)] Getting unique tags from Get-PSFunctionInfo"
    $items = (Get-PSFunctionInfo -ErrorAction stop).tags | Select-Object -Unique
    if ($items.count -eq 0) {
        Write-Warning "Failed to find any matching functions with tags"
    }
    else {
        Write-Verbose "[$((Get-Date).TimeofDay)] Found at least $($items.count) tags"
        foreach ($item in $items) {
            if ($item -match ",") {
                #split strings into an array
                $item.split(",") | ForEach-Object {
                    if (-Not $taglist.contains($_)) {
                        $taglist.add($_)
                    }
                }
            } #if an array of tags
            else {
                if (-Not $taglist.contains($item)) {
                    $taglist.add($item)
                }
            }
        } #foreach item
    } #else

    #write the list to the pipeline
    $taglist | Sort-Object

    Write-Verbose "[$((Get-Date).TimeofDay)] Ending $($myinvocation.mycommand)"

}