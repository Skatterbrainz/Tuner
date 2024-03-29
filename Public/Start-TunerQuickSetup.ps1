function Start-TunerQuickSetup {
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
		Start-TunerQuickSetup -Configuration AppDev -NewName "Client3"
		Installs chocolatey packages for 'appdev' user and renames computer to Client3
	.EXAMPLE
		Start-TunerQuickSetup -Configuration SysAdmin -BGInfo
		Installs default chocolatey packages and Sysinternals BGinfo with default options
	.EXAMPLE
		Start-TunerQuickSetup -Configuration SysAdmin -NewName "Client3" -BGInfo
		Installs chocolatey packages for 'sysadmin' user, renames computer to Client3 and installs Sysinternals BGInfo
	.EXAMPLE
		Start-TunerQuickSetup -Configuration Consultant -SkipCleanup -SkipModules -SkipUpdates
		Installs default chocolatey packages for 'consultant' user, skips Appx cleanup, PS modules and patching
	.EXAMPLE
		Start-TunerQuickSetup -Configuration AppDevPro -BGInfo
	.EXAMPLE
		Start-TunerQuickSetup -NewName "Client3" -BGInfo -SkipCleanup -SkipModules -SkipUpdates
		Installs default default chocolatey packages, renames computer to Client3, installs BGInfo,
		skips Appx cleanup, PS modules and patching
	.EXAMPLE
		Invoke-TunerQuickSetup -Configuration Basic -BGInfo -TimeZone 'Central Standard Time'
	.EXAMPLE
		Start-TunerQuickSetup -Configuration SysAdmin -ConfigurationsPath "x:\configfiles" -BGInfo -NewName "W10-TEST" -ForceRestart
		Installs default chocolatey packages for 'sysadmin' user from custom location x:\configfiles, installs BGInfo,
		renames computer to W10-TEST and forces a restart at the end
	.LINK
		https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerQuickSetup.md
	#>
	[CmdletBinding(SupportsShouldProcess = $True)]
	param (
		[parameter(Mandatory = $False, HelpMessage = "Tuner setup configuration for Chocolatey packages, and PowerShell modules")]
		[ValidateSet('Basic', 'AppDev', 'AppDevPro', 'SysAdmin', 'Consultant')]
		[string] $Configuration = "Basic",
		[parameter(Mandatory = $False, HelpMessage = "Path to custom configuration files")]
		[string] $ConfigurationsPath = "",
		[parameter(Mandatory = $False, HelpMessage = "New computer name")]
		[ValidateLength(0, 15)]
		[string] $NewName = "",
		[parameter(Mandatory = $False)]
		[string] $TimeZone = 'Eastern Standard Time',
		[parameter(Mandatory = $False, HelpMessage = "Install and enable BGInfo profile")]
		[switch] $BGInfo,
		[parameter(Mandatory = $False, HelpMessage = "Skip Appx clean-up")]
		[switch] $SkipCleanup,
		[parameter(Mandatory = $False, HelpMessage = "Skip installing PowerShell modules")]
		[switch] $SkipModules,
		[parameter(Mandatory = $False, HelpMessage = "Skip Windows updates")]
		[switch] $SkipUpdates,
		[parameter(Mandatory = $False, HelpMessage = "Skip Chocolatey package installations")]
		[switch] $SkipChoco,
		[parameter(Mandatory = $False, HelpMessage = "Skip time zone configuration")]
		[switch] $SkipTimeZone,
		[parameter(Mandatory = $False, HelpMessage = "Force a restart when finished")]
		[switch] $ForceRestart
	)
	Start-Transcript -Path $env:USERPROFILE\documents\turbosetup_transcript.txt
	$regpath = "HKCU:Software\Tuner"
	try {
		if (!(Test-AdminContext)) {
			throw "This function requires running PowerShell in Administrator context"
		}
		$time1 = (Get-Date)
		Invoke-TunerPSConfig
		if (!$SkipCleanup) {
			# call without -GridSelect option for fast-mode processing
			Invoke-TunerCleanup
		}
		if (!$SkipChoco) {
			Install-TunerChocoPackages -Path $ConfigurationsPath -FileName "$Configuration.txt"
		}
		if (!$SkipModules) { 
			switch ($Configuration) {
				'AppDevPro' {
					Invoke-TunerPSModules -Name ('azurerm', 'powerline', 'dbatools', 'carbon', 'platyps', 'pswindowsupdate', 'EditorServicesCommandSuite')
					break
				}
				'AppDev' {
					Invoke-TunerPSModules -Name ('azurerm', 'powerline', 'dbatools', 'carbon', 'platyps', 'EditorServicesCommandSuite')
					break
				}
				'Consultant' {
					Invoke-TunerPSModules -Name ('azurerm', 'powerline', 'dbatools', 'carbon', 'platyps', 'osbuilder', 'EditorServicesCommandSuite')
					break
				}
				'SysAdmin' {
					Invoke-TunerPSModules -Name ('azurerm', 'dbatools', 'carbon', 'osbuilder')
					break
				}
				default {
					Invoke-TunerPSModules -Name ('powerline', 'dbatools')
					break
				}
			} # switch
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
		$rtime = [math]::Round((New-TimeSpan -Start $time1 -End $time2).TotalMinutes, 2)
		$null = New-ItemProperty -Path $regpath -Name "ConfigurationName" -Value $Configuration -Force
		$null = New-ItemProperty -Path $regpath -Name "TimeZone" -Value $TimeZone -Force
		$null = New-ItemProperty -Path $regpath -Name "LastRun" -Value (Get-Date) -Force
		Write-Host "total runtime: $rtime minutes" -ForegroundColor Green
	}
	catch { }
	finally {
		Stop-Transcript
		if ($ForceRestart -or ($restart -eq $True)) { Restart-Computer -Force }
	}
}
