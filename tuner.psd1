# Module manifest for module 'tuner'
# Generated by: David M.Stein
# Generated on: 2/21/2019

@{
    RootModule = '.\tuner.psm1'
    ModuleVersion = '1.0.9'
    CompatiblePSEditions = @('Desktop')
    GUID        = '3f770582-2ce0-412a-a9e8-fb65853f0540'
    Author      = 'David M.Stein'
    CompanyName = 'skatterbrainz'
    Copyright   = 'David M. Stein'
    Description = 'Windows computer tuning and configuration tools'
    PowerShellVersion = '5.1'
    # PowerShellHostName = ''
    PowerShellHostVersion = '5.1'
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    RequiredModules     = @('pswindowsupdate')
    # RequiredAssemblies = @()
    # ScriptsToProcess   = @()
    # TypesToProcess     = @()
    # FormatsToProcess   = @()
    # NestedModules      = @()
    FunctionsToExport = @(
        'Install-TunerBGInfo',
        'Invoke-TunerQuickSetup',
        'Invoke-TunerPSModules',
        'Invoke-TunerPatching',
        'Invoke-TunerChocoPackages',
        'Invoke-TunerCleanup',
        'Invoke-TunerPSConfig',
        'Invoke-TunerPSModuleCheck',
        'Invoke-TunerEventWatch'
    )
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    # DscResourcesToExport = @()
    # ModuleList = @()
    FileList = @(
        '.\assets\basic.txt',
        '.\assets\appdev.txt',
        '.\assets\appdevpro.txt',
        '.\assets\sysadmin.txt',
        '.\assets\consultant.txt',
        '.\docs\Install-TunerBGInfo.md',
        '.\docs\Invoke-TunerChocoPackages.md',
        '.\docs\Invoke-TunerCleanup.md',
        '.\docs\Invoke-TunerPatching.md',
        '.\docs\Invoke-TunerPSConfig.md',
        '.\docs\Invoke-TunerPSModules.md',
        '.\docs\Invoke-TunerPSModuleCheck.md',
        '.\docs\Invoke-TunerQuickSetup.md'
    )
    PrivateData = @{
        PSData = @{
            Tags         = @('tuner','cleanup','patching','install','deploy','choco')
            LicenseUri   = 'https://github.com/Skatterbrainz/Tuner/blob/master/LICENSE'
            ProjectUri   = 'https://github.com/skatterbrainz/tuner'
            IconUri      = 'https://user-images.githubusercontent.com/11505001/53195244-46039900-35e3-11e9-98cc-1214eeecaa8e.png'
            ReleaseNotes = @'
1.0.0 - DS - first release
1.0.1 - DS - updates for documentation, error handling, cleanup functions
1.0.2 - DS - added user-appx cleanup handling
1.0.3 - DS - bug fixes to bginfo setup, added timezone setup
1.0.4 - DS - crap / do not use
1.0.5 - DS - had some coffee, rewrote Invoke-TunerCleanup to use auto-kill lists
1.0.6 - DS - fixed configuration list files to include correct choco packages
1.0.7 - DS - added -RecurseCycle 3 to Invoke-TunerPatching operation (repeat scan/install process)
1.0.8 - DS - fixed missing parameter -UpdateAll for Invoke-TunerPSModuleCheck
1.0.9 - DS - minor bug fixes
'@
        }
    }
    HelpInfoURI = 'https://github.com/Skatterbrainz/Tuner/wiki'
    # DefaultCommandPrefix = ''
}
