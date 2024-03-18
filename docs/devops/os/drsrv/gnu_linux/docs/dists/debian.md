# [Debian Distro Doc](#debian-distro-doc)

## [Configure Static IP address](#configure-static-ip-address)

> vim /etc/network/interfaces

```bash
iface ens33 inet static
    address 172.22.132.xxx
    netmask 255.255.255.0
    gateway 172.22.132.1
    # dns-servernames 10.0.5.55 10.0.5.94
```

> /sbin/ifup \<interface-name\>  
> systemctl restart networking

> vim /etc/resolve.conf

```bash
domain drpc.ir
search localdomain
nameserver 10.0.5.94
nameserver 10.0.5.55
```

## [Debian sources.list](#debian-sourceslist)

### [Debian 11](#debian-11)

```bash
deb http://deb.debian.org/debian bullseye main
deb-src http://deb.debian.org/debian bullseye main

deb http://deb.debian.org/debian bullseye-updates main
deb-src http://deb.debian.org/debian bullseye-updates main

deb http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
```

### [Debian 12](#debian-12)

```bash
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main
```

## [Download DEB Packages](#download-deb-packages)

> only download deb packages for offline installation:

```bash
    apt-get downolad <package-name>
```

## [Update Python 3 on Debian](#update-python-3-on-debian)

- [**Update python on debian via this link**](#update-python-on-debian-link)
