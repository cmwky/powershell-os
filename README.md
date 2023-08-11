# powershell-os  
*This repo contains an assortment of PowerShell scripts.*

## geohash.ps1

- [Background Info](https://en.wikipedia.org/wiki/Geohash)
- Converts a geohash to latitude / longitude pair.

## haversinedistance.ps1

- [Background Info](https://www.igismap.com/haversine-formula-calculate-geographic-distance-earth/)
- Given two pairs of latitude / longitude values, calculates the geographic distance between them.

## azureoauth2.ps1

- [Reference](https://learn.microsoft.com/en-us/rest/api/azure/)
- Fetches an OAuth2 token from Azure REST API.

## unusedazureresources.ps1

- Reports empty resources for:
  - SQL Dbs
  - App Service Plans
- User must already be logged in to Azure.

## filetoazurestoragecontainer.ps1

- Sends a file to a storage container using access key.