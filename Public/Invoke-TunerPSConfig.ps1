function Invoke-TunerPSConfig {
    <#
    .SYNOPSIS
    Configure PSGallery and PSGet defaults
    .DESCRIPTION
    Adds PSGallery as trusted repository. Insures PSGet is latest version
    .PARAMETER MinimumVersion
    Minimum allowed version of PSGet (default is '2.0.3')
    .EXAMPLE
    Invoke-TunerPSConfig
    .EXAMPLE
    Invoke-TunerPSConfig -MinimumVersion "2.0.4"
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [parameter(Mandatory=$False, HelpMessage="Minimum PSGet version")]
        [ValidateNotNullOrEmpty()]
        [string] $MinimumVersion = "2.0.3"
    )
    Write-Verbose "making sure psgallery is a trusted repository"
    if (!(Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue)) {
        Write-Verbose "setting psgallery as trusted"
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop
    }
	elseif ((Get-PSRepository -Name "PSGallery").InstallationPolicy -ne 'Trusted') {
		Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop
	}
    else {
        Write-Verbose "psgallery is already trusted"
    }
    Write-Verbose "verifying powershellget module version"
    $psget = ((Get-Module PowershellGet).Version -join '.')
    if ([version]$psget -lt [version]$MinimumVersion) {
        Write-Verbose "updating powershellGet module"
        Install-Module PowerShellGet -AllowClobber -Force
    }
    else {
        Write-Verbose "PowershellGet module is already at $MinimumVersion"
    }
}

Export-ModuleMember -Function Invoke-TunerPSConfig 