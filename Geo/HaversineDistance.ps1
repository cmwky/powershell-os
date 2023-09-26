function ConvertTo-Radian($degree) {
    return $degree * [Math]::PI / 180
}

function Get-HaversineDistance($lat1, $long1, $lat2, $long2) {
    # Define Earth's radius in miles
    $earthRadius = 3959

    $dLat = ConvertTo-Radian ($lat2 - $lat1)
    $dLong = ConvertTo-Radian ($long2 - $long1)

    $a = [Math]::Sin($dLat / 2) * [Math]::Sin($dLat / 2) +
         [Math]::Cos((ConvertTo-Radian $lat1)) * [Math]::Cos((ConvertTo-Radian $lat2)) *
         [Math]::Sin($dLong / 2) * [Math]::Sin($dLong / 2)

    $c = 2 * [Math]::Atan2([Math]::Sqrt($a), [Math]::Sqrt(1-$a))

    return $earthRadius * $c
}