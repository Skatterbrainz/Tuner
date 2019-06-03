---
external help file: tuner-help.xml
Module Name: tuner
online version: https://chocolatey.org
schema: 2.0.0
---

# Start-TunerChocoPackages

## SYNOPSIS
Installs list of Chocolatey packages

## SYNTAX

```
Start-TunerChocoPackages [[-PackageName] <String[]>] [[-Configuration] <String>]
 [[-ConfigurationsPath] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Installs list of Chocolatey packages

## EXAMPLES

### EXAMPLE 1
```
Start-TunerChocoPackages
```

Installs list from "Basic" profile configuration (see /assets/basic.txt for list of packages)

### EXAMPLE 2
```
Start-TunerChocoPackages 'vlc'
```

Installs VLC player package only

### EXAMPLE 3
```
Start-TunerChocoPackages -PackageName ('7zip','vlc','notepadplusplus')
```

Installs packages named in array

### EXAMPLE 4
```
Start-TunerChocoPackages -Configuration Consultant -ConfigurationPath "\\server3\docs\configs\"
```

Install list from "Consultant" profile configuration found in custom path "\\\\server3\docs\configs\"

## PARAMETERS

### -PackageName
Name of one or more Chocolatey packages to upgrade or install.
Note that if a given package is not installed, it will be installed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
Position: 2
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
Position: 3
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
If -PackageName is not empty/null, it overrides the -Configuration parameter (one or the other only)

## RELATED LINKS

[https://chocolatey.org](https://chocolatey.org)

