function Get-AzureBearerToken {
    param (
        [Parameter(Mandatory=$true)][string]$tenantId,
        [Parameter(Mandatory=$true)][string]$clientId,
        [Parameter(Mandatory=$true)][string]$clientSecret,
        [Parameter(Mandatory=$false)][string]$resource = "https://management.azure.com/"
    )

    $body = @{
        grant_type    = "client_credentials"
        client_id     = $clientId
        client_secret = $clientSecret
        resource      = $resource
    }

    try {
        $response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/token" `
                                      -Method Post `
                                      -Body $body `
                                      -ContentType "application/x-www-form-urlencoded"
        
        $token = $response.access_token
        $expiresOn = (Get-Date).AddSeconds($response.expires_on).ToUniversalTime().Ticks
        return $token, $expiresOn

    } catch {
        Write-Error $_.Exception.Message
        return $null, $null
    }
}