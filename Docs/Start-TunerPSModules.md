---
external help file: tuner-help.xml
Module Name: tuner
online version: https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModules.md
schema: 2.0.0
---

# Start-TunerPSModules

## SYNOPSIS
Installs or Updates one or more PowerShell modules

## SYNTAX

```
Start-TunerPSModules [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Installs or Updates one or more PowerShell modules

## EXAMPLES

### EXAMPLE 1
```
Start-TunerPSModules -Name @('dbatools','carbon')
```

## PARAMETERS

### -Name
Name of one or more PowerShell modules to install or update

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModules.md](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModules.md)

