$filesToGroup = (Get-ChildItem -File | Group-Object {$_.LastWriteTime.ToString("yyyy-MM")})

foreach ($f in $filesToGroup) {
    if (Test-Path $f.name) {
        Write-Host "Folder already exists."
    }
    else {
        New-Item -ItemType Directory -Path $f.Name
    }
}

foreach ($f in $filesToGroup) {
    foreach ($subf in $f.group) {
        $from = $subf.Name
        $to = Join-Path (Get-Item .) $f.Name
        Copy-Item $from $to
        Remove-Item $from
    }
}
