#requires -RunAsAdministrator
function Invoke-TuneUp {
    [CmdletBinding()]
    <#
    .SYNOPSIS
        Re-apply Invoke-TunerQuickSetup configuration items
    .DESCRIPTION
        Performs a subset of Invoke-TunerQuickSetup: Patching, Chocolatey Packages, and 
        (optionally) PowerShell module updates, if -Full is used.
    .PARAMETER Full
        Invokes PowerShell module check-up and updates (Invoke-TunerPSModuleCheck -UpdateAll)
        If omitted, invokes Chocolatey packages (Invoke-TunerChocoPackages) and Patching (Invoke-TunerPatching)
    .EXAMPLE
        Invoke-Tuneup
    .EXAMPLE
        Invoke-Tuneup -Full
    #>
    param (
        [parameter(Mandatory=$False, HelpMessage="Run full tune-up")]
        [switch] $Full
    )
    $regpath = 'HKCU:Software\Tuner'
    try {
        Write-Verbose "reading defaults from registry"
        $key  = Get-Item -Path $regpath -ErrorAction Stop
        $config = $key.GetValue('ConfigurationName')
        Write-Debug "found!"
        if ([string]::IsNullOrEmpty($config)) {
            Write-Warning "Invoke-TunerQuickSetup needs to be executed at least once before using this function"
            break
        }
        Invoke-TunerChocoPackages -Configuration $config
        if ($Full) { 
            Invoke-TunerPSModuleCheck -UpdateAll 
        }
        Invoke-TunerPatching
        New-ItemProperty -Path $regpath -Name "LastRun" -Value (Get-Date) -Force
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Invoke-TuneUp