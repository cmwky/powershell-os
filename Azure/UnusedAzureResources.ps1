class Database
{
    [String]$name
    [String]$server
    [Double]$usedSpace
    [Double]$totalSpace
    [Double]$percentUsed
}

$dbs = Get-AzResource | ? {$_.ResourceType -like '*databases'}

$list = New-Object -TypeName System.Collections.Generic.List[Database]

foreach($dbResource in $dbs) {
    
    #Write-Host "Reading $($dbResource.Name)..."
    $name = $dbResource.Name.Substring($dbResource.Name.IndexOf('/') + 1)
    $server = $dbResource.ParentResource.Substring($dbResource.ParentResource.IndexOf('/') + 1)
    
    $db = Get-AzSqlDatabase -DatabaseName $name -ServerName $server -ResourceGroupName $dbResource.ResourceGroupName

    $db_metric_storage = $db | Get-AzMetric -MetricName 'storage'
    $db_UsedSpace = $db_metric_storage.Data.Maximum | Select-Object -Last 1
    $db_UsedSpace = [math]::Round($db_UsedSpace / 1MB, 2)
    
    $db_metric_storage_percent = $db | Get-AzMetric -MetricName 'storage_percent'
    $db_UsedSpacePercentage = $db_metric_storage_percent.Data.Maximum | Select-Object -Last 1

    $toAdd = [Database]::new()
    $toAdd.name = $name
    $toAdd.server = $server
    $toAdd.usedSpace = $db_UsedSpace
    $toAdd.totalSpace = $db.MaxSizeBytes / 1MB
    $toAdd.percentUsed = $db_UsedSpacePercentage
    $list.Add($toAdd)

    Write-Host "Db Name: $($name)"
    Write-Host "Server: $($server)"
    Write-Host "Used Space: $($db_UsedSpace)MB of $($db.MaxSizeBytes / 1MB)MB ($($db_UsedSpacePercentage)%)"
    Write-Host ""
}

$list | Export-Csv -Path C:\src\databases.csv -NoTypeInformation


# Get all the App Service plans in the specified subscription
$appServicePlans = Get-AzAppServicePlan

# Loop through each App Service plan and check if it has any web apps
foreach ($plan in $appServicePlans) {
    $webApps = Get-AzWebApp -AppServicePlan $plan
    if ($webApps.Count -eq 0) {
        Write-Output "Empty App Service plan found: $($plan.Name)"
    }
}