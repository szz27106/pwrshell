$s = Get-Content $PSScriptRoot\stations.json -Raw |
    ConvertFrom-Json | 
    Select-Object -Expand data|
    Select-Object -Expand stations |
    ForEach-Object {
        $_.rental_methods = $_.rental_methods -join ' '
        $_
    } 
 $s | Out-GridView   
#$s | Export-Csv $PSScriptRoot\stations.csv -NoTypeInformation
