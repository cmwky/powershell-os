# Assuming you store your variables in a hash table or somewhere similar. Here's an example:
$variables = @{
    "bearerToken" = $null
    "bearerTokenExpiresOn" = 0
    "tenantId" = "YOUR_TENANT_ID"
    "clientId" = "YOUR_CLIENT_ID"
    "clientSecret" = "YOUR_CLIENT_SECRET"
    "resource" = "https://management.azure.com/"
}

# Check if the token needs to be refreshed
if (-not $variables["bearerToken"] -or (Get-Date).ToUniversalTime().Ticks -gt [DateTime]::FromBinary($variables["bearerTokenExpiresOn"]).Ticks) {

    # Prepare the body for the request
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $variables["clientId"]
        client_secret = $variables["clientSecret"]
        resource      = $variables["resource"]
    }

    # Make the request
    try {
        $response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($variables['tenantId'])/oauth2/token" -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
        
        # If the request is successful, set the token and expiry variables
        $variables["bearerToken"] = $response.access_token
        $variables["bearerTokenExpiresOn"] = (Get-Date).AddSeconds($response.expires_on).ToUniversalTime().Ticks

    } catch {
        Write-Error $_.Exception.Message
    }
}
