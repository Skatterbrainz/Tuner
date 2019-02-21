function Set-TunerChoco {
    param ()
    Write-Verbose "verifying chocolatey..."
    if (!(Test-Path "$env:ProgramData\chocolatey\choco.exe")) {
        Write-Host "installing chocolatey..." -ForegroundColor Cyan
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    else {
        Write-Host "chocolately is already installed" -ForegroundColor Cyan
    }
}