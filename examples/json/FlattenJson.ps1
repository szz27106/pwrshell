$sourceFilePath = "$PSScriptRoot\items.json"
$json = Get-Content $sourceFilePath -Raw | ConvertFrom-Json
$all = @( ($json.header_items | Select-Object *, @{Name = 'ItemType'; Expression = { 'HeaderItem' } }) ) + 
    ($json.items | Select-Object *, @{Name = 'ItemType'; Expression = { 'Item' } })
$properties = ($all | ForEach-Object { $_ | Get-Member -MemberType NoteProperty}) | Select-Object -Unique -ExpandProperty Name
$destinationFilePath = "$PSScriptRoot\items.csv"
$all | Select-Object -Property $properties | Export-Csv -NoTypeInformation -Path $destinationFilePath
#$all | Select-Object -Property $properties | Out-GridView

$json | Select-Object * |ForEach-Object { 
    foreach($item in $_.items) {
        [PSCustomObject] @{
            auid = $_.auid
            tempid = $_.tempid
            item_id = $item.item_id
            parent_id = $item.parent_id
        }
    } 
} | Out-GridView

