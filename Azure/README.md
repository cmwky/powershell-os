# Script: AzureOAuth2

`Get-AzureBearerToken` is a PowerShell function to fetch an Azure bearer token using client credentials.

## Parameters

- **tenantId**: Your Azure AD tenant ID.
- **clientId**: Azure AD application ID.
- **clientSecret**: Secret key of the Azure AD application.
- **resource**: Target Azure service (Default: `https://management.azure.com/`).

## Returns

1. Bearer token.
2. Token expiration time (ticks).

## Usage

```powershell
$variables = @{
    "bearerToken" = $null
    "bearerTokenExpiresOn" = 0
    "tenantId" = "TENANT_ID_HERE"
    "clientId" = "CLIENT_ID_HERE"
    "clientSecret" = "SECRET_HERE"
    "resource" = "https://management.azure.com/"
}

$token, $expiresOn = Get-AzureBearerToken -tenantId $variables["tenantId"] `
                                          -clientId $variables["clientId"] `
                                          -clientSecret $variables["clientSecret"] `
                                          -resource $variables["resource"]

$variables["bearerToken"] = $token
$variables["bearerTokenExpiresOn"] = $expiresOn
```

**Note**: Ensure the Azure AD app has required permissions for the targeted service.

[Reference](https://learn.microsoft.com/en-us/rest/api/azure/)

---

# Script: UnusedAzureResources

A PowerShell script to gather metrics on Azure SQL databases and identify unused App Service plans.

## **Features**

1. **Database Metrics**: Fetches details of Azure SQL databases, including used space, total space, and usage percentage.

2. **App Service Check**: Identifies App Service plans without any associated web apps.

## **Usage**

Run the script. It will:
- Export database details to a CSV file (`C:\src\databases.csv`).
- Print names of unused App Service plans.

## **Prerequisites**
- Azure PowerShell module.
- Azure authentication. 

**Note**: Adjust the path (`C:\src\databases.csv`) if needed and ensure adequate permissions for Azure operations.

---

# Script: FileToAzureStorageContainer

A concise PowerShell script to upload a file to an Azure Storage Blob.

## **Features**

- **Quick Upload**: Easily upload a file to your specified Azure Storage Blob.

## **Usage**

1. Fill in the script's variables:
    - `$storageAccountName`: Your storage account name.
    - `$storageAccountRg`: Your storage account resource group (unused in the current script but can be used for future enhancements).
    - `$containerName`: Destination blob container's name.
    - `$storageAccessKey`: Storage account access key.
    - `$filePath`: Path of the file you wish to upload.

2. Run the script. Your file will be uploaded to the specified Azure Storage Blob.

## **Prerequisites**
- Azure PowerShell module.
- Properly configured Azure authentication.

**Note**: Ensure you have adequate permissions to perform operations on the Azure Storage Account.
