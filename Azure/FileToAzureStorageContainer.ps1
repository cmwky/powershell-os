$storageAccountName = ""
$storageAccountRg = ""
$containerName = ""
$storageAccessKey = ""
$filePath = ""

$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccessKey
Set-AzStorageBlobContent -File $filePath -Container $containerName -Context $storageContext