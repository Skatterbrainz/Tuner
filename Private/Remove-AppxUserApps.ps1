function Remove-AppxUserApps {
	[CmdletBinding(SupportsShouldProcess=$True)]
	param()
	$klist = @('BingNews','windowscommunicationsapps','Whiteboard','NetworkSpeedTest','Office.Sway','OfficeLens','RemoteDesktop','Todos')
	$appxlist = Get-AppxPackage | Where-Object {$_.NonRemovable -eq $False} | Select-Object Name,PackageFullName,NonRemovable | Sort-Object Name
	foreach ($app in $appxlist) {
		Write-Host $app.Name -ForegroundColor Cyan
		foreach ($kill in $klist) {
			if ($app.Name -match $kill) {
				Write-Verbose "`tremoving: $($app.Name)"
				try {
					Remove-AppxPackage -Package $app.PackageFullName -Confirm:$False
					Write-Host "removed: $($app.Name)" -ForegroundColor Magenta
				} catch {
					Write-Warning "failed to remove package: $($app.Name) - $($Error[0].Exception.Message)"
				}
			}
		}
	}
}
