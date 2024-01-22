# define an object class for the Get-PSFunctionInfo command

class PSFunctionInfo {
    [String]$Name
    [version]$Version
    [String]$Description
    [String]$Author
    [String]$Source
    [String]$Module
    [String]$CompanyName
    [String]$Copyright
    [guid]$Guid
    [string[]]$Tags
    [DateTime]$LastUpdate
    [String]$CommandType

    #this class has no methods

    #constructors
    PSFunctionInfo([String]$Name, [String]$Source) {
        $this.Name = $Name
        $this.Source = $Source
    }
    PSFunctionInfo([String]$Name, [String]$Author, [String]$Version, [String]$Source, [String]$Description, [String]$Module, [String]$CompanyName, [String]$Copyright, [guid]$Guid, [DateTime]$LastUpdate, [String]$Commandtype) {
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
        $this.CommandType = $CommandType
    }
}
#endregion
