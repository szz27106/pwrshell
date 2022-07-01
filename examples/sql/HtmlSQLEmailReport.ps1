###################################################################################
## Script to send an html-formatted email report containing data from SQL Server ##
##                                                                               ##
## Author: Trevor Jones                                                          ##
## Version 1.0 (5th Apr 2018)                                                    ##
###################################################################################

# Database info
$script:dataSource = 'SQLSERVER\INSTANCE'
$script:database = 'DATABASE'

# Email params
$EmailParams = @{
    To         = 'Trevor.Jones@contoso.com'
    From       = 'Reporting@contoso.com'
    Smtpserver = 'smtpserver'
    Subject    = "SCCM Report: Windows 10 Systems"
}

# Function to get data from SQL server
function Get-SQLData {
    param($Query)
    $connectionString = "Server=$dataSource;Database=$database;Integrated Security=SSPI;"
    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    $connection.Open()
    
    $command = $connection.CreateCommand()
    $command.CommandText = $Query
    $reader = $command.ExecuteReader()
    $table = New-Object -TypeName 'System.Data.DataTable'
    $table.Load($reader)
    
    $connection.Close()
    
    return $Table
}

# Define the SQL Query
$Query = "
select top 10 
  sys.Name0 as 'ComputerName',
  cs.Manufacturer0 as 'Manufacturer',
  cs.Model0 as 'Model',
  os.Caption0 as 'OS',
  sys.Client_Version0 as 'Client Version',
  sys.Creation_Date0 as 'SCCM Record Created',
  ch.LastActiveTime as 'Last Active'
from v_R_System sys
left join v_CH_ClientSummary ch on sys.ResourceID = ch.ResourceID
left join v_GS_Computer_System cs on sys.ResourceID = cs.ResourceID
left join v_GS_Operating_System os on sys.ResourceID = os.ResourceID
where os.Caption0 like '%10%'
Order by sys.Name0
"

# Html CSS style
$Style = @"
<style>
table { 
    border-collapse: collapse;
}
td, th { 
    border: 1px solid #ddd;
    padding: 8px;
}
th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4286f4;
    color: white;
}
</style>
"@

# Run the SQL Query
$Results = Get-SQLData $Query

# If results are returned
If ($Results.count -ne 0) {

    # Convert results into html format
    $Html = $Results |
        ConvertTo-Html -Property 'ComputerName','Manufacturer','Model','OS','Client Version','SCCM Record Created','Last Active' -Head $style -Body "<h2>Top 10 Windows 10 Computers</h2>" -CssUri "http://www.w3schools.com/lib/w3.css"  | 
        Out-String

    # Send the email
    Send-MailMessage @EmailParams -Body $Html -BodyAsHtml
}
