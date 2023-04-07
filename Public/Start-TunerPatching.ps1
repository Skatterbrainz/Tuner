function Start-TunerPatching {
	<#
	.SYNOPSIS
		Installs pending updates for Windows computer
	.DESCRIPTION
		Installs pending updates for Windows computer
	.EXAMPLE
		Start-TunerPatching
	.LINK
		https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPatching.md
	#>
	[CmdletBinding(SupportsShouldProcess = $True)]
	param()
	try {
		if (!(Test-AdminContext)) {
			throw "This function requires running PowerShell in Administrator context"
		}
		Write-Host "installing pending updates..." -ForegroundColor Cyan
		$ulist = Get-WindowsUpdate
		if ($ulist.Count -gt 0) {
			Get-WindowsUpdate -Download -AcceptAll -RecurseCycle 3 -Install -IgnoreReboot -Confirm:$False -ErrorAction Stop
		} else {
			Write-Host "no pending updates were found" -ForegroundColor Green
		}
	} catch {
		Write-Error $Error[0].Exception.Message
	}
}
