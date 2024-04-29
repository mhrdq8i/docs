# Commands

## 90 Linux Commands frequently used by Linux Sysadmins

[Click here to visit page][90LinuxCommandsfrequentlyusedbyLinuxSysadmins]

## Linux Commands frequently used by Linux Sysadmins

### Part 1

```bash
01. ip – from Iproute2, a collection of utilities for controlling TCP/IP networking and traffic control in Linux.
02. ls – list directory contents.
03. df – display disk space usage.
04. du – estimate file space usage.
05. free – display memory usage.
06. scp – securely Copy Files Using SCP, with examples.
07. find – locates files based on some user-specified criteria.
08. ncdu – a disk utility for Unix systems.
09. pstree – display a tree of processes.
10. last – show a listing of last logged-in users.
11. w – show a list of currently logged-in user sessions.
12. grep – Search a file for a pattern of characters, then display all matching lines.
```

### Part 2

```bash
13. uptime – shows system uptime and load average.
14. top – shows an overall system view.
15. vmstat – shows system memory, processes, interrupts, paging, block I/O, and CPU info.
16. htop – interactive process viewer and manager.
17. dstat – view processes, memory, paging, I/O, CPU, etc., in real-time. All-in-one for vmstat, iostat, netstat, and ifstat.
18. iftop – network traffic viewer.
19. nethogs – network traffic analyzer.
20. iotop – interactive I/O viewer. Get an overview of storage r/w activity.
21. iostat – for storage I/O statistics.
22. netstat – for network statistics.
23. ss – utility to investigate sockets.
24. atop – For Linux server performance analysis.
25. Glances and nmon – htop and top Alternatives:
26. ssh – secure command-line access to remote Linux systems.
27. sudo – execute commands with administrative privilege.
28. cd – directory navigation.
29. pwd – shows your current directory location.
30. cp – copying files and folders.
31. mv – moving files and folders.
32. rm – removing files and folders.
33. mkdir – create or make new directories.
34. touch – used to update the access date and modification date of a computer file or directory.
35. man – for reading system reference manuals.
36. apropos – Search man page names and descriptions.
```

### Part 3

```bash
37. rsync – remote file transfers and syncing.
38. tar – an archiving utility.
39. gzip – file compression and decompression.
40. bzip2 – similar to gzip. It uses a different compression algorithm.
41. zip – for packaging and compressing (to archive) files.
42. locate – search files in Linux.
43. ps – information about the currently running processes.
44. Making use of Bash scripts. Example: ./bashscript.sh
45. cron – set up scheduled tasks to run.
46. nmcli – command-line tool for controlling NetworkManager.
47. ping – send ICMP ECHO_REQUEST to network hosts.
48. traceroute – check the route packets take to a specified host.
49. mtr – network diagnostic tool.
50. nslookup – query Internet name servers (NS) interactively.
51. host – perform DNS lookups in Linux.
52. dig – DNS lookup utility.
```

### Part 4

```bash
53. wget – retrieve files over HTTP, HTTPS, FTP, and FTPS.
54. curl – transferring data using various network protocols. (supports more protocols than wget)
55. dd – convert and copy files.
56. fdisk – manipulate the disk partition table.
57. parted – for creating and manipulating partition tables.
58. blkid – command-line utility to locate/print block device attributes.
59. mkfs – build a Linux file system.
60. fsck – tool for checking the consistency of a file system.
61. whois – client for the whois directory service.
62. nc – command-line networking utility. (Also, see 60 Linux Networking commands scripts.)
63. umask – set file mode creation mask.
64. chmod – change the access permissions of file system objects.
65. chown – change file owner and group.
66. chroot – run command or interactive shell with a special root directory
67. useradd – create a new user or update default new user information.
68. userdel – used to delete a user account and all related files.
69. usermod – used to modify or change any attributes of an existing user account.
```

### Part 5

```bash
70. vi – text editor.
71. cat – display file contents.
72. tac – output file contents, in reverse.
73. more – display file contents one screen/page at a time.
74. less – similar to the more command with additional features.
75. tail – used to display the tail end of a text file or piped data.
76. dmesg – prints the message buffer of the kernel ring.
77. journalctl – query the systemd journal.
78. kill – terminate a process.
79. killall – Sends a kill signal to all instances of a process by name.
80. sleep – suspends program execution for a specified time.
81. wait – Suspend script execution until all jobs running in the back ground have been terminated.
82. nohup – Run Commands in the Background.
83. screen – hold a session open on a remote server. (also a full-screen window manager)
84. tmux – a terminal multiplexer.
85. passwd – change a user’s password.
86. chpassword – allows users to change the password for various user accounts
87. mount / umount – provides access to an entire filesystem in one directory
88. systemctl – central management tool for controlling the init system.
89. clear – clears the screen of the terminal.
90. env -Run a command in a modified environment.
```

### Misc commands

```bash
91. cheat – allows you to create and view interactive cheat-sheets on the command line.”
92. tldr – Collaborative cheat-sheets for console commands.
93. bashtop – the ‘cool’ top alternative.
94. bpytop – Python port of bashtop.
95. btop – C++ version and continuation of bashtop and bpytop.
96. nload – a super simple, command-line network interface monitoring tool.
97. history – used to view the previously executed commands.
98. sar – collects, reports, and saves system activity information, including CPU, memory, disk, and network usage.
```

## LVM

### Knowing LVM's concept through some images

![lvm-image-1]
![lvm-image-2]
![lvm-image-3]
![lvm-image-4]

Steps to add physical disk or new partition to LVM

```bash
lsblk -f
df -Th
fdisk /dev/sda
F
n
l
find 8e (lvm)
t
8e (lvm)
w
mkfs.ext4 /dev/sdb[x]
pvcreate /dev/sdaX
vgextend vg-name /dev/new-partition
lvextend -L [final-partition-size] /dev/VGname
lvextend -L 99G /dev/ubuntu1804-vg/root
resize2fs /dev/vg-name/lv-name
```

### LVM snapshot

```bash
lvcreate -v -L -s -n backup /dev/vg-name
```

### write a new partition on disk

```bash
# Check the free space and partitions with mount point
lsblk
df -h

# Create a new partition on the disk
fdisk /dev/sd{a..z}
n
p / e
choice partition number
choice partition first sector
choice partition last sector
w
mkfs.ext4 /dev/sd{a..z}{1..n}
```

### Mount Option

```bash

# Show mounted partitions
fdisk -l
mount | column -t
df -h

# findmnt
findmnt -l
findmnt -D
findmnt --fstab /home

# Mount temporary
mount /dev/sd{a..z}{1..n} /xyz

# Mount permanently via fstab
1. Add new disk (usually /dev/sdb)
2. Create new partition on disk
3. Format partition with new FS (mkfs.ext4 /dev/sdb[x])
4. Mount a specific path to new partition
5. Edit `fstab` for mount permanently
```

### Change left root password

```bash
# Mount chroot shell - change password
1. Boot the Ubuntu Live CD.
2. Press Ctrl-Alt-F1
3. sudo mount /dev/sda1 /mnt
4. If you created a custom partition layout when installing Ubuntu you have to find your ‍root partition using the `fdisk -l` utility. See the section Finding your root partition.
5. sudo chroot /mnt
```

## Find

```bash
# search normal files:
find /root -type f -iname pom.xml

# search socket files:
find / -type s

# search suid files:
find /usr/bin -perm -4000

# search sgid files:
find /usr/bin -perm -2000

# search sticky files:
find /usr/bin -perm -1000

# exclude
find -name example ! ( -name ".." -o -name "." -o -name '\\\_\\\*.sql' )

# Delete old 10 days files:
find /path/to/base/dir/\\\* -type d -ctime +10 -exec rm -rf {} ;
```

## Users and Groups

### Users

**Difference** between `useradd` and `adduser`:

`useradd` is native binary compiled with the system. But, `adduser` is a perl script which uses `useradd` binary in back-end.

`adduser` is a perl script and more user friendly and interactive than its back-end useradd. There's no difference in features provided.

`adduser` is a wrapper for `useradd`

#### Add user

```bash
# Add a new user with home directory
useradd -m mehrdad

# Add a new user with group and default shell
useradd -m mehrdad -g mehrdadgrp -s /bin/zsh

# Delete an existing user with home folder
userdel -r mehrdad

# List of users that user has already added
groups mehrdad
```

#### Changing owner

```bash
# Change owner of file
chown user_name file_name

# Change group and user owner:
chown group_name:user_name file_name

# change owner/group of a directory
sudo chown -R username:group <directory-name>
```

#### Lock and Unlock an user

```bash
# automatically
usermod -L mehrdad
usermod -U mehrdad

# manually
vim /etc/passwd
root:x:0:0:root:/root:/sbin/nologin
root:x:0:0:root:/root:/usr/sbin/nologin
```

#### Kill user in another session

```bash
ctrl + alt + f2
pkill -9 -u USER || ps -fp $(pgrep -d, -u USERNAME)
```

#### Grep all active users

```bash
sudo cat /etc/passwd | egrep "bash$"
```

#### check user exists

```bash
getent passwd root
```

### Groups

```bash
# Add a new group
grpadd

# Add an existing user to a specific group
usermod -aG grp_name user_name
gpasswd -a user_name grp_name

# Change group owner of file
chgrp group_name file_name
chown :group_name file_name
```

## Archive & Compression

### TAR

```bash
# Create TAR file
tar -cf file-name.tar file/directory

# Extract tar.xz file
tar -xf 1.tar.xz

# Extract tar.gz file
tar -xvzf 1.tar.gz

# Extract tar.bz file
tar -xvf 1.tar.bz
```

### XZ

```bash
# Add directory into the XZ compress file
tar cf - directory-name | xz -z > archive-name.tar.xz

# Create/Extract one file to XZ file
xz -z ramz.txt.gpg
xz -d ramz.txt.gpg.xz

# Create `XZ` file into the another file
xz -z ramz.txt.gpg > ramz.txt.gpg.tar.xz

# Compress existed TAR file
xz --compress images.tar
```

### GZ

```bash
# Add directory into the GZ compress file
tar cf - directory-name | gzip > archive-name.tar.gz
```

### BZIP2

```bash
# Add directory into the BZ compress file
tar cf - directory-name | bzip2 > archive-name.tar.gz
```

## systemctl

```bash
# Get the list of services(units):
systemctl list-units --type=service
```

## grep

```bash
# Reverse grep
grep -v

# count target
grep -c

# grep with line number
grep -n

# grep case insensitive
grep -i

# first line character
"^"

#end line character
"$"
or
-e
|
```

## sed

### sed switch

```bash
- `s` (substitute match pattern)
- `g` (global sub)
- `3g` (after 3th character sub)
- `-e` (selected items)
- `&` (same characters)
- `-i` (save to file)
- `-r` (extended regex)
- `#line number` (each line that you want to apply sed)
- `# !` (each line that you don't want to apply sed)
- `d` (delete matched pattern)
- `-p` (print matched pattern)
- `I` (case ignore flag)
```

## sudoer

### force edit visudo

```bash
pkexec visudo
```

## Monitor Resources

```bash
top
htop
btop
bpytop
uptime
iotop
vmstat
iftop
```

## open ssl

Create new CERT file via openssl (squid example):

```bash
openssl req -x509 -new -nodes -days 3650 -keyout /etc/squid/squid.key -out /etc/squid/squid.crt

# open CERT file to show content:

openssl -x509 -in squid.key -text
```

## curl

A ton of curl examples [is here][curl-https-request]

```bash
# download with curl
curl -C - -L -O URL
```

## Watch the OS installation date and time

```bash
stat -c %w /
```

## Print Format Date

> date +%<format-option\>

```bash
date +"YEAR: %Y - Month: %m - Day: %d"
```

<!-- external link -->
[90LinuxCommandsfrequentlyusedbyLinuxSysadmins]: https://haydenjames.io/90-linux-commands-frequently-used-by-linux-sysadmins/
[curl-https-request]: https://reqbin.com/req/c-lfozgltr/curl-https-request
[lvm-image-1]: /docs/assets/gnu_linux/lvm1.png
[lvm-image-2]: /docs/assets/gnu_linux/lvm2.png
[lvm-image-3]: /docs/assets/gnu_linux/lvm3.png
[lvm-image-4]: /docs/assets/gnu_linux/lvm4.png
