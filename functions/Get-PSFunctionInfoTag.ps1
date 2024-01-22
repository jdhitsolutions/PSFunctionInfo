Function Get-PSFunctionInfoTag {
    [CmdletBinding()]
    [OutputType("String")]
    Param()

    Write-Verbose "[$((Get-Date).TimeOfDay)] Starting $($MyInvocation.MyCommand)"
    $TagList = [System.Collections.Generic.list[String]]::new()

    Write-Verbose "[$((Get-Date).TimeOfDay)] Getting unique tags from Get-PSFunctionInfo"
    $items = (Get-PSFunctionInfo -ErrorAction stop).tags | Select-Object -Unique
    if ($items.count -eq 0) {
        Write-Warning "Failed to find any matching functions with tags"
    }
    else {
        Write-Verbose "[$((Get-Date).TimeOfDay)] Found at least $($items.count) tags"
        foreach ($item in $items) {
            if ($item -match ",") {
                #split strings into an array
                $item.split(",") | ForEach-Object {
                    if (-Not $TagList.contains($_)) {
                        $TagList.add($_.trim())
                    }
                }
            } #if an array of tags
            else {
                if (-Not $TagList.contains($item)) {
                    $TagList.add($item.trim())
                }
            }
        } #foreach item
    } #else

    #write the list to the pipeline
    $TagList | Sort-Object

    Write-Verbose "[$((Get-Date).TimeOfDay)] Ending $($MyInvocation.MyCommand)"

}
