$Configuration = "basic"
$PkgListPath = Join-Path -Path $(Split-Path $PSScriptRoot) -ChildPath "Assets"
Write-Host "configuration files path: $PkgListPath"
$pkglist = Get-Content -Path (Join-Path $PkgListPath -ChildPath "$Configuration.txt")
$pkglist