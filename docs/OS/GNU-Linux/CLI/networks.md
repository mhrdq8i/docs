# Network

## Tools & Commands

### 60 Linux Networking commands and scripts

[Click to visit page][60-linux-networking-commands-scripts]
[useful link][display-network-traffic]

## Top 20 tools

```bash
01. iftop
02. vnstat
03. iptraf
04. monitorix
05. bmon
06. darkstat
07. iperf
08. cbm
09. nload
10. htop
11. slurm
12. tcptrack
13. nethogs
14. speedmeter
    speedometer -l  -r wlan0 -t wlan0 -m $(( 1024  *1024*  3 / 2 ))
15. sar
    apt install sysstat
    sar -n DEV  1 --iface=eth0
16. glances
17. ifstat
18. bpytop
19. nmon
```

## Proxy

```bash
export all_proxy="socks://172.22.132.33:9090/"

install pip package via proxy:
pip3 install pysocks --proxy socks5://172.22.132.33:9090

Real Example for gitlab:
export HTTPS_PROXY=mprxy:mprxy@<remote-ip-addr>:3128
```

## vnstat

A database for show usage according to date and time (Tx/Rx/Total)

```bash
sudo vnstat --days --begin "2024-01-01 00:00" --end "2024-02-01 23:59"
```

## ssh

### ssh config

To enable a password-less connection

=== "essential"

    ```bash
    Host proxy
        HostName 172.20.238.8
        Port 22
        User mehrdad
        IdentityFile ~/.ssh/id_rsa
    ```

=== "forward proxy"

    ```bash
    Host [name]
        HostName [ip-or-hostname]
        Port [port_number]
        User [user]
        ProxyCommand ssh -W %h:%p proxy
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa
    ```

### ssh 2 ssh

```bash
ssh user#host1@host2
```

### Jump SSH

```bash
ssh user@<host-1> -J user@<host-2>
```

## scp

Copy the file "foobar.txt" from a `remote` host to the `local` host

```bash
scp username@remotehost_ip.edu:foobar.txt /some/local/directory
```

Copy the file "foobar.txt" from the `local` host to a `remote` host

```bash
scp foobar.txt username@remotehost.edu:/some/remote/directory
```

Copy the `directory` "foo" from the `local` host to a `remote` host's `directory` "bar"

```bash
scp -r foo username@remotehost.edu:/some/remote/directory/bar
```

Copy the file "foobar.txt" from `remote` host "rh1.edu" to `remote` host "rh2.edu"

```bash
scp username@rh1.edu:/some/remote/directory/foobar.txt username@rh2.edu:/some/remote/directory/
```

Copying the files "foo.txt" and "bar.txt" from the `local` host to your `home directory` on the `remote` host

```bash
scp foo.txt bar.txt username@remotehost.edu:~
```

Copy the file "foobar.txt" from the local host to a remote host using a different port number

```bash
scp -P 2264 foobar.txt username@remotehost.edu:/some/remote/directory
```

Copy `multiple files` from the `remote` host to your current directory on the `local` host

```bash
scp username@remotehost.edu:/some/remote/directory/\{a,b,c\} .
scp username@remotehost.edu:~/\{foo.txt,bar.txt\} .
```

### scp Performance

By default, SCP uses the Triple-DES cipher to encrypt the data being sent. Using the Blowfish cipher has been shown to increase speed. This can be done by using the option -c blowfish in the command line.

```bash
scp -c blowfish some_file username@remotehost.edu:~
```

It is often suggested that the -C option for compression should also be used to increase speed. The effect of compression, however, will only significantly increase speed if your connection is very slow. Otherwise, it may just be adding an extra burden to the CPU. An example of using Blowfish and compression:

```bash
scp -c blowfish -C local_file username@remotehost.edu:~
```

## rsync

```bash
Synchronize the bidirectional directory on the remote and local together
```

Access via remote shell:

```bash
Pull: rsync [OPTION...] [USER@]HOST:SRC... [DEST]
Push: rsync [OPTION...] SRC... [USER@]HOST:DEST
Pull: sync local with remote
Push: sync remote with local
```

Example:

```bash
push to remote: rsync -atvz \* root@<remote-ip-addr>:/root
pull from remote: rsync -atvz  root@<remote-ip-addr>:/root/ .
```

Set up rsync via a different port

```bash
push to remote: rsync -atvz . -e 'ssh -p 6788' mehrdad@<remote-ip-addr>:/tmp
pull from remote: rsync -atvz -e 'ssh -p 6788' mehrdad@<remote-ip-addr>:/tmp/debug.tar.gz .
```

## ip command (iproute2 pckg)

Install `ip` linux package

=== "debian base dist"

    ```bash
    sudo apt install iproute2
    ```
=== "redhat base dist"

    ```bash
    sudo dnf install iproute2
    ```

### ip addr

**Note:** You can use `a` instead of `addr`

Show IPs

```bash
ip -br -c a
```

Add a new ip address

```bash
ip addr add <ip-address/cidr> dev <interface-name>
ip addr add 172.22.170.22/24 dev enp0s3
```

### ip route

**Note:** You can use `r` instead of `route`

Show Routes

```bash
ip -br -c r
```

Add a new route

=== "via _default_ keyword"

    ```bash
    ip route add default via {GATEWAYIP} [dev {INTERFACE-NAME}]
    ip route add default via 192.168.146.2 dev ens33
    ```

=== "via _specific_ ip_address"

    ```bash
    ip route add {NETWORK/MASK} via {GATEWAYIP} [dev {INTERFACE-NAME}]
    #default route with specific address "0.0.0.0/0"
    ip route add 0.0.0.0/0 via 192.168.146.2 dev ens33
    ip route add 192.168.146.0/24 via 192.168.146.2 dev ens33
    ip route add 192.168.50.0/24 via 192.168.50.1 dev ens34
    ```

Get the Gateway address

```bash
ip r get <ip-addr>
```

### ip link

`ip link` is part of the **iproute2** toolset in Linux, and it’s used to **show and configure network interfaces** (links).

It works at **Layer 2 (Data Link Layer)** — meaning it deals with the physical or virtual network interfaces themselves, _not_ with IP addresses or routing.

Show Links

```bash
ip -br -c l
```

Show all network interfaces

```bash
ip link show
```

Bring an interface **up**

```bash
sudo ip link set ens160 up
```

Bring an interface **down**

```bash
sudo ip link set ens160 down
```

Change an interface’s **MTU**,
Reduces the maximum frame size (useful in tunnels or VPNs).

```bash
sudo ip link set ens160 mtu 1400
```

Change an interface’s **MAC address**

```bash
sudo ip link set dev ens160 address 00:11:22:33:44:55
```

Show a specific interface

```bash
ip link show dev ens160
```

Up & Down Interface

```bash
ip link set <interface-name> up
```

### ip neighbor

See which devices your system has interacted with

```bash
ip neigh
```

Delete a specific entry from the ARP cache

```bash
sudo ip neigh del 192.168.100.1 dev ens160
```

Flush the entire ARP cache

```bash
sudo ip neigh flush all
```

Add a static ARP entry manually (less common)

```bash
sudo ip neigh add 192.168.100.50 lladdr 00:11:22:33:44:55 dev ens160 nud permanent
```

**Note:** You can use `n` instead of `neigh`

## Subnet Mask

Calculate the subnet mask from the IP address

```bash
ipcalc 0.0.0.0/1
```

Range of Private Networks

```bash
Class A  10.0.0.0/8
Class B  172.16.0.0/12
Class C  192.168.0.0/16
```

## route (net-tools)

see all routes:

```bash
route -n
```

Add new route:

```bash
route add -net 172.22.132.0/24 gw 77.104.118.1 dev ens4
```

## telnet

Check the connection between two machines:

```bash
telnet  <ip> <port>
```

## nmap

Scan port on the host(s)

```bash
> nmap –p 80 192.168.0.1-100

> nmap -Pn -p 1-65535 --min-rate 1000 gitlab.com
```

See [nmap Cheat Sheet](../refs/nmap-cheat-sheet.pdf)

## fuser

close open port

kill open port directly

```bash
fuser -k -n tcp 80
fuser -k -n udp 80
```

## Kernel IP forwarding

### Temporarily Enable Forwarding

manually

```bash
echo 0 > /proc/sys/net/ipv4/ip_forward
## OR ##
echo 1 > /proc/sys/net/ipv4/ip_forward
```

via sysctl

```bash
sysctl -w net.ipv4.ip_forward=0
## OR ##
sysctl -w net.ipv4.ip_forward=1
```

### Permanently Enable Forwarding

To ensure forwarding settings persist between reboots

```bash
cat /etc/sysctl.conf | grep -i ip_forward
```

change the value and uncomment the line

## T-Shoot Tools

### 1. log file

```bash
dmesg
/var/log/syslog
/var/log/messages
```

### 2. Commands

```bash
arp -n
ping gateway
ss -l list, -m memory
netstat netstat -tulpen
traceroute google.com
mtr google.com
tcpflow -c \<port-number\>
```

### 3. Interactive trouble

```bash
nc -l 1234, nc localhost 1234
telnet host-ip host-port
```

### 4. Expert & DNS resolve Commands

```bash
nmap -v google.com, nmap 192.168.1.1/24 80
host google.com
nslookup google.com
dig google.com
lsof -i
```

### 5. tcpdump

```bash
-i any every port
-p 1234 port 1234
-D all available interfaces
-w file.pcap write to file
-r file.pcap read from file
-c count of captured package
dst ip packet route TO address
src ip packet route FROM address
-A read packet data

ngrep -t -W byline port 8088 -d any
tcpdump -i any -nn -s 0 -w k8s_port_6443.pcap port 6443 and host 172.16.2.10
```

<!-- external links -->

[60-linux-networking-commands-scripts]: https://haydenjames.io/linux-networking-commands-scripts
[display-network-traffic]: https://askubuntu.com/questions/257263/how-to-display-network-traffic-in-the-terminal
