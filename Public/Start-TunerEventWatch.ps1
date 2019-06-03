function Start-TunerEventWatch {
    <#
    .SYNOPSIS
        Display event log counter summary
    .DESCRIPTION
        Display event log counter summary by type and time limit
    .PARAMETER LogName
        Name of event log: System or Application
        Default = System
    .PARAMETER EventType
        Type of event entry to filter: Error, Warning, Information
        Default = Error
    .PARAMETER LimitHours
        Time limit to filter on (hours)
        Default = 24
    .EXAMPLE
        Start-TunerEventWatch -LogName Application -EventType Error -LimitHours 6
        Show count of "error" entries in the Application log within the past 6 hours
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $False, HelpMessage = "Filter on Event Log name")]
        [ValidateSet('System', 'Application')]
        [string] $LogName = 'System',
        [parameter(Mandatory = $False, HelpMessage = "Filter on Event Type")]
        [ValidateSet('Error', 'Warning', 'Information')]
        [string] $EventType = 'Error',
        [parameter(Mandatory = $False, HelpMessage = "Limit events to past X hours")]
        [ValidateRange(1, 10000)]
        [int32] $LimitHours = 24
    )
    try {
        $rows = @(Get-WinEvent -LogName $LogName | 
            Where-Object { ((New-TimeSpan -Start $_.TimeCreated -End (Get-Date)).Hours -le $LimitHours) -and ($_.LevelDisplayName -eq "$EventType") })
        if ($rows.Count -gt 0) {
            Write-Host "$($rows.Count) $LogName $EventType entries were found in the past $LimitHours hours" -ForegroundColor Red
        }
        else {
            Write-Host "No $LogName $EventType entries were found in the past $LimitHours hours" -ForegroundColor Green
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

Export-ModuleMember -Function Start-TunerEventWatch