$leases =
'IP,Name
192.168.1.1,Apple
192.168.1.2,Pear
192.168.1.3,Banana
192.168.1.99,FishyPC' | convertfrom-csv

$reservations =
'IP,MAC
192.168.1.1,001D606839C2
192.168.1.2,00E018782BE1
192.168.1.3,0022192AF09C
192.168.1.4,0013D4352A0D' | convertfrom-csv

$j = $leases |ConvertTo-Json
$j | ConvertFrom-Json | Out-GridView
$j | ConvertFrom-Json | ForEach-Object { $_ } | Out-GridView

$reservations |ConvertTo-Xml
