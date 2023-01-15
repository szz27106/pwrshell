$t1 = @"
[
    {
        "ItemID":  10746,
        "CompanyID":  3694,
        "Company":  "Sweet Mamma",
        "SRP":  0.0001,
        "UPC":  "9076625"
    },
    {
        "ItemID":  10761,
        "CompanyID":  3694,
        "Company":  "Sweet Mamma",
        "UPC":  "6128021"
    } 
]
"@

$t2 = @"
[
    {
        "ItemID":  477760,
        "CompanyID":  4398,
        "Company":  "Moonlight",
        "UPC":  "4000308"
    },
    {
        "ItemID":  477761,
        "CompanyID":  4398,
        "Company":  "Moonlight",
        "SRP":  14.6500,
        "UPC":  "099904000308"
    }
]
"@

$js1 = $t1 | ConvertFrom-Json
$js2 = $t2 | ConvertFrom-Json

$js1 + $js2 |
    ConvertTo-Json -Depth 5  #| Out-File -FilePath .\combinedfiles.json

$js1 + $js2 | Out-GridView

$js1 + $js2 | ConvertTo-Json

@($js1; $js2) | Out-GridView

# if you have objects that aren't arrays already you can just cast them to arrays
@($js1) + @($js2) | Out-GridView