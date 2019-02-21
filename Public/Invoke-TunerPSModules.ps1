function Invoke-TunerPSModules {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [parameter(Mandatory=$False, HelpMessage="Name of one or more modules")]
        [string[]] $Name = "",
        [switch] $CheckOnly,
        [switch] $SampleList
    )
    try {
        Write-Host "updating or installing powershell modules..." -ForegroundColor Cyan
        if ([string]::IsNullOrEmpty($Name)) {
            if ($SampleList) {
                $Name = @('azurerm','powerline','dbatools','carbon','platyps','pswindowsupdate','osbuilder')
            }
            else {
                throw "Module name was not provided"
            }
        }
        elseif ($Name -eq '*') {
            $Name = Get-Module -ListAvailable | Sort-Object Name | Select-Object -ExpandProperty Name
        }
        $modules | ForEach-Object {
            if ($mdx = Get-Module $_ -ListAvailable) {
                $mdv = $mdx.Version -join '.'
                try {
                    if ($fdx = Find-Module $_) {
                        $fdv = $fdx.Version -join '.'
                        if ($mdv -ne $fdv) {
                            if ($CheckOnly) {
                                Write-Host "installed: $mdv / available: $fdv" -ForegroundColor Magenta
                            }
                            else {
                                Write-Host "updating $_ from $mdv to $fdv" -ForegroundColor Magenta
                                Uninstall-Module -Name $_ -AllVersions -Force
                                Install-Module -Name $_ -AllowClobber -Force
                            }
                        }
                        else {
                            Write-Host "$_ $mdv is latest" -ForegroundColor Green
                        }
                    }
                    else {
                        Write-Host "$_ is no longer on the gallery" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Error $Error[0].Exception.Message
                }
            }
            else {
                if ($CheckOnly) {
                    Write-Host "$_ is not installed" -ForegroundColor Cyan
                }
                else {
                    Write-Host "installing $_" -ForegroundColor Magenta
                    Install-Module -Name $_ -AllowClobber -Force
                }
            }
        }
    }
    catch {}    
}

Export-ModuleMember -Function Invoke-TunerPSModules