function Invoke-TunerChocoPackages {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string[]] $PackageName
    )
    try {
        Set-TunerChoco
        Write-Verbose "installing chocolatey packages (you may want to grab lunch)..."
        $PackageName | ForEach-Object { cup $_ -y }
        Write-Host "packages have been processed" -ForegroundColor Green
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerChocoPackages
