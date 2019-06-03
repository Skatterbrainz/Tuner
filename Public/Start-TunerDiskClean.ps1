#requires -RunAsAdministrator

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
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    try {
        #        $ldsk = Get-CimInstance -ClassName "Win32_LogicalDisk" -Namespace "root\cimv2" | Where-Object { $_.DeviceID -eq "$Disk`:" }
        #        $used = $ldsk.Size - $ldsk.FreeSpace
        #        $upct = [math]::Round($ldsk.Size / $used, 2)
        #        Write-Output "$upct`% used"
        Write-Output "running disk cleanup"
        $HKLM = [UInt32] “0x80000002”
        $strKeyPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
        $strValueName = "StateFlags0065"
        $subkeys = Get-ChildItem -Path "HKLM:\$strKeyPath" -Name
        Write-Output "enumerating $($subkeys.Count) cleanup targets"
        $index = 1
        foreach ($subkey in $subkeys) {
            Write-Output "subkey [$index] of [$($subkeys.Count)]: $subkey"
            try {
                New-ItemProperty -Path "HKLM:\$strKeyPath\$subkey" -Name $strValueName -PropertyType DWord -Value 2 -ErrorAction SilentlyContinue | Out-Null
            }
            catch { }
            try {
                Start-Process cleanmgr -ArgumentList "/sagerun:65" -Wait -NoNewWindow -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            }
            catch { }
        }
        ForEach ($subkey in $subkeys) {
            try {
                Remove-ItemProperty -Path "HKLM:\$strKeyPath\$subkey" -Name $strValueName | Out-Null
            }
            catch { }
        }
        Write-Output "complete!"
    }
    catch {
        $err = $error[0]
        if ($err.Exception.Message -match "Access to the path") {
            Write-Warning "access denied to one of the objects in the $($env:TEMP) path"
        }
        else {
            Write-Error "Error: $($Error[0].Exception.Message -join ';')"
        }
    }
}

Export-ModuleMember -Function Start-TunerDiskClean 