Function test_functionname {
    [cmdletbinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [switch]$Quiet
    )
    begin {
        #exclude built-in Microsoft functions
        $exclude = "more", "cd..", "cd\", "ImportSystemModules", "Pause", "help", "TabExpansion2", "mkdir", "Get-Verb", "oss", "clear-host"
    }
    Process {
        if ($exclude -notcontains $name -AND ($name -notmatch "^[A-Za-z]:")) {
            if ($Quiet) {
                $true
            }
            else {
                $name
            }
        } #if the name passes the filter
        elseif ($Quiet) {
            $False
        }
    } #process
    End {
        #not used
    }
}

Function new_psfunctioninfo {
    [cmdletbinding()]
    Param (
        [string]$Name,
        [string]$Version,
        [string]$Description,
        [string]$Author,
        [string]$Source,
        [string]$Module,
        [string]$CompanyName,
        [string]$Copyright,
        [guid]$Guid,
        [string[]]$Tags,
        [datetime]$LastUpdate,
        [string]$Commandtype
    )

    # Write-Verbose "creating new object Using these parameters"
    # $PSBoundParameters | Out-string | Write-Verbose
    $obj = [psfunctioninfo]::new([string]$Name, [string]$Author, [string]$Version, [string]$Source, [string]$Description, [string]$Module, [string]$CompanyName, [string]$Copyright, [guid]$Guid, [datetime]$LastUpdate, [string]$Commandtype)
    if ($tags) {
        $obj.Tags = $Tags
    }
    $obj
}

function backup_file {
    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory)]
        [alias("fullname")]
        [string]$Path
    )

    #The path is the full file system name to the ps1 file.

    $folder = Split-Path -Path $path
    $filename = Split-Path -Path $path -Leaf
    $i = 0

    do {
        $i++
        $new = Join-Path -Path $Folder -child "$filename.bak$i"
    } Until (-Not (Test-Path -Path $New))

    Write-Verbose "[$((Get-Date).TimeofDay) PRIVATE] Backing up $path to $new"
    Try {
        Copy-Item -Path $path -Destination $new -ErrorAction stop
    }
    Catch {
        #this shouldn't happen.
        Throw "Failed to create backup copy $new. $($_.exception.message)"
    }
}

function _getInfoIndex {
    [cmdletbinding()]
    Param([System.Collections.Generic.list[string]]$File, [string]$Name)

    #find index of function name
    $idx = $file.FindIndex({ $args[0] -match "function $Name" })
    if ($Idx -eq -1) {
        Throw "Could not find function $name"
    }
    #find index of PSFunction Info
    $OpenIdx = $file.FindIndex($idx, { $args[0] -match "PSFunctionInfo" })
    if ($OpenIdx -eq -1) {
        Throw "Could not find PSFunctionInfo for $name"
    }
    $CloseIdx = $file.FindIndex($OpenIdx, { $args[0] -eq "#>" })

    #Find index of Version|Description|Lastupdate starting from the function index
    $versionIdx = $file.findindex($openidx, { $args[0] -match '^Version\s.*$' })
    $descriptionIdx = $file.findindex($openidx, { $args[0] -match '^Description(\s.*)?$' })
    $lastupdateIdx = $file.findindex($openidx, { $args[0] -match '^LastUpdate\s.*$' })
    $authorIdx = $file.findindex($openidx, { $args[0] -match '^Author(\s.*)?$' })
    $tagsIdx = $file.findindex($openidx, { $args[0] -match '^Tags(\s.*)?$' })
    $companyIdx = $file.findindex($openidx, { $args[0] -match '^Companyname(\s.*)?$' })
    $copyIdx = $file.findindex($openidx, { $args[0] -match '^Copyright(\s.*)?$' })
    $sourceIdx = $file.findindex($openidx, { $args[0] -match '^Source(\s.*)?$' })

    [ordered]@{
        Name        = $Name
        Version     = $versionIdx
        Author      = $authorIdx
        CompanyName = $companyIdx
        Copyright   = $copyIdx
        Description = $descriptionIdx
        Tags        = $tagsIdx
        LastUpdate  = $lastupdateIdx
        Source      = $sourceIdx
        OpenIndex   = $OpenIdx
        CloseIndex  = $CloseIdx
    }
}