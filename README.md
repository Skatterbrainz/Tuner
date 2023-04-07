# Tuner
Windows client tuning and configuration tools

## Information

### License
https://github.com/Skatterbrainz/Tuner/blob/master/LICENSE

### Help
https://github.com/Skatterbrainz/Tuner/tree/master/Docs

## Installation

```powershell
Install-Module Tuner
```

## Functions

* [Install-TunerBGInfo](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Install-TunerBGInfo.md)
* [Start-TunerChocoPackages](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerChocoPackages.md)
* [Start-TunerCleanup](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerCleanup.md)
* [Start-TunerDiskClean](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerDiskClean.md)
* [Start-TunerEventWatch](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerEventWatch.md)
* [Start-TunerPatching](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPatching.md)
* [Start-TunerPSConfig](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSConfig.md)
* [Start-TunerPSModuleCheck](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModuleCheck.md)
* [Start-TunerPSModules](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerPSModules.md)
* [Start-TunerQuickSetup](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-TunerQuickSetup.md)
* [Start-Tuneup](https://github.com/Skatterbrainz/Tuner/blob/master/Docs/Start-Tuneup.md)

## Examples

```powershell
Invoke-TunerQuickSetup -Configuration AppDev -NewName "Client3" -BGInfo

Invoke-TunerCleanup

Invoke-TunerPatching
```

## Help and Lab Demos

https://github.com/Skatterbrainz/Tuner/wiki
