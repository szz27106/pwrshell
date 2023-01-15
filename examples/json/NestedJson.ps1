$report = Get-Content "$PSScriptRoot\products.json" -Raw | ConvertFrom-Json

$report | Select-Object * |ForEach-Object {
    foreach($seatUsage in $_.companySeatUsages) {
        foreach($product in $seatUsage.productSeatUsages) {
            foreach($summary in $product.summary) {
                [PSCustomObject] @{
                    timestamp = $seatUsage.timestamp
                    companyName = $seatUsage.companyName
                    product = $product.product
                    usage = $summary.currentSeatUsage
                }                        
            }
        }
    }
} | Out-GridView