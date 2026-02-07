# Debian

## Configure Debian Network

### Set Static IP address, Gateway and DNS

```bash
sudo cat >> /etc/network/interfaces << EOF
auto ens33
iface ens33 inet static
   address  172.22.132.xxx
   netmask  255.255.255.0
   gateway  172.22.132.1
   dns      1.1.1.1
   hostname debian-host
EOF
```

**Note:** The `auto` keyword ensures the interface is brought up on boot time.

Apply your changes

```bash
/sbin/ifup <interface-name>
systemctl  restart networking
```

Alternative way to set DND

```bash
cat >> /etc/resolve.conf << EOF
domain drpc.ir
search localdomain
nameserver 10.0.5.94
nameserver 10.0.5.55
EOF
```

## Debian sources.list

### Debian 11

```bash
deb http://deb.debian.org/debian bullseye main
deb-src http://deb.debian.org/debian bullseye main

deb http://deb.debian.org/debian bullseye-updates main
deb-src http://deb.debian.org/debian bullseye-updates main

deb http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
```

### Debian 12

```bash
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main
```

Set http_proxy and https_proxy for apt

=== "without-Auth"

   ```bash
   Acquire::http::Proxy "http://proxy.company.com:8080";
   Acquire::https::Proxy "http://proxy.company.com:8080";
   ```

=== "with-Auth"

   ```bash
   Acquire::http::Proxy "http://username:password@proxy.company.com:8080";
   Acquire::https::Proxy "http://username:password@proxy.company.com:8080";
   ```

### Download DEB Packages

Only download deb packages for offline installation:

```bash
apt-get download <package-name>
```
