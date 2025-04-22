# WSL

Windows-Subsystem-Linux

## Active Requirement Services

### UI mode

- win + r
- optionalfeatures
- check Windows Subsystem for Linux
- check Virtual Machine Platform

### CLI mode

Check the requirement service first

```powershell
"Microsoft-Windows-Subsystem-Linux", "VirtualMachinePlatform" | ForEach-Object { Get-WindowsOptionalFeature -Online -FeatureName $_ | Select-Object FeatureName, State }
```

Enable them

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName @("Microsoft-Windows-Subsystem-Linux", "VirtualMachinePlatform") -All -NoRestart
```

### Pre-Configuration (if need)

Windows Hyper-V must be enabled except this one

```pwsh
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor
```

**off** hypervisiorlaunchtype

```pwsh
bcdedit /set hypervisorlaunchtype off
```

### Download

- Open the "[Microsoft Store Ubuntu]" page and get the Ubuntu _product ID_
- Open the https://store.rg-adguard.net and follow [this instructions]
- You also use another dist like [Alpine], [Arch], [Fedora] and ...

### Install Manually

Here's how to manually install the Ubuntu WSL distribution you've downloaded:

1. **Unblock the File** (if downloaded from web):

    ```powershell
    Unblock-File -Path .\Ubuntu_2404.xx.x.appx
    ```

2. **Install via PowerShell**:

    ```powershell
    Add-AppxPackage .\Ubuntu_2404.xx.x.appx
    ```

3. **Launch Ubuntu**:

    - From Start Menu: Search for "Ubuntu 24.04"
    - Or via PowerShell:

        ```powershell
        ubuntu2404.exe
        ```

### Post-Installation Setup

1. **Initialize User Account**:

    ```powershell
    ubuntu2404.exe config --default-user yourusername
    ```

2. **Switch to WSL2** (if needed):

    ```powershell
    wsl --set-version Ubuntu-24.04 2
    ```

3. **Update Packages**:

    ```bash
    sudo apt update && sudo apt full-upgrade -y
    ```

### Recommended Folder Structure

```powershell
C:\Users\YourName\
├── WSL/
│   ├── Ubuntu-24.04/  ← WSL virtual disk here
│   └── Downloads/     ← Store .appx/.tar.gz files here
```

### Install and Update from CLI

Get the list of available linux distributions

```powershell
wsl --list --online
```

Install your favorite distro

```powershell
wsl --install --distribution <name-of-dist>
```

Update new version of WSL

```powershell
wsl --update
```

### Delete the Installed Dist

```powershell
wsl --unregister <dist-name>
```

### Set Default Distro

```powershell
wsl --set-default <dist-name>
```

### Restart Network

```pwsh
net stop wslservice
net start wslservice
```

### Important Note

Unfortunately when you set your region to `Iran` WSL can't to connect to microsoft store server and download the distro that you selected, as well as it doesn't give you an appropriate error message.

<!-- links -->

[Microsoft Store Ubuntu]: https://apps.microsoft.com/detail/9pdxgncfsczv?rtc=1&hl=en-us&gl=US
[this instructions]: https://allthings.how/how-to-download-windows-subsystem-for-android-without-microsoft-store-msixbundle/
[WSL Studio]: https://apps.microsoft.com/detail/9plsjr4tg2gq?hl=en-us&gl=US
[Alpine]: https://apps.microsoft.com/detail/9p804crf0395?hl=en-us&gl=US
[Arch]: https://apps.microsoft.com/detail/9mznmnksm73x?hl=en-us&gl=US
[Fedora]: https://apps.microsoft.com/detail/9npcp8drchsn?hl=en-us&gl=US
