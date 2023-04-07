---
external help file: tuner-help.xml
Module Name: tuner
online version: https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSConfig.md
schema: 2.0.0
---

# Start-TunerPSConfig

## SYNOPSIS
Configure PSGallery and PSGet defaults

## SYNTAX

```
Start-TunerPSConfig [[-MinimumVersion] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds PSGallery as trusted repository.
Insures PSGet is latest version

## EXAMPLES

### EXAMPLE 1
```
Start-TunerPSConfig
```

### EXAMPLE 2
```
Start-TunerPSConfig -MinimumVersion "2.0.4"
```

## PARAMETERS

### -MinimumVersion
Minimum allowed version of PSGet (default is '2.0.3')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 2.0.3
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

[https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSConfig.md](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSConfig.md)

