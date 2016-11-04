<#
    .Description
    Get all of the commands of powershell.
#>
function Collect-All ($type) {
    switch ($type){
        "a" {$Categoery = "Alias"; Break}
        "c" {$Categoery = "Cmdlet"; Break}
        "f" {$Categoery = "Function"; Break}
        $null {$Categoery = "Function", "Alias", "Cmdlet"; Break}
    }
    return -join (
        Get-Help * | where -property "Category" -in $Categoery | foreach {$_.name + " "}
    )
}


export-modulemember -function Collect-All 
