function Invoke-TunerQuickSetup {
    <#
    .SYNOPSIS
        Quick configuration with default parameters
    .DESCRIPTION
        Quick configuration of Windows machine based on user roles like 
        Basic, AppDev, AppDevPro, SysAdmin, and Consultant.  Invokes the other
        functions to cleanup, configure and so forth.
    .PARAMETER Configuration
        User role-based configuration template: Basic (default), AppDev, AppDevPro,
        SysAdmin and Consultant.  Controls the chocolatey packages that get installed
        and additional PowerShell modules that will be installed.
    .PARAMETER ConfigurationsPath
        Custom path to configuration .txt files (basic.txt, appdev.txt, etc.)
    .PARAMETER NewName
        New computer name to apply (forces restart at the end)
    .PARAMETER BGInfo
        Install and enable sysinternals bginfo desktop mod
    .PARAMETER TimeZone
        Set timezone (default: Eastern Standard Time)
    .PARAMETER SkipCleanup
        Skip Appx cleanup
    .PARAMETER SkipModules
        Skip installing or updating powershell modules list
    .PARAMETER SkipUpdates
        Skip installing windows updates
    .PARAMETER SkipChoco
        Skip installing or updating chocolatey packages
    .PARAMETER SkipTimeZone
        Skip setting the active time zone (otherwise -TimeZone is applied)
    .PARAMETER ForceRestart
        Forces the computer to restart at the very end of processing
    .EXAMPLE
        Invoke-TunerQuickSetup
        Installs and configures all defaults without renaming computer or installing BGinfo mod
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration AppDev -NewName "Client3"
        Installs chocolatey packages for 'appdev' user and renames computer to Client3
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration SysAdmin -BGInfo
        Installs default chocolatey packages and Sysinternals BGinfo with default options
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration SysAdmin -NewName "Client3" -BGInfo
        Installs chocolatey packages for 'sysadmin' user, renames computer to Client3 and installs Sysinternals BGInfo
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration Consultant -SkipCleanup -SkipModules -SkipUpdates
        Installs default chocolatey packages for 'consultant' user, skips Appx cleanup, PS modules and patching
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration AppDevPro -BGInfo
    .EXAMPLE
        Invoke-TunerQuickSetup -NewName "Client3" -BGInfo -SkipCleanup -SkipModules -SkipUpdates
        Installs default default chocolatey packages, renames computer to Client3, installs BGInfo, 
        skips Appx cleanup, PS modules and patching
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration Basic -BGInfo -TimeZone 'Central Standard Time'
    .EXAMPLE
        Invoke-TunerQuickSetup -Configuration SysAdmin -ConfigurationsPath "x:\configfiles" -BGInfo -NewName "W10-TEST" -ForceRestart
        Installs default chocolatey packages for 'sysadmin' user from custom location x:\configfiles, installs BGInfo, 
        renames computer to W10-TEST and forces a restart at the end
    .LINK
        https://www.powershellgallery.com/packages/PSWindowsUpdate
        https://chocolatey.org
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param (
        [parameter(Mandatory=$False, HelpMessage="Tuner setup configuration")]
            [ValidateSet('Basic','AppDev','AppDevPro','SysAdmin','Consultant')]
            [string] $Configuration = "Basic",
        [string] $ConfigurationsPath = "",
        [parameter(Mandatory=$False)]
            [ValidateLength(0,15)]
            [string] $NewName = "",
        [parameter(Mandatory=$False)]
            [string] $TimeZone = 'Eastern Standard Time',
        [switch] $BGInfo,
        [switch] $SkipCleanup,
        [switch] $SkipModules,
        [switch] $SkipUpdates,
        [switch] $SkipChoco,
        [switch] $SkipTimeZone,
        [switch] $ForceRestart
    )
    Start-Transcript -Path $env:USERPROFILE\documents\turbosetup_transcript.txt
    try {
        $time1 = (Get-Date)
        Invoke-TunerPSConfig
        if (!$SkipCleanup) { 
            # call without -GridSelect option for fast-mode processing
            Invoke-TunerCleanup 
        }
        if (!$SkipChoco)   { 
            Install-TunerChocoPackages -Path $ConfigurationsPath -FileName "$Configuration.txt"
        }
        if (!$SkipModules) { 
            Invoke-TunerPSModules -Name ('azurerm','powerline','dbatools','carbon','platyps','pswindowsupdate','osbuilder') 
        }
        if (!$SkipUpdates) { 
            Invoke-TunerPatching 
        }
        if ($BGInfo) { 
            Install-TunerBGInfo
        }
        if (!$SkipTimeZone) {
            Set-TunerTimeZone -TimeZone $TimeZone
        }
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
        if ($ForceRestart -or ($restart -eq $True)) { Restart-Computer -Force }
    }
}

Export-ModuleMember -Function Invoke-TunerQuickSetup 