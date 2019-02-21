function Invoke-TunerPSConfig {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param()
    Write-Verbose "making sure psgallery is a trusted repository"
    if (!(Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue)) {
        Write-Verbose "setting psgallery as trusted"
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop
    }
    else {
        Write-Verbose "psgallery is already trusted"
    }
    Write-Verbose "verifying powershellget module version"
    $psget = ((Get-Module PowershellGet).Version -join '.')
    if ([version]$psget -lt "2.0.4") {
        Write-Verbose "updating powershellGet module"
        Install-Module PowerShellGet -AllowClobber -Force
    }
    else {
        Write-Verbose "PowershellGet module is already current"
    }
}