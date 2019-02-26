---
external help file: tuner-help.xml
Module Name: tuner
online version: https://www.powershellgallery.com/packages/PSWindowsUpdate
https://chocolatey.org
schema: 2.0.0
---

# Invoke-TunerPSModuleCheck

## SYNOPSIS
Check PowerShell module installed versions

## SYNTAX

```
Invoke-TunerPSModuleCheck [-UpdateAll] [<CommonParameters>]
```

## DESCRIPTION
Check each installed PowerShell module against the latest available version

## EXAMPLES

### EXAMPLE 1
```
Invoke-TunerPSModuleCheck
```

### EXAMPLE 2
```
Invoke-TunerPSModuleCheck -UpdateAll
```

## PARAMETERS

### -UpdateAll
If version is older than on remote repository, install latest version

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
