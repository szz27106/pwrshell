#Declare Servername
$sqlServer='hqdbsp18'
#Invoke-sqlcmd Connection string parameters
$params = @{'server'='HQDBT01';'Database'='SQLShackDemo'}
 
#Fucntion to manipulate the data
Function writeDiskInfo
{
param($server,$devId,$volName,$frSpace,$totSpace)
 $totSpace=[math]::Round(($totSpace/1073741824),2)
 $frSpace=[Math]::Round(($frSpace/1073741824),2)
 $usedSpace = $totSpace - $frspace
 $usedSpace=[Math]::Round($usedSpace,2)
# Data preparation for loading data into SQL table 
$InsertResults = @"
INSERT INTO [SQLShackDemo].[dbo].[tbl_PosHdisk](SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
VALUES ('$SERVER','$devId','$volName',$totSpace,$usedSpace)
"@      
#call the invoke-sqlcmdlet to execute the query
         Invoke-sqlcmd @params -Query $InsertResults
}
 
#Query WMI query to store the result in a varaible
$dp = Get-WmiObject win32_logicaldisk -ComputerName $sqlServer|  Where-Object {$_.drivetype -eq 3}
 
#Loop through array
foreach ($item in $dp)
{
#Call the function to transform the data and prepare the data for insertion
writeDiskInfo $sqlServer $item.DeviceID $item.VolumeName $item.FreeSpace $item.Size
}
#Query the destination table to view the result
 
Invoke-Sqlcmd @params -Query "SELECT  * FROM tbl_PosHdisk" | format-table -AutoSize