function Install-TunerChocoPackages {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [string] $Path = "",
        [string] $FileName = ""
    )
    if ($Path -eq "") {
        $path = Join-Path -Path $(Split-Path $PSScriptRoot) -ChildPath "Assets"
    }
    Write-Verbose "config file path: $path"
    try {
        $configfile = (Join-Path $path -ChildPath "$Configuration.txt")
        Write-Verbose "searching for config file: $configfile"
        if (Test-Path $configfile) {
            $pkglist = Get-Content -Path $configfile
            Write-Host "installing $($pkglist.Count) packages..." -ForegroundColor Magenta
            Invoke-TunerChocoPackages -PackageName $pkglist
        }
        else {
            Write-Warning "config file could not be found: $ConfigFile"
        }
    }
    catch {
        Write-Error "$($Error[0].Exception.Message)"
    }
}