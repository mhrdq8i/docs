# WSA

## Windows Subsystem for Linux

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
