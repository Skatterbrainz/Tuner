---
external help file: tuner-help.xml
Module Name: tuner
online version: https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org
schema: 2.0.0
---

# Invoke-TunerQuickSetup

## SYNOPSIS
Quick configuration with default parameters

## SYNTAX

```
Invoke-TunerQuickSetup [[-Configuration] <String>] [[-ConfigurationsPath] <String>] [[-NewName] <String>]
 [[-TimeZone] <String>] [-BGInfo] [-SkipCleanup] [-SkipModules] [-SkipUpdates] [-SkipChoco] [-SkipTimeZone]
 [-ForceRestart] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Quick configuration of Windows machine based on user roles like 
Basic, AppDev, AppDevPro, SysAdmin, and Consultant. 
Invokes the other
functions to cleanup, configure and so forth.

## EXAMPLES

### EXAMPLE 1
```
Invoke-TunerQuickSetup
```

Installs and configures all defaults without renaming computer or installing BGinfo mod

### EXAMPLE 2
```
Invoke-TunerQuickSetup -Configuration AppDev -NewName "Client3"
```

Installs chocolatey packages for 'appdev' user and renames computer to Client3

### EXAMPLE 3
```
Invoke-TunerQuickSetup -Configuration SysAdmin -BGInfo
```

Installs default chocolatey packages and Sysinternals BGinfo with default options

### EXAMPLE 4
```
Invoke-TunerQuickSetup -Configuration SysAdmin -NewName "Client3" -BGInfo
```

Installs chocolatey packages for 'sysadmin' user, renames computer to Client3 and installs Sysinternals BGInfo

### EXAMPLE 5
```
Invoke-TunerQuickSetup -Configuration Consultant -SkipCleanup -SkipModules -SkipUpdates
```

Installs default chocolatey packages for 'consultant' user, skips Appx cleanup, PS modules and patching

### EXAMPLE 6
```
Invoke-TunerQuickSetup -Configuration AppDevPro -BGInfo
```

### EXAMPLE 7
```
Invoke-TunerQuickSetup -NewName "Client3" -BGInfo -SkipCleanup -SkipModules -SkipUpdates
```

Installs default default chocolatey packages, renames computer to Client3, installs BGInfo, 
skips Appx cleanup, PS modules and patching

### EXAMPLE 8
```
Invoke-TunerQuickSetup -Configuration Basic -BGInfo -TimeZone 'Central Standard Time'
```

### EXAMPLE 9
```
Invoke-TunerQuickSetup -Configuration SysAdmin -ConfigurationsPath "x:\configfiles" -BGInfo -NewName "W10-TEST" -ForceRestart
```

Installs default chocolatey packages for 'sysadmin' user from custom location x:\configfiles, installs BGInfo, 
renames computer to W10-TEST and forces a restart at the end

## PARAMETERS

### -Configuration
User role-based configuration template: Basic (default), AppDev, AppDevPro,
SysAdmin and Consultant. 
Controls the chocolatey packages that get installed
and additional PowerShell modules that will be installed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Basic
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigurationsPath
Custom path to configuration .txt files (basic.txt, appdev.txt, etc.)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
New computer name to apply (forces restart at the end)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZone
Set timezone (default: Eastern Standard Time)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Eastern Standard Time
Accept pipeline input: False
Accept wildcard characters: False
```

### -BGInfo
Install and enable sysinternals bginfo desktop mod

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCleanup
Skip Appx cleanup

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipModules
Skip installing or updating powershell modules list

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipUpdates
Skip installing windows updates

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipChoco
Skip installing or updating chocolatey packages

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipTimeZone
Skip setting the active time zone (otherwise -TimeZone is applied)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceRestart
Forces the computer to restart at the very end of processing

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org](https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org)

