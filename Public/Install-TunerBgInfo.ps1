function Install-TunerBGInfo {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [parameter(Mandatory=$False)]
        [string] $ConfigFile = ""
    )
    try {
        Write-Verbose "verifying bginfo.exe is installed"
        $instfolder = Join-Path -Path $env:ProgramData -ChildPath "chocolatey\lib\sysinternals\tools"
        $instfile = Join-Path -Path $instfolder -ChildPath "bginfo.exe"
        if (!(Test-Path $ConfigFile)) {
            Write-Warning "$ConfigFile was not found!"
            break
        }
        if (Test-Path $instfile) {
            Write-Verbose "creating registry key to launch bginfo"
            New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name BgInfo -Value """$instfile"" $ConfigFile /timer:00 /accepteula /silent" -PropertyType 'String' -Force 
            & $instfile $ConfigFile /timer:00 /accepteula /silent
        }
        else {
            Set-TunerChoco
            Write-Host "installing chocolatey package: Sysinternals" -ForegroundColor Magenta
            cup sysinternals -y
            Write-Warning "sysinternals package is required before using the -SetBGInfo option"
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Install-TunerBGInfo 