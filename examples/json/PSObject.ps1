$obj = @"
{
  "createdDateTime": "xxxx-xx-xx",
  "receivedDateTime": "xxxx-xx-xx",
  "isRead": true,
  "from": {
    "emailAddress": {
      "name": "John",
      "adress": "john@onmicrosoftware.com"
    }
  },
  "toRecipients": [
    {
      "emailAddress": {
        "name": "Amy",
        "adress": "Amy@onmicrosoftware.com"
      }
    },
    {
      "emailAddress": {
        "name": "Amy",
        "adress": "Amy@onmicrosoftware.com"
      }
    }
  ]
}
"@ | ConvertFrom-Json

$flattened = $obj | ForEach-Object {
    return [PSCustomObject]@{
        createdDateTime = $_.createdDateTime
        receivedDateTime = $_.receivedDateTime
        from_name = $_.from.emailAddress.name
        from_adress = $_.from.emailAddress.adress
        to_name_1 = $_.toRecipients[0].emailAddress.name
        to_adress_1 = $_.toRecipients[0].emailAddress.adress
        to_name_2 = $_.toRecipients[1].emailAddress.name
        to_adress_2 = $_.toRecipients[1].emailAddress.adress
    }
}

#$flattened | Export-Csv $PSScriptRoot\mails.csv -Delimiter "" -Encoding UTF8
$flattened | Out-GridView