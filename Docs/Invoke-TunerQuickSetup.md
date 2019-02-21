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
Invoke-TunerQuickSetup [[-Configuration] <String>] [[-NewName] <String>] [-BGInfo] [-SkipCleanup]
 [-SkipModules] [-SkipUpdates] [-SkipChoco] [-ForceRestart] [-WhatIf] [-Confirm] [<CommonParameters>]
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

### EXAMPLE 3
```
Invoke-TunerQuickSetup -Configuration SysAdmin -BGInfo
```

### EXAMPLE 4
```
Invoke-TunerQuickSetup -Configuration SysAdmin -NewName "Client3" -BGInfo
```

### EXAMPLE 5
```
Invoke-TunerQuickSetup -Configuration UberNerd -SkipCleanup -SkipModules -SkipUpdates
```

### EXAMPLE 6
```
Invoke-TunerQuickSetup -Configuration AppDev -BGInfo -SkipCleanup -SkipModules -SkipUpdates
```

### EXAMPLE 7
```
Invoke-TunerQuickSetup -NewName "Client3" -BGInfo -SkipCleanup -SkipModules -SkipUpdates -SkipChoco
```

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

### -NewName
New computer name to apply (forces restart at the end)

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
version 1.0.0 - DS - https://github.com/skatterbrainz/tuner

## RELATED LINKS

[https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org](https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org)

