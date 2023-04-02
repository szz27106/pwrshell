Get-Service -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like "Dell*"} | Stop-Service

# Get-Service -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like "Dell*"}|Set-Service  -StartupType "AutomaticDelayedStart"