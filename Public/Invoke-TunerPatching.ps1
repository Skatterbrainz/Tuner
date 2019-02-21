function Invoke-TunerPatching {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param()
    try {
        Write-Host "installing pending updates..." -ForegroundColor Cyan
        Get-WindowsUpdate -Download -AcceptAll -Install -IgnoreReboot -Confirm:$False
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TunerPatching