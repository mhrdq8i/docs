# Squid

A minimal set of instructions to work with squid proxy

## configuration

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

### Check the config file

```bash
squid -k parse
```

**Note:** Use authorized users only

### Set authorized users

Install apache2-utils

```bash
sudo apt update
sudo apt install apache2-utils
```

Create the Password File

```bash
sudo htpasswd -c /etc/squid/passwd <user-1>
```

Add more users later without recreating the file

```bash
sudo htpasswd /etc/squid/passwd <user-2>
```

Secure the Password File

```bash
sudo chmod 600 /etc/squid/passwd
sudo chown proxy:proxy /etc/squid/passwd
```

Configure ACLs and Authentication

```bash
# Squid normally listens to port 3128
http_port 3128

# Define an ACL to restrict access to authorized users
acl authorized_users proxy_auth REQUIRED
acl localnet src 192.168.1.0/24  # Adjust this to your network

# Deny access to everyone except authorized users and your local network
http_access allow localnet
http_access allow authorized_users
http_access deny all
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

### Export proxy variables

for bash use _~/.bashrc_ file and for zsh use _~/.zshrc_ for file

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
[ip_v4_forwarding]: ../../OS/gnu_linux/CLI/networks.md#kernel-ip-forwarding
[apt_proxy]: ../../OS/gnu_linux/dist/ubuntu.md#set-apt-proxy
