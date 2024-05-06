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

### ssh config to passwordless connection

```bash
Host [name]
    HostName [ip-or-hostname]
    Port [port_number]
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa.hub
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

Copy the file "foobar.txt" from the local host to a remote host using different port number

```bash
scp -P 2264 foobar.txt username@remotehost.edu:/some/remote/directory
```

Copy `multiple files` from the `remote` host to your current directory on the `local` host

```bash
scp username@remotehost.edu:/some/remote/directory/\{a,b,c\} .
scp username@remotehost.edu:~/\{foo.txt,bar.txt\} .
```

### scp Performance

By default, SCP uses the Triple-DES cipher to encrypt the data being sent. Using the Blowfish cipher has been shown to increase speed. This can be done by using option -c blowfish in the command line.

```bash
scp -c blowfish some_file username@remotehost.edu:~
```

It is often suggested that the -C option for compression should also be used to increase speed. The effect of compression, however, will only significantly increase speed if your connection is very slow. Otherwise, it may just be adding an extra burden to the CPU. An example of using blowfish and compression:

```bash
scp -c blowfish -C local_file username@remotehost.edu:~
```

## rsync

```bash
Synchronize bidirectional directory on remote and local together
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

Setup rsync via different port

```bash
push to remote: rsync -atvz . -e 'ssh -p 6788' mehrdad@<remote-ip-addr>:/tmp
pull from remote: rsync -atvz -e 'ssh -p 6788' mehrdad@<remote-ip-addr>:/tmp/debug.tar.gz .
```

## ip command

Add new ip address:

```bash
ip addr add <ip-address/cidr> dev <interface-name>
ip addr add 172.22.170.22/24 dev enp0s3
```

**Note:** You can use `a` instead of `addr`

Add new route:

```bash
ip route add default {NETWORK/MASK} via {GATEWAYIP}
ip route add default {NETWORK/MASK} via {GATEWAYIP} dev {INTERFACE-NAME}
ip route add 172.16.5.0/24 via 10.0.0.101 dev eth0
ip route add default 172.16.5.0/24 via 10.0.0.101 dev eth0
```

**Note:** You can use `r` instead of `route`

**Note:** You can use `0.0.0.0/0` instead of `default`

Up & Down Interface

```bash
ip link set <interface-name> up
```

## route

see all route:

```bash
route -n
```

Add new route:

```bash
route add -net 172.22.132.0/24 gw 77.104.118.1 dev ens4
```

## telnet

check connection between two machines:

```bash
telnet  <ip> <port>
```

## nc (netcat)

check port connection

```bash
nc -z -v -u -l <remote-ip-addr> <remote-port-number>
```

we cant also check our connection between two machines via `nc`:

```bash
nc  <ip> <port>
```

## nmap

Scan port on the host(s)

```bash
nmap –p 80 192.168.0.1-100
```

See [nmap Cheat Sheet](../refs/nmap-cheat-sheet.pdf)

## fuser

close open port

```bash
fuser -k -n tcp 80
fuser -k -n udp 80
```

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
```

<!-- external links -->
[60-linux-networking-commands-scripts]: https://haydenjames.io/linux-networking-commands-scripts

[display-network-traffic]: https://askubuntu.com/questions/257263/how-to-display-network-traffic-in-the-terminal
