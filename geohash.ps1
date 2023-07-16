function Convert-GeohashToLatLng {
    param (
        [Parameter(Mandatory=$true)]
        [string]$geohash
    )

    $base32 = "0123456789bcdefghjkmnpqrstuvwxyz"
    $lon = @(-180, 180)
    $lat = @(-90, 90)

    $isEven = $true
    $geohash.ToCharArray() | ForEach-Object {
        $c = $base32.IndexOf($_)

        for ($i=4; $i -ge 0; $i--) {
            $mask = [math]::Pow(2, $i)
            if ($isEven) {
                if (($c -band $mask) -ne 0) {
                    $lon[0] = ($lon[0] + $lon[1]) / 2
                } else {
                    $lon[1] = ($lon[0] + $lon[1]) / 2
                }
            } else {
                if (($c -band $mask) -ne 0) {
                    $lat[0] = ($lat[0] + $lat[1]) / 2
                } else {
                    $lat[1] = ($lat[0] + $lat[1]) / 2
                }
            }
            $isEven = !$isEven
        }
    }
    return @( (($lat[0] + $lat[1]) / 2), (($lon[0] + $lon[1]) / 2 ))
}

# Call the function
Convert-GeohashToLatLng -geohash "u09tunquc9zh"
