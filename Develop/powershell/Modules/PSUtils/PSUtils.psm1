<#
    .Description
    Get all of the commands of powershell.
#>
function Collect-All {
    return -join (
        Get-Help * | where -property "Category" -eq "Cmdlet" | foreach {$_.name+" "}
    )
}


export-modulemember -function Collect-All 
