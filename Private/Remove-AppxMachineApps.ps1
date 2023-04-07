function Remove-AppxMachineApps {
	[CmdletBinding(SupportsShouldProcess=$True)]
	param()
	$klist = @('Alarms','FeedbackHub','BingWeather','GetStarted','Solitaire',
		'SoundRecorder','YourPhone','Wallet','OneConnect','StickyNotes','OfficeHub',
		'3DViewer','Messaging','MixedReality.Portal','Office.OneNote','People','Print3D','Camera',
		'Maps','Photos','ScreenSketch','SkypeApp','Xbox','Zune')
	$appxlist = Get-AppxProvisionedPackage -Online | Select-Object DisplayName,PackageName | Sort-Object DisplayName
	foreach ($app in $appxlist) {
		foreach ($kill in $klist) {
			if ($app.DisplayName -match $kill) {
				try {
					if ($WhatIfPreference) {
						Write-Information "WhatIf: Remove-AppxPackage -PackageName $($app.PackageName) -AllUsers -Online"
					} else {
						Remove-AppxProvisionedPackage -PackageName $app.PackageName -AllUsers -Online -ErrorAction SilentlyContinue | Out-Null
					}
					Write-Host "removed: $($app.DisplayName)" -ForegroundColor Magenta
				} catch {
					Write-Warning "failed to remove package: $($app.DisplayName) - $($Error[0].Exception.Message)"
				}
			}
		}
	}
}