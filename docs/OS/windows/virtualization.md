# Virtualization

## Enable/Disable HyperV

### Enable

```powershell
bcdedit /set hypervisorlaunchtype auto
```

This command sets the hypervisor launch type to "auto", which ensures the hypervisor starts automatically on boot.

### Disable

```powershell
bcdedit /set hypervisorlaunchtype off
```

## SSH on windows

Copy public key from windows machine

```powershell
scp ~/.ssh/id_rsa.pub [linux_user]@[linux_IP/linux_hostname]:~/.ssh/authorized_keys
```

or

```pwsh
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} -l {USER} "cat >> .ssh/authorized_keys"
```

## Generalize Windows Server

Open Run Menu:

```pwsh
sysprep
generalized
shutdown
```

## Chocolatey

### Install Choco Package Manager (Chocolatey)

-   Follow the official [link] in **individual** mode

## Battery

Check the battery health status

Run this command into the CMD

```cmd
powercfg /batteryreport
```

<!-- links -->

[link]: https://chocolatey.org/install#individual
