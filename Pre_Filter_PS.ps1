Get-ChildItem -Directory | ForEach-Object {
    $files = Get-ChildItem $_.FullName -File -Recurse -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        Folder     = $_.Name
        FileCount  = $files.Count
        TotalSizeMB = [math]::Round(($files | Measure-Object Length -Sum).Sum / 1MB, 2)
    }
} | Sort-Object Folder | Export-Csv "FolderReport.csv" -NoTypeInformation