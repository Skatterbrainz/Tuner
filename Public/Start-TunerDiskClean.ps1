function Start-TunerDiskClean {
	<#
	.SYNOPSIS
		Clean up local disks
	.DESCRIPTION
		Clean up local disks
	.PARAMETER none
	.EXAMPLE
		Start-TunerDiskClean
	.EXAMPLE
		Start-TunerDiskClean -WhatIf
	.LINK
		https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerDiskClean.md
	#>
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[parameter()][string][ValidateSet('C','D','E','F','G','H','I','J','K')]$Disk = 'C'
	)
	try {
		$ldsk = Get-CimInstance -ClassName "Win32_LogicalDisk" -Namespace "root\cimv2" | Where-Object { $_.DeviceID -eq "$Disk`:" }
		$used = $ldsk.Size - $ldsk.FreeSpace
		Write-Host "Space used on $($Disk)`: = $used"
		$upct = $([math]::Round($used / $ldsk.Size, 2) * 100)
		Write-Host "Percent used on $($Disk)`: = $upct`%"
		Write-Host "Running disk cleanup..."
		$HKLM = [UInt32] "0x80000002"
		$strKeyPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
		$strValueName = "StateFlags0065"
		$subkeys = Get-ChildItem -Path "HKLM:\$strKeyPath" -Name
		Write-Host "-- Enumerating $($subkeys.Count) cleanup targets"
		$index = 1
		foreach ($subkey in $subkeys) {
			Write-Verbose "-- subkey [$index] of [$($subkeys.Count)]: $subkey"
			try {
				$null = New-ItemProperty -Path "HKLM:\$strKeyPath\$subkey" -Name $strValueName -PropertyType DWord -Value 2 -ErrorAction SilentlyContinue
			}
			catch { }
			try {
				Write-Host "-- Running cleanmgr /sagerun:65"
				Start-Process cleanmgr -ArgumentList "/sagerun:65" -Wait -NoNewWindow -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			catch { }
			$index++
		}
		ForEach ($subkey in $subkeys) {
			try {
				Write-Host "-- Removing registry value: HKLM`:\$($strKeyPath)\$($subkey) - $strValueName"
				$null = Remove-ItemProperty -Path "HKLM:\$strKeyPath\$subkey" -Name $strValueName
			}
			catch { }
		}
		Write-Host "complete!"
		$ldsk = Get-CimInstance -ClassName "Win32_LogicalDisk" -Namespace "root\cimv2" | Where-Object { $_.DeviceID -eq "$Disk`:" }
		$used = $ldsk.Size - $ldsk.FreeSpace
		$upct = [math]::Round($ldsk.Size / $used, 2)
		Write-Host "Drive $($Disk)`: is now $upct`% used"
	} catch {
		$err = $error[0]
		if ($err.Exception.Message -match "Access to the path") {
			Write-Warning "Access denied to one of the objects in the $($env:TEMP) path"
		} else {
			Write-Error "Error: $($_.Exception.Message -join ';')"
		}
	}
}
