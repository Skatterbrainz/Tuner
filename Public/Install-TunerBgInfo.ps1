#requires -RunAsAdministrator
function Install-TunerBGInfo {
    <#
    .SYNOPSIS
        Install and enable Sysinternals BGINFO
    .DESCRIPTION
        Install and enable Sysinternals BGINFO
    .PARAMETER ConfigFile
        Custom configuration file (.bgi extension) to apply
    .EXAMPLE
        Install-TunerBGInfo
    .EXAMPLE
        Install-TunerBGInfo -ConfigFile "c:\windows\system32\contoso_servers.bgi"
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [parameter(Mandatory=$False)]
        [string] $ConfigFile = ""
    )
    try {
        Write-Verbose "verifying bginfo.exe is installed"
        $instfolder = Join-Path -Path $env:ProgramData -ChildPath "chocolatey\lib\bginfo\tools"
        $instfile = Join-Path -Path $instfolder -ChildPath "bginfo.exe"
        if (($ConfigFile -ne "") -and (!(Test-Path $ConfigFile))) {
            Write-Warning "$ConfigFile was not found. Using default configuration."
            $ConfigFile = ""
        }
        if (!(Test-Path $instfile)) {
            Set-TunerChoco
            Write-Host "installing chocolatey package: bginfo" -ForegroundColor Magenta
            cup bginfo -y
        }
        if (Test-Path $instfile) {
            Write-Verbose "creating registry key to launch bginfo"
            New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name BgInfo -Value """$instfile"" $ConfigFile /timer:00 /accepteula /silent" -PropertyType 'String' -Force 
            & $instfile $ConfigFile /timer:00 /accepteula /silent
        }
    }
    catch {
        Write-Error "$($Error[0].Exception.Message)"
    }
}

Export-ModuleMember -Function Install-TunerBGInfo 