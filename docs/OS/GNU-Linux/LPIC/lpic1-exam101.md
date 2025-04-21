# LPIC-1 Exam 101 Objectives

## Topic 101: System Architecture

### [101.1 Determine and configure hardware settings](https://learning.lpi.org/en/learning-materials/101-500/101/101.1/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/101/101.1/101.1_01/)

- **Terms & Utilities:**

  - /sys/
  - /proc/
  - /dev/
  - modprobe
  - lsmod
  - lspci
  - lsusb

### [101.2 Boot the system](https://learning.lpi.org/en/learning-materials/101-500/101/101.2/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/101/101.2/101.2_01/)

- **Terms & Utilities:**

  - dmesg
  - journalctl
  - BIOS
  - UEFI
  - bootloader
  - kernel
  - initramfs
  - init
  - SysVinit
  - systemd

### [101.3 Change runlevels / boot targets and shutdown or reboot system](https://learning.lpi.org/en/learning-materials/101-500/101/101.3/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.1/102.1_01/)

- **Terms & Utilities:**
  - /etc/inittab
  - shutdown
  - init
  - /etc/init.d/
  - telinit
  - systemd
  - systemctl
  - /etc/systemd/
  - /usr/lib/systemd/
  - wall

## Topic 102: Linux Installation and Package Management

### [102.1 Design hard disk layout](https://learning.lpi.org/en/learning-materials/101-500/102/102.1/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.1/102.1_01/)

- **Terms & Utilities:**

  - / (root) filesystem
  - /var filesystem
  - /home filesystem
  - /boot filesystem
  - EFI System Partition (ESP)
  - swap space
  - mount points
  - partitions

### [102.2 Install a boot manager](https://learning.lpi.org/en/learning-materials/101-500/102/102.2/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.2/102.2_01/)

- **Terms & Utilities:**

  - menu.lst, grub.cfg and grub.conf
  - grub-install
  - grub-mkconfig
  - MBR

### [102.3 Manage shared libraries](https://learning.lpi.org/en/learning-materials/101-500/102/102.3/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.3/102.3_01/)

- **Terms & Utilities:**

  - ldd
  - ldconfig
  - /etc/ld.so.conf
  - LD_LIBRARY_PATH

### [102.4 Use Debian package management](https://learning.lpi.org/en/learning-materials/101-500/102/102.4/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.4/102.4_01/)

- **Terms & Utilities:**

  - /etc/apt/sources.list
  - dpkg
  - dpkg-reconfigure
  - apt-get
  - apt-cache

### [102.5 Use RPM and YUM package management](https://learning.lpi.org/en/learning-materials/101-500/102/102.5/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.5/102.5_01/)

- **Terms & Utilities:**

  - rpm
  - rpm2cpio
  - /etc/yum.conf
  - /etc/yum.repos.d/
  - yum
  - zypper

### [102.6 Linux as a virtualization guest](https://learning.lpi.org/en/learning-materials/101-500/102/102.6/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/102/102.6/102.6_01/)

- **Terms & Utilities:**
  - Virtual machine
  - Linux container
  - Application container
  - Guest drivers
  - SSH host keys
  - D-Bus machine id

## Topic 103: GNU and Unix Commands

### [103.1 Work on the command line](https://learning.lpi.org/en/learning-materials/101-500/103/103.1/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.1/103.1_01/)
- [**lesson two**](https://learning.lpi.org/en/learning-materials/101-500/103/103.1/103.1_02/)

#### Terms and Utilities

- bash
- echo
- env
- export
- pwd
- set
- unset
- type
- which
- man
- uname
- history
- .bash_history
- Quoting

### [103.2 Process text streams using filters](https://learning.lpi.org/en/learning-materials/101-500/103/103.2/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.2/103.2_01/)

#### Terms and Utilities

- bzcat
- cat
- cut
- head
- less
- md5sum
- nl
- od
- paste
- sed
- sha256sum
- sha512sum
- sort
- split
- tail
- tr
- uniq
- wc
- xzcat
- zcat

### [103.3 Perform basic file management](https://learning.lpi.org/en/learning-materials/101-500/103/103.3/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.3/103.3_01/)
- [**lesson two**](https://learning.lpi.org/en/learning-materials/101-500/103/103.3/103.3_02/)

#### Terms and Utilities

- cp
- find
- mkdir
- mv
- ls
- rm
- rmdir
- touch
- tar
- cpio
- dd
- file
- gzip
- gunzip
- bzip2
- bunzip2
- xz
- unxz
- file globbing

### [103.4 Use streams, pipes and redirects](https://learning.lpi.org/en/learning-materials/101-500/103/103.4/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.4/103.4_01/)
- [**lesson two**](https://learning.lpi.org/en/learning-materials/101-500/103/103.4/103.4_02/)

#### Terms and Utilities

- tee
- xargs

### [103.5 Create, monitor and kill processes](https://learning.lpi.org/en/learning-materials/101-500/103/103.5/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.5/103.5_01/)
- [**lesson two**](https://learning.lpi.org/en/learning-materials/101-500/103/103.5/103.5_02/)

#### Terms and Utilities

- &
- bg
- fg
- jobs
- kill
- nohup
- ps
- top
- free
- uptime
- pgrep
- pkill
- killall
- watch
- screen
- tmux

### [103.6 Modify process execution priorities](https://learning.lpi.org/en/learning-materials/101-500/103/103.6/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.6/103.6_01/)

#### Terms and Utilities

- nice
- ps
- renice
- top

### [103.7 Search text files using regular expressions](https://learning.lpi.org/en/learning-materials/101-500/103/103.7/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.7/103.7_01/)
- [**lesson two**](https://learning.lpi.org/en/learning-materials/101-500/103/103.7/103.7_02/)

#### Terms and Utilities

- grep
- egrep
- fgrep
- sed
- regex(7)

### [103.8 Basic file editing](https://learning.lpi.org/en/learning-materials/101-500/103/103.8/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/103/103.8/103.8_01/)

#### Terms and Utilities

- vi
- /, ?
- h,j,k,l
- i, o, a
- d, p, y, dd, yy
- ZZ, :w!, :q!
- EDITOR

## Topic 104: Devices, Linux Filesystems, Filesystem Hierarchy Standard

### [104.1 Create partitions and filesystems](https://learning.lpi.org/en/learning-materials/101-500/104/104.1/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.1/104.1_01/)

#### Terms and Utilities

- fdisk
- gdisk
- parted
- mkfs
- mkswap

### [104.2 Maintain the integrity of filesystems](https://learning.lpi.org/en/learning-materials/101-500/104/104.2/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.2/104.2_01/)

#### Terms and Utilities

- du
- df
- fsck
- e2fsck
- mke2fs
- tune2fs
- xfs_repair
- xfs_fsr
- xfs_db

### [104.3 Control mounting and unmounting of filesystems](https://learning.lpi.org/en/learning-materials/101-500/104/104.3/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.3/104.3_01/)

#### Terms and Utilities

- /etc/fstab
- /media/
- mount
- umount
- blkid
- lsblk

### [104.4 Removed](https://jadi.gitbooks.io/lpic1/content/1044_manage_disk_quotas.html)

### [104.5 Manage file permissions and ownership](https://learning.lpi.org/en/learning-materials/101-500/104/104.5/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.5/104.5_01/)

#### Terms and Utilities

- chmod
- umask
- chown
- chgrp

### [104.6 Create and change hard and symbolic links](https://learning.lpi.org/en/learning-materials/101-500/104/104.6/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.6/104.6_01/)

#### Terms and Utilities

- ln
- ls

### [104.7 Find system files and place files in the correct location](https://learning.lpi.org/en/learning-materials/101-500/104/104.7/)

- [**lesson one**](https://learning.lpi.org/en/learning-materials/101-500/104/104.7/104.7_01/)

#### Terms and Utilities

- find
- locate
- updatedb
- whereis
- which
- type
- /etc/updatedb.conf
