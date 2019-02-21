function Invoke-TunerPatching {
    <#
    .SYNOPSIS
    Installs pending updates for Windows computer
    .DESCRIPTION
    Installs pending updates for Windows computer
    .EXAMPLE
    Invoke-TunerPatching
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param()
    try {
        Write-Host "installing pending updates..." -ForegroundColor Cyan
		$ulist = Get-WindowsUpdate
		if ($ulist.Count -gt 0) {
			Get-WindowsUpdate -Download -AcceptAll -Install -IgnoreReboot -Confirm:$False -ErrorAction Stop
		}
		else {
			Write-Host "no pending updates were found" -ForegroundColor Green
		}
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerPatching