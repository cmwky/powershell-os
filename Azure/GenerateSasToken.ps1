function Get-AzureServiceBusSASToken {
    param (
        [Parameter(Mandatory = $true)]
        [string]$NamespaceUri,

        [Parameter(Mandatory = $true)]
        [string]$QueueName,

        [Parameter(Mandatory = $true)]
        [string]$AccessPolicyName,

        [Parameter(Mandatory = $true)]
        [string]$AccessPolicyKey,

        [int]$TokenExpiryInSeconds = 3000
    )

    # Load required assembly
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null

    # Compute expiry time
    $Expires = ([DateTimeOffset]::Now.ToUnixTimeSeconds()) + $TokenExpiryInSeconds

    # URI for the Service Bus Queue
    $Uri = "$NamespaceUri/$QueueName"

    # Compute SAS token
    $SignatureString = [System.Web.HttpUtility]::UrlEncode($Uri) + "`n" + [string]$Expires
    $HMAC = New-Object System.Security.Cryptography.HMACSHA256
    $HMAC.key = [Text.Encoding]::UTF8.GetBytes($AccessPolicyKey)
    $Signature = $HMAC.ComputeHash([Text.Encoding]::UTF8.GetBytes($SignatureString))
    $Signature = [Convert]::ToBase64String($Signature)
    $SASToken = "SharedAccessSignature sr=" + [System.Web.HttpUtility]::UrlEncode($Uri) + "&sig=" + [System.Web.HttpUtility]::UrlEncode($Signature) + "&se=" + $Expires + "&skn=" + $AccessPolicyName

    return $SASToken
}

# Example of how to call the function:
$token = Get-AzureServiceBusSASToken -NamespaceUri "mynamespace.servicebus.windows.net" -QueueName "myQueue" -AccessPolicyName "cmwky-accesskey" -AccessPolicyKey "OQWtZ5ChUpYGYTmHGaA9mdTGKlQQ78iVysJWXY0UzjHFQ=="
Write-Output $token
