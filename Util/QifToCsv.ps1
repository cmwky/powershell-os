function Convert-QIFtoCSV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$QifFilePath,

        [Parameter(Mandatory=$true)]
        [string]$CsvFilePath
    )

    $csvData = @()
    Get-Content $QifFilePath | ForEach-Object {
        $line = $_.Trim()

        $date = $null
        $amount = $null
        $payee = $null
        $category = $null

        if ($line -match '^D(.+)') {
            $date = $matches[1]
        }
        elseif ($line -match '^T(.+)') {
            $amount = $matches[1]
        }
        elseif ($line -match '^P(.+)') {
            $payee = $matches[1]
        }
        elseif ($line -match '^L(.+)') {
            $category = $matches[1]

            $csvData += [PSCustomObject]@{
                Date = $date
                Amount = $amount
                Payee = $payee
                Category = $category
            }
        }
    }
    $csvData | Export-Csv -Path $CsvFilePath -NoTypeInformation
}
