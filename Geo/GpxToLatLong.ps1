function ExtractGPXLatLong {
    param (
        [Parameter(Mandatory=$true)]
        [string]$filePath
    )

    $gpxFile = Get-Item $filePath
    $gpxFileName = ($gpxFile.Name.Split('.'))[0]
    $gpxFileDirectory = $gpxFile.DirectoryName
    $gpxData = Get-Content $gpxFile -Raw

    # Using regex to extract lat/long values
    $regex = '<trkpt lat="([-+]?\d*\.\d+?)" lon="([-+]?\d*\.\d+?)">'
    $matches = [regex]::Matches($gpxData, $regex)

    # Create array of lat/long pairs
    $latLongPairs = $matches | ForEach-Object {
        "$($_.Groups[1].Value),$($_.Groups[2].Value)"
    }

    $latLongPairs | Out-File "$($gpxFileDirectory)\$($gpxFileName).txt" -Force
}
