#requires -RunAsAdministrator
function Invoke-TunerChocoPackages {
    <#
    .SYNOPSIS
        Installs list of Chocolatey packages
    .DESCRIPTION
        Installs list of Chocolatey packages
    .PARAMETER PackageName
        Name of one or more Chocolatey packages to upgrade or install.
        Note that if a given package is not installed, it will be installed.
    .PARAMETER Configuration
        User role-based configuration template: Basic (default), AppDev, AppDevPro,
        SysAdmin and Consultant.  Controls the chocolatey packages that get installed
        and additional PowerShell modules that will be installed.
    .PARAMETER ConfigurationsPath
        Custom path to configuration .txt files (basic.txt, appdev.txt, etc.)
    .EXAMPLE
        Invoke-TunerChocoPackages 
        Installs list from "Basic" profile configuration (see /assets/basic.txt for list of packages)
    .EXAMPLE
        Invoke-TunerChocoPackages 'vlc'
        Installs VLC player package only
    .EXAMPLE
        Invoke-TunerChocoPackages -PackageName ('7zip','vlc','notepadplusplus')
        Installs packages named in array
    .EXAMPLE
        Invoke-TunerChocoPackages -Configuration Consultant -ConfigurationPath "\\server3\docs\configs\"
        Install list from "Consultant" profile configuration found in custom path "\\server3\docs\configs\"
    .NOTES
        If -PackageName is not empty/null, it overrides the -Configuration parameter (one or the other only)
    .LINK
        https://chocolatey.org
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [parameter(Mandatory=$False, HelpMessage="Chocolatey Package names")]
            [ValidateNotNullOrEmpty()]
            [string[]] $PackageName = "",
        [parameter(Mandatory=$False, HelpMessage="Tuner setup configuration")]
            [ValidateSet('Basic','AppDev','AppDevPro','SysAdmin','Consultant')]
            [string] $Configuration = "Basic",
        [parameter(Mandatory=$False, HelpMessage="Path to custom configuration files")]
            [string] $ConfigurationsPath = ""
    )
    try {
        Set-TunerChoco
        Write-Verbose "installing chocolatey packages (you may want to grab lunch)..."
        $counter = 0
        if ([string]::IsNullOrEmpty($PackageName)) {
            Install-TunerChocoPackages -Path $ConfigurationsPath -FileName "$Configuration.txt"
        }
        else {
            $PackageName | ForEach-Object { cup $_ -y; $counter++ }
            Write-Host "$counter packages were processed" -ForegroundColor Green
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerChocoPackages
