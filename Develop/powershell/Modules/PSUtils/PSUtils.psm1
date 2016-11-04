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


function Collect-Keys ($type) {
    $keys = "~\temp.txt"
    if (Test-Path $keys){
        rm -fo $keys
    }
    switch ($type){
        "a" {$Categoery = "Alias"; Break}
        "c" {$Categoery = "Cmdlet"; Break}
        "f" {$Categoery = "Function"; Break}
        $null {$Categoery = "Function", "Alias", "Cmdlet"; Break}
    }
    if ($type -ne "v"){
        $name = "ps1FunctionInvocation"
        $items = (Get-Help * | where -property "Category" -in $Categoery)
    }else{
        $name = "ps1SpecialVariable"
        $items = (Get-ChildItem Variable:)
    }
    $syn = "syn keyword " + $name + " "
    $line = $syn
    foreach ($item in $items){
        $line += ( "$" + $item.name + " " )
        if ($line.length -gt 90){
            $line >> $keys
            $line = $syn
        }
    }
}


function Add-EnvPath ($EnvPath) {
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$EnvPath", [EnvironmentVariableTarget]::Machine)
}


export-modulemember -function Collect-All 
export-modulemember -function Add-EnvPath
export-modulemember -function Collect-Keys
