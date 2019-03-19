#requires -RunAsAdministrator
function Invoke-TunerPSModuleCheck {
    <#
    .SYNOPSIS
        Check PowerShell module installed versions
    .DESCRIPTION
        Check each installed PowerShell module against the latest available version
    .PARAMETER UpdateAll
        If version is older than on remote repository, install latest version
    .EXAMPLE 
        Invoke-TunerPSModuleCheck
    .EXAMPLE
        Invoke-TunerPSModuleCheck -UpdateAll
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$False, HelpMessage="Force update of outdated modules")]
        [switch] $UpdateAll
    )
    try {
        $Modules = Get-Module -ListAvailable | Sort-Object Name
        $Modules | Foreach-Object {
            $mdv = $_.Version -join '.'
            if ($rpm = Find-Module $_.Name -ErrorAction SilentlyContinue) {
                $rpv = $rpm.Version -join '.'
                if ($mdv -ne $rpv) {
                    if ($UpdateAll) {
                        Write-Host "updating module: $($_.Name) $mdv to $rpv" -ForegroundColor Magenta
                        Uninstall-Module -Name $_ -AllVersions -Force
                        Install-Module -Name $_ -AllowClobber -Force
                    }
                    else {
                        Write-Host "module is out of date: $($_.Name) $mdv :: Latest is $rpv" -ForegroundColor Yellow
                    }
                }
                else {
                    Write-Host "module is current: $($_.Name)" -ForegroundColor Green
                }
            }
            else {
                Write-Warning "module not found in repository: $($_.Name)"
            }
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerPSModuleCheck