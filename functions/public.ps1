# define an object class for the Get-PSFunctionInfo commmand

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
    PSFunctionInfo([string]$Name, [string]$Source) {
        $this.Name = $Name
        $this.Source = $Source
    }
    PSFunctionInfo([string]$Name, [string]$Author, [string]$Version, [string]$Source, [string]$Description, [string]$Module, [string]$CompanyName, [string]$Copyright, [guid]$Guid, [datetime]$LastUpdate, [string]$Commandtype) {
        $this.Name = $Name
        $this.Author = $Author
        $this.Version = $Version
        $this.Source = $Source
        $this.Description = $Description
        $this.Module = $Module
        $this.CompanyName = $CompanyName
        $this.Copyright = $Copyright
        #$this.Tags = $Tags
        $this.guid = $Guid
        $this.LastUpdate = $LastUpdate
        $this.CommandType = $Commandtype
    }
}
#endregion


