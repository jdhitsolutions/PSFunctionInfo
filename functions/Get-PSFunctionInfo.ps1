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
        [alias("Name")]
        [string]$FunctionName = "*",
        [Parameter(
            HelpMessage = "Specify a .ps1 file to search.",
            ValueFromPipelineByPropertyName,
            ParameterSetName = "file"
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

        if ($pscmdlet.ParameterSetName -eq 'file') {

            $file = [System.Collections.Generic.list[string]]::New()
            Get-Content -Path $path | ForEach-Object {
                $file.add($_)
            }

            #get location of PSFunctionInfo
            $start = 0

            #need to ignore case
            $rxname = [System.Text.RegularExpressions.Regex]::new("(\s+)?Function\s+\S+", "IgnoreCase")
            do {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Searching $path at $start"
                $i = $j = $file.FindIndex( $start, { $args[0] -match "#(\s+)?PSFunctionInfo" })

                if ($i -gt 0) {

                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Metadata found at index $i"
                    do {
                        $funName = $rxName.Match($file[$i]).value.trim()
                        $i--
                    } until ($i -lt 0 -OR $funName)

                    $name = $funName.split()[1]
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found function $Name"
                    $h = @{Name = $name }

                    do {
                        $j++
                        #trim off spaces in case the comment block is indented
                        $line = $file[$j].trim()
                        if ($line -match "\w+\s+\w+") {
                            $meta = $line.split(" ", 2)
                            $h.add($meta[0], $meta[1])
                        }
                    } Until ($j -gt $file.count -OR $line -match "#>")

                    #$h | out-string | write-verbose
                    Try {
                        $out = new_psfunctioninfo @h -ErrorAction Stop
                        $out.CommandType = "function"
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for tag $tag"
                        if ($PSBoundParameters.ContainsKey("Tag") -AND ($out.Tags -match $Tag)) {
                            $out
                        }
                        elseif (-Not $PSBoundParameters.ContainsKey("Tag")) {
                            $out
                        }
                    }
                    Catch {
                        Write-Warning "Failed to process $Path. $($_.Exception.message)."
                    }
                    $start = $j
                }
            } Until ($i -lt 0)

        }
        else {
            if (Test-Path Function:\$FunctionName) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting function $FunctionName"
                # filter out functions with a module source and that pass the private filtering test
                $functions = (Get-ChildItem -Path Function:\$FunctionName).where( { -Not $_.source -And (test_functionname $_.name) })
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
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Parsing metadata"
                        for ($i = 0; $i -lt $meta.count; $i++) {
                            $groups = $rx.Match($meta[$i]).groups
                            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] $($groups[1].value) = $($groups[2].value)"
                            $h.add($groups[1].value, $groups[2].value.trim())
                        }
                        #check for required properties
                        if (-Not ($h.ContainsKey("Source")) ) {
                            $h.add("Source", "")
                        }
                        if (-Not ($h.ContainsKey("version"))) {
                            $h.add("Version", "")
                        }
                        #$h | Out-String | Write-Verbose
                        #write the custom object to the pipeline
                        $fi = New-Object -TypeName PSFunctionInfo -ArgumentList $h.name, $h.version

                        #update the object with hash table properties
                        foreach ($key in $h.keys) {
                            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $key [$($h.$key)]"
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
                }
            } #if Test-Path
            Else {
                Write-Warning "Can't find $Functionname as a loaded function."
            }
        } #foreach

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Get-PSFunctionInfo