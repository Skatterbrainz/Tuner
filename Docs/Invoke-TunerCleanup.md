---
external help file: tuner-help.xml
Module Name: tuner
online version: https://chocolatey.org
schema: 2.0.0
---

# Invoke-TunerCleanup

## SYNOPSIS
Remove selected Windows 10 appx packages

## SYNTAX

```
Invoke-TunerCleanup [-GridSelect] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove selected Windows 10 appx packages

## EXAMPLES

### EXAMPLE 1
```
Invoke-TunerCleanup
```

Processes an automatic kill list to vaporize stupidware

### EXAMPLE 2
```
Invoke-TunerCleanup -GridSelect
```

Displays a gridview menu to select Appx and AppxProvisioned packages to remove

## PARAMETERS

### -GridSelect
Display Appx provisioned and user packages to select for removal

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
