param(
    [string]$myFilePath
)
$file = Get-Item $myFilePath -Force 
$basename = $file.basename

$null = $basename -match '^(?<name>\D+)(?<year>\d{4})\s(?<month>\d{2})'

$dateString = "{0}/{1}/01" -f $matches.year, $matches.month
$Datetime = $dateString | Get-Date
$Datetime = $Datetime.AddMonths(-1)

$newFilename = "{0} {1} {2}{3}" -f $matches.name, $Datetime.ToString('MM'), $Datetime.ToString('yyyy'), $file.Extension

return $newFilename

# The catch block simply outputs the original match in case the conversion to DateTime fails.
Get-ChildItem -Filter "*.txt" | Foreach-Object {
    $_.Name = [Regex]::Replace($_.Name, "(\d{6})(\.txt)$", {
        $match = $args[0]
        try {
            [DateTime]::ParseExact($match.Groups[1], "yyyyMM", $null).AddMonths(-1).ToString("MMyyyy") + $match.Groups[2]
        } catch {
            $match
        }
    })
}
