# Windows

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
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"
```

## Generalize Windows Server

Open Run Menu:

```powershell
sysprep
generalized
shutdown
```

## Find open ports and filter over them

```powershell
netstat -ano | findstr "desire-port-number"
```

## Restart `net` service to solve `nekoray` problem

```powershell
net stop hns
net start hns
```

## watch open ports and find yours

```powershell
netstat -na | findstr "your_port"
```
