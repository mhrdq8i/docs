# Commands and tips

## Squid Server

A minimal set of instructions to work with squid proxy

### config 

push the below config to this path `/etc/squid/squid.conf`
```config
acl local src 127.0.0.1

### if you want to set authentication
## auth_param basic program /etc/squid/htpasswd
## auth_param basic children 5
## auth_param basic realm Enter proxy password

# acl KnownUsers proxy_auth REQUIRED

# http_access allow KnownUsers
# http_access deny all

### if you want to pass without authentication
http_access allow all

request_header_access Allow allow all
```

**Note:** Use authorized users only

### Check the config file

```bash
squid -k parse
```
## OS tasks

### Enable ip-v4-forwarding

use [this link][ip_v4_forwarding] and follow instructions

### Accept iptables traffic

```bash
iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
iptables -I OUTPUT -p tcp --dport 3128 -j ACCEPT
```

## Client Proxy

### export proxy variables in to the _~/.bashrc_ for Bash, _~/.zshrc_ for Zsh file

```bash
# Set proxy environment variables
export http_proxy="http://IP_OF_YOUR_SQUID_SERVER:3128"
export https_proxy="http://IP_OF_YOUR_SQUID_SERVER:3128"
export ftp_proxy="http://IP_OF_YOUR_SQUID_SERVER:3128"
export no_proxy="localhost,127.0.0.1,::1"
```
Apply the Changes

```bash
source ~/.bashrc
# or
source ~/.zshrc
```

Verify the set varialbes

```bash
echo $http_proxy
echo $https_proxy
echo ftp_proxy
echo no_proxy
```

**Note:** If you want to set squid proxy to your APT packages repository, see [this link][apt_proxy]

<!-- links -->
[ip_v4_forwarding]: ../../../OS/gnu_linux/CLI/networks.md#kernel-ip-forwarding
[apt_proxy]: ../../../OS/gnu_linux/dist/ubuntu.md#set-apt-proxy
