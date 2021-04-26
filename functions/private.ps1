Function test_functionname {
    [cmdletbinding()]
    param(
        [Parameter(Position=0,Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]$Name,
        [switch]$Quiet
    )
    begin {
        #exclude built-in Microsoft functions
        $exclude = "more", "cd..", "cd\", "ImportSystemModules", "Pause", "help", "TabExpansion2", "mkdir", "Get-Verb","oss","clear-host"
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

