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

#Eiffel Tower
$lat1 = 48.8584
$long1 = 2.2945

#Statue of Liberty
$lat2 = 40.6892
$long2 = 74.0445

$distance = Get-HaversineDistance $lat1 $long1 $lat2 $long2

Write-Output "The distance between the two points is $($distance) miles."