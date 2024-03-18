# [Windows doc](#windows-doc)

## [Enable/Disable HyperV](#enabledisable-hyperv)

> enable:

```powershell
bcdedit /set hypervisorlaunchtype auto
```

> disable:

```powershell
bcdedit /set hypervisorlaunchtype off
```

## SSH on windows

> copy public key from windows machine

```powershell
scp ~/.ssh/id_rsa.pub [linux_user]@[linux_IP/linux_hostname]:~/.ssh/authorized_keys
```

## Generalize Windows Server

> Open Run Menu:

```powershell
sysprep
generalized
shutdown
```

## Find open ports and filter over them

```powershell
netstat -ano | findstr "desire-port-number"
```

### Restart `net` service to solve `nekoray` problem

```powershell
net stop hns
net start hns
```
