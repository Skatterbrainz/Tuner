---
external help file: tuner-help.xml
Module Name: tuner
online version: https://chocolatey.org
schema: 2.0.0
---

# Invoke-TunerEventWatch

## SYNOPSIS
Display event log counter summary

## SYNTAX

```
Invoke-TunerEventWatch [[-LogName] <String>] [[-EventType] <String>] [[-LimitHours] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Display event log counter summary by type and time limit

## EXAMPLES

### EXAMPLE 1
```
Invoke-TunerEventWatch -LogName Application -EventType Error -LimitHours 6
```

Show count of "error" entries in the Application log within the past 6 hours

## PARAMETERS

### -LogName
Name of event log: System or Application
Default = System

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: System
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventType
Type of event entry to filter: Error, Warning, Information
Default = Error

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Error
Accept pipeline input: False
Accept wildcard characters: False
```

### -LimitHours
Time limit to filter on (hours)
Default = 24

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 24
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
