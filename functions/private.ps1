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