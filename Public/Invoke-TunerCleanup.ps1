function Invoke-TunerCleanup {
    <#
    .SYNOPSIS
    Remove selected Windows 10 appx packages
    .DESCRIPTION
    Remove selected Windows 10 appx packages
    .EXAMPLE
    Invoke-TunerCleanup
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param()
    try {
        Write-Host "getting provisioned applications..." -ForegroundColor Cyan
        $apps = @(Get-AppxProvisionedPackage -Online | 
            Select-Object DisplayName,PackageName | 
                Sort-Object DisplayName | 
                    Out-GridView -Title "Select Provisioned Apps to Remove - or click Cancel to skip" -OutputMode Multiple)
        if ($apps.Count -gt 0) {
            $apps | Foreach-Object { 
                Remove-AppxProvisionedPackage -PackageName $_.PackageName -AllUsers -Online -ErrorAction SilentlyContinue | Out-Null
                Write-Host "removed: $($_.DisplayName)" -ForegroundColor Cyan
            }
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
    <#
    Write-Host "getting user applications..." -ForegroundColor Cyan
    try {
        $apps = @(Get-AppxPackage | 
            Select-Object Name,PackageFullName,Status | 
                Sort-Object Name | 
                    Out-GridView -Title "Select User Apps to Remove - or click Cancel to skip" -OutputMode Multiple)
        if ($apps.Count -gt 0) {
            $apps | Select-Object -ExpandProperty PackageFullName | ForEach-Object {
                Write-Verbose "removing: $_"
                Remove-AppxPackage -Package $_ -AllUsers -Confirm:$False -ErrorAction SilentlyContinue
                Write-Host "removed: $_" -ForegroundColor Cyan 
            }
        }
    }
    catch {
        $errmsg = $Error[0].Exception.Message
        if ($errmsg -match '0x80070032') {
            Write-Warning "This App cannot be undouched because it is locked by Microsoft"
        }
        else {
            Write-Error $errmsg
        }
    }
    #>
}

Export-ModuleMember -Function Invoke-TunerCleanup 