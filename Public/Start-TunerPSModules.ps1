function Start-TunerPSModules {
	<#
	.SYNOPSIS
		Installs or Updates one or more PowerShell modules
	.DESCRIPTION
		Installs or Updates one or more PowerShell modules
	.PARAMETER Name
		Name of one or more PowerShell modules to install or update
	.EXAMPLE
		Start-TunerPSModules -Name @('dbatools','carbon')
	.LINK
		https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModules.md
	#>
	[CmdletBinding(SupportsShouldProcess = $True)]
	param(
		[parameter(Mandatory = $True, HelpMessage = "Name of one or more modules")]
		[ValidateNotNullOrEmpty()]
		[string[]] $Name
	)
	try {
		if (!(Test-AdminContext)) {
			throw "This function requires running PowerShell in Administrator context"
		}
		Write-Host "updating or installing powershell modules..." -ForegroundColor Cyan
		$Name | ForEach-Object {
			if ($mdx = Get-Module $_ -ListAvailable) {
				$mdv = $mdx.Version -join '.'
				try {
					if ($fdx = Find-Module $_) {
						$fdv = $fdx.Version -join '.'
						if ($mdv -ne $fdv) {
							if ($CheckOnly) {
								Write-Host "installed: $mdv / available: $fdv" -ForegroundColor Magenta
							} else {
								Write-Host "updating $_ from $mdv to $fdv" -ForegroundColor Magenta
								Uninstall-Module -Name $_ -AllVersions -Force
								Install-Module -Name $_ -AllowClobber -Force
							}
						} else {
							Write-Host "$_ $mdv is latest" -ForegroundColor Green
						}
					} else {
						Write-Host "$_ is no longer on the gallery" -ForegroundColor Yellow
					}
				} catch {
					Write-Error $Error[0].Exception.Message
				}
			} else {
				if ($CheckOnly) {
					Write-Host "$_ is not installed" -ForegroundColor Cyan
				} else {
					Write-Host "installing $_" -ForegroundColor Magenta
					Install-Module -Name $_ -AllowClobber -Force
				}
			}
		}
	}
	catch {}
}