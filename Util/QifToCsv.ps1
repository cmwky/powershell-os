function Convert-QIFtoCSV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$QifFilePath,

        [Parameter(Mandatory=$true)]
        [string]$CsvFilePath
    )

    # Initialize an array to store the CSV data
    $csvData = @()

    # Read the QIF file line by line
    Get-Content $QifFilePath | ForEach-Object {
        $line = $_.Trim()

        # Define variables to store extracted data
        $date = $null
        $amount = $null
        $payee = $null
        $category = $null

        # Check if the line starts with "D" (Date)
        if ($line -match '^D(.+)') {
            $date = $matches[1]
        }
        # Check if the line starts with "T" (Transaction Amount)
        elseif ($line -match '^T(.+)') {
            $amount = $matches[1]
        }
        # Check if the line starts with "P" (Payee/Description)
        elseif ($line -match '^P(.+)') {
            $payee = $matches[1]
        }
        # Check if the line starts with "L" (Category/Label)
        elseif ($line -match '^L(.+)') {
            $category = $matches[1]

            # Create a new object with the extracted data and add it to the CSV array
            $csvData += [PSCustomObject]@{
                Date = $date
                Amount = $amount
                Payee = $payee
                Category = $category
            }
        }
    }

    # Export the CSV data to a CSV file
    $csvData | Export-Csv -Path $CsvFilePath -NoTypeInformation

    Write-Host "Conversion complete. CSV file saved to $CsvFilePath"
}
