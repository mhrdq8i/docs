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
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} -l {USER} "cat >> .ssh/authorized_keys"
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

## NetStat

```powershell
NETSTAT [-a] [-b] [-e] [-f] [-i] [-n] [-o] [-p proto] [-r] [-s] [-t] [-x] [-y] [interval]

  -a            Displays all connections and listening ports.
  -b            Displays the executable involved in creating each connection or
                listening port. In some cases well-known executables host
                multiple independent components, and in these cases the
                sequence of components involved in creating the connection
                or listening port is displayed. In this case the executable
                name is in [] at the bottom, on top is the component it called,
                and so forth until TCP/IP was reached. Note that this option
                can be time-consuming and will fail unless you have sufficient
                permissions.
  -e            Displays Ethernet statistics. This may be combined with the -s
                option.
  -f            Displays Fully Qualified Domain Names (FQDN) for foreign
                addresses.
  -i            Displays the time spent by a TCP connection in its current state.
  -n            Displays addresses and port numbers in numerical form.
  -o            Displays the owning process ID associated with each connection.
  -p proto      Shows connections for the protocol specified by proto; proto
                may be any of: TCP, UDP, TCPv6, or UDPv6.  If used with the -s
                option to display per-protocol statistics, proto may be any of:
                IP, IPv6, ICMP, ICMPv6, TCP, TCPv6, UDP, or UDPv6.
  -q            Displays all connections, listening ports, and bound
                nonlistening TCP ports. Bound nonlistening ports may or may not
                be associated with an active connection.
  -r            Displays the routing table.
  -s            Displays per-protocol statistics.  By default, statistics are
                shown for IP, IPv6, ICMP, ICMPv6, TCP, TCPv6, UDP, and UDPv6;
                the -p option may be used to specify a subset of the default.
  -t            Displays the current connection offload state.
  -x            Displays NetworkDirect connections, listeners, and shared
                endpoints.
  -y            Displays the TCP connection template for all connections.
                Cannot be combined with the other options.
  interval      Redisplays selected statistics, pausing interval seconds
                between each display.  Press CTRL+C to stop redisplaying
                statistics.  If omitted, netstat will print the current
                configuration information once.
```

### Watch open ports and find yours

```powershell
netstat -na | findstr "your_port"
```

### Watch open ports with process number

```powershell
netstat -nao
```

## Chocolatey

### Install Choco Package Manager (Chocolatey)

- Follow the official [link] in **individual** mode

## Battery

Check the battery health status

Run this command into the CMD

```cmd
powercfg /batteryreport
```

<!-- links -->

[link]: https://chocolatey.org/install#individual
