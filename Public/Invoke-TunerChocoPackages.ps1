function Invoke-TunerChocoPackages {
    <#
    .SYNOPSIS
        Installs list of Chocolatey packages
    .DESCRIPTION
        Installs list of Chocolatey packages
    .PARAMETER PackageName
        Name of one or more Chocolatey packages to upgrade or install.
        Note that if a given package is not installed, it will be installed.
    .EXAMPLE
        Invoke-TunerChocoPackages -PackageName ('7zip','vlc','notepadplusplus')
    .LINK
        https://chocolatey.org
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string[]] $PackageName
    )
    try {
        Set-TunerChoco
        Write-Verbose "installing chocolatey packages (you may want to grab lunch)..."
        $counter = 0
        $PackageName | ForEach-Object { cup $_ -y; $counter++ }
        Write-Host "$counter packages were processed" -ForegroundColor Green
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerChocoPackages
