---
external help file: tuner-help.xml
Module Name: tuner
online version:
schema: 2.0.0
---

# Invoke-TunerChocoPackages

## SYNOPSIS
Installs list of Chocolatey packages

## SYNTAX

```
Invoke-TunerChocoPackages [-PackageName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Installs list of Chocolatey packages

## EXAMPLES

### EXAMPLE 1
```
Invoke-TunerChocoPackages -PackageName ('7zip','vlc','notepadplusplus')
```

## PARAMETERS

### -PackageName
Name of one or more Chocolatey packages to upgrade or install.
Note that if a given package is not installed, it will be installed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
