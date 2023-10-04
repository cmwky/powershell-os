# Script: Geohash

A PowerShell script to convert Geohashes into Latitude and Longitude.

[Background Info](https://en.wikipedia.org/wiki/Geohash)

## **Features**
- **Precision**: Decodes geohashes into accurate lat-lng coordinates.

## **Usage**

1. Use the `Convert-GeohashToLatLng` function by providing it with a valid geohash:
   ```PowerShell
   Convert-GeohashToLatLng -geohash "YourGeohashStringHere"
   ```
2. The function will return the latitude and longitude coordinates.

---

# Script: GpxToLatLong

This script is designed to extract latitude and longitude pairs from a GPX file and save them to a `.txt` file.

## Usage

You can use the `ExtractGPXLatLong` function to process a GPX file:

```powershell
ExtractGPXLatLong -filePath "path_to_your_gpx_file.gpx"
```

---

# Script: HaversineDistance

A PowerShell script to calculate the distance between two points on Earth using latitude and longitude.

[Background Info](https://www.igismap.com/haversine-formula-calculate-geographic-distance-earth/)

## **Features**
- **Accuracy**: Uses the Haversine formula for precise distance calculation.
- **Flexibility**: Provide any two lat-lng points and get the distance in miles.

## **Usage**

1. Use the `Get-HaversineDistance` function by providing it with latitude and longitude of two points:
   ```PowerShell
   $distance = Get-HaversineDistance $latitude1 $longitude1 $latitude2 $longitude2
   ```

2. The function will return the distance in miles between the two points.
3. Display the result:
   ```PowerShell
   Write-Output "The distance between the two points is $($distance) miles."
   ```

## **Example**

For Eiffel Tower and Statue of Liberty:
```PowerShell
$lat1 = 48.8584; $long1 = 2.2945 # Eiffel Tower
$lat2 = 40.6892; $long2 = 74.0445 # Statue of Liberty

$distance = Get-HaversineDistance $lat1 $long1 $lat2 $long2
Write-Output "Distance: $($distance) miles."
```
