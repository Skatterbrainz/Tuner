function Invoke-TunerCleanup {
    <#
    .SYNOPSIS
        Remove selected Windows 10 appx packages
    .DESCRIPTION
        Remove selected Windows 10 appx packages
    .PARAMETER GridSelect
        Display Appx provisioned and user packages to select for removal
    .EXAMPLE
        Invoke-TunerCleanup
        Processes an automatic kill list to vaporize stupidware
    .EXAMPLE
        Invoke-TunerCleanup -GridSelect
        Displays a gridview menu to select Appx and AppxProvisioned packages to remove
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [parameter(Mandatory=$False, HelpMessage="Select packages to remove using GridView display")]
        [switch] $GridSelect
    )
    if ($GridSelect) {
        Write-Verbose "getting appx and appxProvisioned packages"
        $applist1 = Get-AppxProvisionedPackage -Online | Select DisplayName,PackageName | Sort-Object DisplayName
        $applist2 = Get-AppxPackage | Where-Object {$_.NonRemovable -eq $False} | Select Name,PackageFullName | Sort-Object Name
        $apps1 = @($applist1 | Out-GridView -Title "Select Machine packages to remove - or click Cancel to skip" -OutputMode Multiple)
        $apps2 = @($applist2 | Out-GridView -Title "Select User packages to remove - or click Cancel to skip" -OutputMode Multiple)
        if ($apps1.Count -gt 0) {
            Write-Verbose "processing appx provisioned package selections"
            $apps1 | ForEach-Object {
                try {
                    Remove-AppxProvisionedPackage -PackageName $_.PackageName -AllUsers -Online -ErrorAction SilentlyContinue | Out-Null
                    Write-Host "removed: $($_.DisplayName)" -ForegroundColor Magenta
                }
                catch {
                    Write-Warning "Failed to remove: $($_.DisplayName) - $($Error[0].Exception.Message)"
                }
            }
        }
        if ($apps2.Count -gt 0) {
            Write-Verbose "processing appx user package selections"
            $apps2 | Foreach-Object {
                try {  
                    Remove-AppxPackage -Package $_.PackageFullName -Confirm:$False -ErrorAction SilentlyContinue
                    Write-Host "removed: $($_.Name)" -ForegroundColor Magenta
                }
                catch {
                    Write-Warning "Failed to remove: $($_.Name) - $($Error[0].Exception.Message)"
                }
            }
            Write-Host "$($apps2.Count) packages removed" -ForegroundColor Cyan
        }
    }
    else {
        Write-Verbose "running in fast-mode (preselected packages)"
        Remove-AppxMachineApps
        Remove-AppxUserApps
    }
}

Export-ModuleMember -Function Invoke-TunerCleanup 