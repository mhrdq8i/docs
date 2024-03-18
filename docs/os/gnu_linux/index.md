# My DevOps Documentation Framework

## OS Section

### Server OS

#### Linux

- [**Architecture**](docs/arch/)

  - [**ELF**](docs/arch/elf.md)
  - [**Linker & Loader**](docs/arch/linker-loader.md)
  - [**Kernel**](docs/arch/kernel.md)
  - [**MMU**](docs/arch/mmu.md)

- [**LPIC**](docs/lpic/)

  - [**docs**](docs/lpic/)
    - [**LPIC 101**](../gnu_linux/docs/lpic/lpic_1-exam_101.md)
    - [**LPIC 102**](../gnu_linux/docs/lpic/lpic_1-exam_102.md)
  - [**refs**](refs/)
    - [**LPIC 101**](../gnu_linux/refs/LPI-Learning-Material-101-500-en.pdf)
    - [**LPIC 102**](../gnu_linux/refs/LPI-Learning-Material-102-500-en.pdf)
    - [**LPIC 2**](../gnu_linux/refs/lpic2book.pdf)

- [**Hardware**](docs/hardware.md#work-with-hardware-via-linux)

  - [**Mainboard info**](docs/hardware.md#check-mainboard-info)
  - [**CPU info**](docs/hardware.md#check-cpu-info)
  - [**Memory info**](docs/hardware.md#check-memory-info)
  - [**Disk info**](docs/hardware.md#check-disk-info)
  - [**Monitor info**](docs/hardware.md#check-monitor-info)

- [**Apps**](docs/apps.md)

  - [**Tmux**](docs/apps.md#tmux)

- [**Network**](docs/networks.md#linux-network-stack-tools-commands)

  - [**60 Linux Networking commands and scripts**](docs/networks.md#linux-network-stack-tools-commands)
  - [**Top 20 Useful Tools**](docs/networks.md#top-20-tools)
  - [**Proxy**](docs/networks.md#proxy)
  - [**SSH**](docs/networks.md#ssh)
  - [**SCP**](docs/networks.md#scp)
  - [**rsync**](docs/networks.md#rsync)
  - [**IP command**](docs/networks.md#ip-command)
  - [**Route**](docs/networks.md#route)
  - [**Telnet**](docs/networks.md#telnet)
  - [**NC**](docs/networks.md#nc-netcat)
  - [**Nmap**](docs/networks.md#nmap)
  - [**fuser**](docs/networks.md#fuser)
  - [**Troubleshooting Tools**](docs/networks.md#t-shoot-tools)
  - [**Log File**](docs/networks.md#1-log-file)
  - [**Commands**](docs/networks.md#2-commands)
  - [**Interactive Troubleshoot**](docs/networks.md#3-interactive-trouble)
  - [**Expert DNS Resolve Commands**](docs/networks.md#4-expert--dns-resolve-commands)
  - [**TCPDump**](docs/networks.md#5-tcpdump)

- [**Security**](docs/security.md)

  - [**Encryption/Decryption**](docs/security.md#encryptiondecryption)
    - [**GPG**](docs/security.md#gpg)

- [**Shell**](docs/shell/)

  - [**Shellscript doc & code from github**](docs/shell/shellscript/)
    - [**Code**](docs/shell/shellscript/code/)
    - [**Doc**](docs/shell/shellscript/docs/)
  - [**Bash**](docs/shell/bash.md)
    - [**Set**](docs/shell/bash.md#set)

- [**Distribution**](docs/dists/)

  - [**Debian**](docs/dists/debian.md#debian-distro-doc)

    - [**Configure Static IP Address**](docs/dists/debian.md#configure-static-ip-address)
    - [**Sources.list**](docs/dists/debian.md#debian-sourceslist)
      - [**Debian 11**](docs/dists/debian.md#debian-11)
      - [**Debian 12**](docs/dists/debian.md#debian-12)
    - [**Download DEB Packages**](docs/dists/debian.md#download-deb-packages)
    - [**Update Python 3 on Debian**](docs/dists/debian.md#update-python-on-debian-link)

  - [**Ubuntu**](docs/dists/ubuntu.md#ubuntu-distro-doc)
    - [**Ubuntu Config netplan (network)**](docs/dists/ubuntu.md#config-netplan-network)
    - [**Get the list of installed packages**](docs/dists/ubuntu.md#get-the-list-of-installed-packages)
    - [**Set APT Proxy**](docs/dists/ubuntu.md#set-apt-proxy)
      - [**squid**](docs/dists/ubuntu.md#via-squid)
      - [**socks**](docs/dists/ubuntu.md#via-socks)
  - [**redhat**](docs/dists/redhat.md#redhat-dist-doc)
    - [**subscription for redhat enterprise**](docs/dists/redhat.md#subscription-for-redhat-enterprise)

- [**Commands**](docs/commands.md#linux-commands-files)

  - [**90 Linux Commands frequently used by Linux Sysadmins**](docs/commands.md#linux-commands-files)
    - [**Part 1**](docs/commands.md#linux-commands-frequently-used-by-linux-sysadmins-–-part-1)
    - [**Part 2**](docs/commands.md#linux-commands-frequently-used-by-linux-sysadmins-–-part-2)
    - [**Part 3**](docs/commands.md#linux-commands-frequently-used-by-linux-sysadmins-–-part-3)
    - [**Part 4**](docs/commands.md#linux-commands-frequently-used-by-linux-sysadmins-–-part-4)
    - [**Part 5**](docs/commands.md#linux-commands-frequently-used-by-linux-sysadmins-–-part-5)
    - [**Misc Commands**](docs/commands.md#misc-commands)
  - [**LVM**](docs/commands.md#lvm)
  - [**Write a new partition on disk**](docs/commands.md#write-a-new-partition-on-disk)
    - [**Check the free space and partitions with mount point**](docs/commands.md#check-the-free-space-and-partitions-with-mount-point)
    - [**Create a new partition on the disk**](docs/commands.md#create-a-new-partition-on-the-disk)
    - [**Mount Option**](docs/commands.md#mount-option)
      - [**Show mounted partitions**](docs/commands.md#show-mounted-partitions)
      - [**Find mount**](docs/commands.md#findmnt)
    - [**Mount temporary**](docs/commands.md#mount-temporary)
    - [**Mount permanently via fstab**](docs/commands.md#mount-permanently-via-fstab)
  - [**Mount chroot shell / change password**](docs/commands.md#mount-chroot-shell--change-password)
  - [**Find**](docs/commands.md#find)
  - [**Users and Groups**](docs/commands.md#users-and-groups)
    - [**Users**](docs/commands.md#users)
    - [**Groups**](docs/commands.md#groups)
  - [**Archive & Compress**](docs/commands.md#archive--compress)
    - [**tar**](docs/commands.md#tar)
    - [**xz**](docs/commands.md#xz)
    - [**gz**](docs/commands.md#gz)
    - [**bz**](docs/commands.md#bzip2)
  - [**systemctl**](docs/commands.md#systemctl)
  - [**grep**](docs/commands.md#grep)
  - [**sed**](docs/commands.md#sed)
  - [**sudoer**](docs/commands.md#sudoer)
  - [**Monitor Resources**](docs/commands.md#monitor-resources)
  - [**open ssl**](docs/commands.md#open-ssl)
  - [**curl**](docs/commands.md#curl)

---

> Your are here `/ops/os/drsrv/gnu_linux/`

[back](../index.md)
