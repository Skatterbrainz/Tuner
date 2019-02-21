function Invoke-TunerQuickSetup {
<#
.SYNOPSIS
    super-turbo-maxi-uber windows client configuration script thing
.DESCRIPTION
    yeah, what he just said
.PARAMETER NewName
    New computer name to apply (forces restart at the end)
.PARAMETER BGInfo
    Install and enable sysinternals bginfo desktop mod
.PARAMETER SkipCleanup
    Skip Appx cleanup
.PARAMETER SkipModules
    Skip installing or updating powershell modules list
.PARAMETER SkipUpdates
    Skip installing windows updates
.PARAMETER SkipChoco
    Skip installing or updating chocolatey packages
.EXAMPLE
    Invoke-TunerQuickSetup
    Installs and configures all defaults without renaming computer or installing BGinfo mod
.EXAMPLE
    Invoke-TunerQuickSetup -Configuration AppDev -NewName "Client3"
.EXAMPLE
    Invoke-TunerQuickSetup -Configuration SysAdmin -BGInfo
.EXAMPLE
    Invoke-TunerQuickSetup -Configuration SysAdmin -NewName "Client3" -BGInfo
.EXAMPLE
    Invoke-TunerQuickSetup -Configuration UberNerd -SkipCleanup -SkipModules -SkipUpdates
.EXAMPLE
    Invoke-TunerQuickSetup -Configuration AppDev -BGInfo -SkipCleanup -SkipModules -SkipUpdates
.EXAMPLE
    Invoke-TunerQuickSetup -NewName "Client3" -BGInfo -SkipCleanup -SkipModules -SkipUpdates -SkipChoco
.NOTES
    version 1.0.0 - David M. Stein
#>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [parameter(Mandatory=$False, HelpMessage="Tuner setup configuration")]
            [ValidateSet('Basic','AppDev','AppDevPro','SysAdmin','Consultant')]
            [string] $Configuration = "Basic",
        [parameter(Mandatory=$False)]
            [ValidateLength(0,15)]
            [string] $NewName = "",
        [switch] $BGInfo,
        [switch] $SkipCleanup,
        [switch] $SkipModules,
        [switch] $SkipUpdates,
        [switch] $SkipChoco
    )
    Start-Transcript -Path $env:USERPROFILE\documents\turbosetup_transcript.txt
    try {
        $time1 = (Get-Date)
        Invoke-TunerPSConfig
        if (!$SkipCleanup) { Invoke-TunerCleanup }
        if (!$SkipChoco)   { 
            $pkglist = @('office365proplus','microsoft-teams',
            '7zip','notepadplusplus','paint.net','vlc','brave','googlechrome',
            'google-backup-and-sync','jing','keepass')
            switch ($Configuration) {
                'Basic' {
                    $pkglist += "adobereader"
                    break;
                }
                'AppDev' {
                    $pkglist += @('visualstudio2017community','vscode','vscode-icons','vscode-powershell',
                        'vscode-csharp','vscode-mssql','vscode-azurerm-tools',
                        'slack','microsoftazurestorageexplorer','rdcman','git',
                        'putty','python3','teamviewer','nodejs','curl','pester',
                        'azurepowershell','wmiexplorer','git','sysinternals')
                    break;
                }
                'AppDevPro' {
                    $pkglist += @('visualstudio2017enterprise','vscode','vscode-icons','vscode-powershell',
                        'vscode-csharp','vscode-mssql','vscode-azurerm-tools','powerbi',
                        'slack','microsoftazurestorageexplorer','rdcman','git',
                        'putty','python3','teamviewer','nodejs','curl','pester',
                        'azurepowershell','wmiexplorer','git','sysinternals')
                    break;
                }
                'SysAdmin' {
                    $pkglist += @('vscode','vscode-icons','vscode-powershell',
                        'vscode-mssql','vscode-azurerm-tools','slack','microsoftazurestorageexplorer',
                        'rdcman','git','putty','python3','teamviewer','azurepowershell',
                        'wmiexplorer','git','sysinternals')
                    break;
                }
                'Consultant' {
                    $pkglist = @('visualstudio2017community','adobereader','vscode','vscode-icons',
                        'vscode-powershell','vscode-csharp','vscode-mssql','vscode-azurerm-tools',
                        'slack','microsoftazurestorageexplorer','pwsh','rdcman','git','putty','python3',
                        'teamviewer','soapui','firefox','brave','googlechrome','awscli','awstools.powershell',
                        'azurepowershell','wmiexplorer','git','sysinternals')
                    break;
                }
            }
            Invoke-TunerChocoPackages -PackageName $pkglist
        }
        if (!$SkipModules) { Invoke-TunerPSModules }
        if (!$SkipUpdates) { Invoke-TunerPatching }
        if ($BGInfo) { Install-TunerBGInfo }
        if (![string]::IsNullOrEmpty($NewName)) {
            Write-Host "renaming computer to $NewName" -ForegroundColor Magenta
            Rename-Computer -NewName $NewName -Force
            $restart = $True
            Write-Host "restart will be invoked at the end." -ForegroundColor Magenta
        }
        $time2 = (Get-Date)
        $rtime = [math]::Round((New-TimeSpan -Start $time1 -End $time2).TotalMinutes,2)
        Write-Host "total runtime: $rtime minutes" -ForegroundColor Green
    }
    catch {}
    finally { 
        Stop-Transcript 
        if ($restart -eq $True) { Restart-Computer -Force }
    }
}

Export-ModuleMember -Function Invoke-TunerQuickSetup 