function Get-DirectoryStructure {
    param (
        [Parameter(Mandatory=$true)]
        [string]$startLocation,
        
        [string[]]$excludePatterns = @(),
        
        [string[]]$summarizeFolders = @()
    )

    function RecursiveGet {
        param (
            [string]$currentPath,
            [int]$depth = 0
        )

        $items = Get-ChildItem $currentPath | Where-Object {
            $include = $true
            foreach ($pattern in $excludePatterns) {
                if ($_.FullName -like $pattern) {
                    $include = $false
                    break
                }
            }
            return $include
        }

        $itemCount = $items.Count
        $counter = 0
        $summarizeThisFolder = $summarizeFolders -contains (Get-Item $currentPath).Name

        foreach ($item in $items) {
            $counter++
            $prefix = '│   ' * ($depth - 1)
            
            if ($counter -eq $itemCount) {
                $prefix += '└── '
            } else {
                $prefix += '├── '
            }

            if ($summarizeThisFolder -and $counter -gt 3) {
                Write-Host "${prefix}..."
                break
            }

            if ($item.PSIsContainer) { # directory
                Write-Host "${prefix}$($item.Name)/"

                if ($excludePatterns -contains "*\$($item.Name)\*") {
                    Write-Host ('│   ' * $depth)  '└── ...'
                } else {
                    RecursiveGet -currentPath $item.FullName -depth ($depth + 1)
                }
            } else { # file
                Write-Host "${prefix}$($item.Name)"
            }
        }
    }

    Write-Host "$((Get-Item $startLocation).Name)/"
    RecursiveGet -currentPath $startLocation -depth 1
}

# Example Use Case
# Get-DirectoryStructure -startLocation "./demoEnvironment" -excludePatterns @('*\node_modules\*') -summarizeFolders @('controllers', 'views')
