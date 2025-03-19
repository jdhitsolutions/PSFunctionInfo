Function test_functionName {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String]$Name,
        [Switch]$Quiet
    )
    begin {
        #exclude built-in Microsoft functions
        $exclude = "more", "cd..", "cd\", "cd~","ImportSystemModules", "Pause", "help", "TabExpansion2", "mkdir", "Get-Verb", "oss", "Clear-Host"
    }
    Process {
        #"^[A-Za-z]:"
        #19 March 2025 filter out any functions that end in a colon
        if ($exclude -NotContains $name -AND ($name -notmatch "^.*:$")) {
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

Function new_PSFunctionInfo {
    [CmdletBinding()]
    Param (
        [String]$Name,
        [String]$Version,
        [String]$Description,
        [String]$Author,
        [String]$Source,
        [String]$Module,
        [String]$CompanyName,
        [String]$Copyright,
        [guid]$Guid,
        [string[]]$Tags,
        [DateTime]$LastUpdate,
        [String]$CommandType
    )

    # Write-Verbose "creating new object Using these parameters"
    # $PSBoundParameters | Out-String | Write-Verbose
    $obj = [PSFunctionInfo]::new([String]$Name, [String]$Author, [String]$Version, [String]$Source, [String]$Description, [String]$Module, [String]$CompanyName, [String]$Copyright, [guid]$Guid, [DateTime]$LastUpdate, [String]$Commandtype)
    if ($tags) {
        $obj.Tags = $Tags
    }
    $obj
}

function backup_file {
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory)]
        [alias("FullName")]
        [String]$Path
    )

    #The path is the full file system name to the ps1 file.

    $folder = Split-Path -Path $path
    $filename = Split-Path -Path $path -Leaf
    $i = 0

    do {
        $i++
        $new = Join-Path -Path $Folder -child "$filename.bak$i"
    } Until (-Not (Test-Path -Path $New))

    Write-Verbose "[$((Get-Date).TimeOfDay) PRIVATE] Backing up $path to $new"
    Try {
        Copy-Item -Path $path -Destination $new -ErrorAction stop
    }
    Catch {
        #this shouldn't happen.
        Throw "Failed to create backup copy $new. $($_.exception.message)"
    }
}

function _getInfoIndex {
    [CmdletBinding()]
    Param([System.Collections.Generic.list[String]]$File, [String]$Name)

    #find index of function name
    $idx = $file.FindIndex({ $args[0] -match "function $Name" })
    if ($Idx -eq -1) {
        Throw "Could not find function $name"
    }
    #find index of PSFunction Info
    $openIdx = $file.FindIndex($idx, { $args[0] -match "PSFunctionInfo" })
    if ($openIdx -eq -1) {
        Throw "Could not find PSFunctionInfo for $name"
    }
    $CloseIdx = $file.FindIndex($openIdx, { $args[0] -eq "#>" })

    #Find index of Version|Description|LastUpdate starting from the function index
    $versionIdx = $file.FindIndex($openIdx, { $args[0] -match '^Version\s.*$' })
    $descriptionIdx = $file.FindIndex($openIdx, { $args[0] -match '^Description(\s.*)?$' })
    $lastUpdateIdx = $file.FindIndex($openIdx, { $args[0] -match '^LastUpdate\s.*$' })
    $authorIdx = $file.FindIndex($openIdx, { $args[0] -match '^Author(\s.*)?$' })
    $tagsIdx = $file.FindIndex($openIdx, { $args[0] -match '^Tags(\s.*)?$' })
    $companyIdx = $file.FindIndex($openIdx, { $args[0] -match '^CompanyName(\s.*)?$' })
    $copyIdx = $file.FindIndex($openIdx, { $args[0] -match '^Copyright(\s.*)?$' })
    $sourceIdx = $file.FindIndex($openIdx, { $args[0] -match '^Source(\s.*)?$' })

    [ordered]@{
        Name        = $Name
        Version     = $versionIdx
        Author      = $authorIdx
        CompanyName = $companyIdx
        Copyright   = $copyIdx
        Description = $descriptionIdx
        Tags        = $tagsIdx
        LastUpdate  = $lastUpdateIdx
        Source      = $sourceIdx
        OpenIndex   = $openIdx
        CloseIndex  = $CloseIdx
    }
}
