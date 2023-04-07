function Start-TuneUp {
	[CmdletBinding()]
	<#
	.SYNOPSIS
		Re-apply Invoke-TunerQuickSetup configuration items
	.DESCRIPTION
		Performs a subset of Invoke-TunerQuickSetup: Patching, Chocolatey Packages, and 
		(optionally) PowerShell module updates, if -Full is used.
	.PARAMETER Full
		Invokes PowerShell module check-up and updates (Invoke-TunerPSModuleCheck -UpdateAll)
		If omitted, invokes Chocolatey packages (Invoke-TunerChocoPackages) and Patching (Invoke-TunerPatching)
	.EXAMPLE
		Start-Tuneup
	.EXAMPLE
		Start-Tuneup -Full
	.LINK
		https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TuneUp.md
	#>
	param (
		[parameter(Mandatory = $False, HelpMessage = "Run full tune-up")]
		[switch] $Full
	)
	$regpath = 'HKCU:Software\Tuner'
	try {
		if (!(Test-AdminContext)) {
			throw "This function requires running PowerShell in Administrator context"
		}
		Write-Verbose "reading defaults from registry"
		$key = Get-Item -Path $regpath -ErrorAction Stop
		$config = $key.GetValue('ConfigurationName')
		if ([string]::IsNullOrEmpty($config)) {
			Write-Warning "Invoke-TunerQuickSetup needs to be executed at least once before using this function"
			break
		}
		Write-Verbose "updating chocolatey packages"
		#Invoke-TunerChocoPackages -Configuration $config
		choco upgrade all -y
		if ($Full) {
			Write-Verbose "updating powershell modules"
			Invoke-TunerPSModuleCheck -UpdateAll
		}
		Write-Verbose "checking for microsoft updates"
		Invoke-TunerPatching
		Write-Verbose "updating registry timestamp"
		New-ItemProperty -Path $regpath -Name "LastRun" -Value (Get-Date) -Force
	} catch {
		Write-Error $Error[0].Exception.Message
	}
	Write-Host "tune-up completed!" -ForegroundColor Green
}