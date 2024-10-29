$filesToGroup = (Get-ChildItem (Get-Item .).FullName -Filter "*.CDR" |  Group {$_.LastWriteTime.ToString("yyyy-MM")})

foreach ($f in $filesToGroup) {
    mkdir $f.Name
}

foreach ($f in $filesToGroup) {
    foreach ($subf in $f.group) {
        $from = $subf.Name
        $to = Join-Path (Get-Item .) $f.Name
        Copy-Item $from $to
        Remove-Item $from
    }
}
