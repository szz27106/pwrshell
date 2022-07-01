#Invoke-sqlcmd Connection string parameters
$params = @{'server'='HQDBT01';'Database'='SQLShackDemo'}
 
#function to retrieve disk information
Function Get-DisksSpace ([string]$Servername)
{
Get-WmiObject win32_logicaldisk -ComputerName $Servername -Filter "Drivetype=3" |`
Select-Object  SystemName,DeviceID,VolumeName,@{Label="Total SIze";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }}
}
 
#Variable to hold output as data-table
$dataTable = Get-DisksSpace hqdbsp18 |  Out-DataTable
#Define Connection string
$connectionString = "Data Source=hqdbt01; Integrated Security=True;Initial Catalog=SQLShackDemo;"
#Bulk copy object instantiation
$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
#Define the destination table 
$bulkCopy.DestinationTableName = "tbl_PosHdisk"
#load the data into the target
$bulkCopy.WriteToServer($dataTable)
#Query the target table to see for output
Invoke-Sqlcmd @params -Query "SELECT  * FROM tbl_PosHdisk" | format-table -AutoSize
