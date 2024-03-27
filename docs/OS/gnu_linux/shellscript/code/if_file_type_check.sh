#!/bin/bash

# check character divice files
if [ -c /dev/tty ]; then
    echo "yes '/dev/tty' is a character device"
fi

# check block divice files
if [ -b /dev/sda ]; then
    echo "yes '/dev/sda' is a block device"
fi

# check character divice files
# mkfifo /tmp/pipef
if [ -p /tmp/pipef ]; then
    echo "yes '/tmp/pipef' is a pipeline device"
fi

# check symbolic link files
if [ -h /usr/bin/java ]; then
    echo "yes '/usr/bin/java' is a symbolic link"
fi

# check symbolic link files
if [ -L /usr/bin/java ]; then
    echo "yes '/usr/bin/java' is a symbolic link"
fi

# check socket files
if [ -S /run/cups/cups.sock ]; then
    echo "yes '/run/cups/cups.sock' is a socket file"
fi

# check readable files
if [ -r /etc/passwd ]; then
    echo "yes '/etc/passwd' is a readable file"
fi

# check writable files
if [ -w /etc/passwd ]; then
    echo "yes '/etc/passwd' is a writable file"
fi

# check executable files
if [ -x /bin/bash ]; then
    echo "yes '/bin/bash' is a executable file"
fi

# check modifaction files
if [ -N /bin/bash ]; then
    echo "yes '/bin/bash' has been modified"
fi

# check SUID files
if [ -u  /usr/bin/passwd ]; then
    echo "yes '/usr/bin/passwd ' has s-user-id"
fi

# check SGID files 
if [ -g /usr/bin/wall ]; then
    echo "yes '/usr/bin/wall' has s-group-id"
fi

# check sticky bite files 
if [ -k /tmp ]; then
    echo "yes '/tms' has has active sticky bit"
fi

# check the file exists
if [ -e /etc/passwd ]; then
    echo "yes '/etc/passwd/' is exists"
fi

# check file exists and a directory
if [ -f /etc/passwd ];then
    echo "yes '/etc/passwd' is exists and also is a file"
fi

# check file exists and a directory
if [ -d /etc ];then
    echo "yes '/etc' is a file and also is a directory"
fi

# check file exists and readable
if [ -s /etc/passwd ];then
    echo "yes '/etc/passwd' is a file and also has content"
fi

# check file owner
if [ -O /etc ];then
    echo "yes '/etc' is for mehrdad"
else
    echo "no '/ect' for root"
fi

# check file group
if [ -G /etc ];then
    echo "yes '/etc' in mehrdad group"
else
    echo "no '/ect' in root group"
fi

if [ -f /etc/passwd ] || [ -r -x /etc/passwd ]; then
    echo "yes"
else
    echo "no"
fi

if [ ! -d /var/log ]; then
    echo "directory '/var/log' does not exist"
else
    echo "directory '/var/log' exists"
fi


