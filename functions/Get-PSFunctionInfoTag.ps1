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
                        $taglist.add($_.trim())
                    }
                }
            } #if an array of tags
            else {
                if (-Not $taglist.contains($item)) {
                    $taglist.add($item.trim())
                }
            }
        } #foreach item
    } #else

    #write the list to the pipeline
    $taglist | Sort-Object

    Write-Verbose "[$((Get-Date).TimeofDay)] Ending $($myinvocation.mycommand)"

}