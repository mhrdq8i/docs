# WSL

## Windows Subsystem for Linux

### Activa WSL services

- win + r
- optionalfeatures
- check Windows Subsystem for Linux

### Download

  - Open the "[Microsoft Store Ubuntu]" page and get the Ubuntu *product ID*
  - Open the https://store.rg-adguard.net and follow [this instructions]
  - You also use another dist like [Alpine], [Arch], [Fedora] and ... 

### Pre-Configuration Steps

Windows Hyper-V must be enabled except this one

```pwsh
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor
```

**off** hypervisiorlaunchtype

```pwsh
bcdedit /set hypervisorlaunchtype off
```

### Restart Network

```pwsh
net stop wslservice
net start wslservice
```

### WSL Commands

- **wsl --update**: update new version of WSL
- **wsl --list --online**: list of linux distributions


[Microsoft Store Ubuntu]: https://apps.microsoft.com/detail/9pdxgncfsczv?rtc=1&hl=en-us&gl=US
[this instructions]: https://allthings.how/how-to-download-windows-subsystem-for-android-without-microsoft-store-msixbundle/
[WSL Studio]: https://apps.microsoft.com/detail/9plsjr4tg2gq?hl=en-us&gl=US
[Alpine]: https://apps.microsoft.com/detail/9p804crf0395?hl=en-us&gl=US
[Arch]: https://apps.microsoft.com/detail/9mznmnksm73x?hl=en-us&gl=US
[Fedora]: https://apps.microsoft.com/detail/9npcp8drchsn?hl=en-us&gl=US
