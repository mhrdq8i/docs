# LPIC-1 Exam 101 Objectives

## Topic 105: Shells and Shell Scripting

- ### [105.1 Customize and use the shell environment](https://learning.lpi.org/en/learning-materials/102-500/105/105.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/105/105.1/105.1_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/105/105.1/105.1_02/)
  - [**lesson three**](https://learning.lpi.org/en/learning-materials/102-500/105/105.1/105.1_03/)

- **terms and utilities:**

  - .
  - source
  - /etc/bash.bashrc
  - /etc/profile
  - env
  - export
  - set
  - unset
  - ~/.bash_profile
  - ~/.bash_login
  - ~/.profile
  - ~/.bashrc
  - ~/.bash_logout
  - function
  - alias

- ### [105.2 Customize or write simple scripts](https://learning.lpi.org/en/learning-materials/102-500/105/105.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/105/105.2/105.2_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/105/105.2/105.2_02/)

- **terms and utilities:**

  - for
  - while
  - test
  - if
  - read
  - seq
  - exec
  - ||
  - &&

## Topic 106: User Interfaces and Desktops

- ### [106.1 Install and configure X11](https://learning.lpi.org/en/learning-materials/102-500/106/106.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/106/106.1/106.1_01/)

- **terms and utilities:**

  - /etc/X11/xorg.conf
  - /etc/X11/xorg.conf.d/
  - ~/.xsession-errors
  - xhost
  - xauth
  - DISPLAY
  - X

- ### [106.2 Graphical Desktops](https://learning.lpi.org/en/learning-materials/102-500/106/106.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/106/106.2/106.2_01/)

- **terms and utilities:**

  - KDE
  - Gnome
  - Xfce
  - X11
  - XDMCP
  - VNC
  - Spice
  - RDP

- ### [106.3 Accessibility](https://learning.lpi.org/en/learning-materials/102-500/106/106.3/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/106/106.3/106.3_01/)

- **terms and utilities:**

  - High Contrast/Large Print Desktop Themes.
  - Screen Reader.
  - Braille Display.
  - Screen Magnifier.
  - On-Screen Keyboard.
  - Sticky/Repeat keys.
  - Slow/Bounce/Toggle keys.
  - Mouse keys.
  - Gestures.
  - Voice recognition.

## Topic 107: Administrative Tasks

- ### [107.1 Manage user and group accounts and related system files](https://learning.lpi.org/en/learning-materials/102-500/107/107.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/107/107.1/107.1_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/107/107.1/107.1_02/)

- **terms and utilities:**

  - /etc/passwd
  - /etc/shadow
  - /etc/group
  - /etc/skel/
  - chage
  - getent
  - groupadd
  - groupdel
  - groupmod
  - passwd
  - useradd
  - userdel
  - usermod

- ### [107.2 Automate system administration tasks by scheduling jobs](https://learning.lpi.org/en/learning-materials/102-500/107/107.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/107/107.2/107.2_01/)
  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/107/107.2/107.2_02/)

- **terms and utilities:**

  - /etc/cron.{d,daily,hourly,monthly,weekly}/
  - /etc/at.deny
  - /etc/at.allow
  - /etc/crontab
  - /etc/cron.allow
  - /etc/cron.deny
  - /var/spool/cron/
  - crontab
  - at
  - atq
  - atrm
  - systemctl
  - systemd-run

- ### [107.3 Localisation and internationalisation](https://learning.lpi.org/en/learning-materials/102-500/107/107.3/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/107/107.3/107.3_01/)

- **terms and utilities:**

  - /etc/timezone
  - /etc/localtime
  - /usr/share/zoneinfo/
  - LC\_\*
  - LC_ALL
  - LANG
  - TZ
  - /usr/bin/locale
  - tzselect
  - timedatectl
  - date
  - iconv
  - UTF-8
  - ISO-8859
  - ASCII
  - Unicode

## Topic 108: Essential System Services

- ### [108.1 Maintain system time](https://learning.lpi.org/en/learning-materials/102-500/108/108.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/108/108.1/108.1_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/108/108.1/108.1_02/)

- **terms and utilities:**

  - /usr/share/zoneinfo/
  - /etc/timezone
  - /etc/localtime
  - /etc/ntp.conf
  - /etc/chrony.conf
  - date
  - hwclock
  - timedatectl
  - ntpd
  - ntpdate
  - chronyc
  - pool.ntp.org

- ### [108.2 System logging](https://learning.lpi.org/en/learning-materials/102-500/108/108.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/108/108.2/108.2_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/108/108.2/108.2_02/)

- **terms and utilities:**

  - /etc/rsyslog.conf
  - /var/log/
  - logger
  - logrotate
  - /etc/logrotate.conf
  - /etc/logrotate.d/
  - journalctl
  - systemd-cat
  - /etc/systemd/journald.conf
  - /var/log/journal/

- ### [108.3 Mail Transfer Agent (MTA) basics](https://learning.lpi.org/en/learning-materials/102-500/108/108.3/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/108/108.3/108.3_01/)

- **terms and utilities:**

  - ~/.forward
  - sendmail emulation layer commands
  - newaliases
  - mail
  - mailq
  - postfix
  - sendmail
  - exim

- ### [108.4 Manage printers and printing](https://learning.lpi.org/en/learning-materials/102-500/108/108.4/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/108/108.4/108.4_01/)

- **terms and utilities:**

  - CUPS configuration files, tools and utilities
  - /etc/cups/
  - lpd legacy interface (lpr, lprm, lpq)

## Topic 109: Networking Fundamentals

- ### [109.1 Fundamentals of internet protocols](https://learning.lpi.org/en/learning-materials/102-500/109/109.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/109/109.1/109.1_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/109/109.1/109.1_02/)

- **terms and utilities:**

  - /etc/services
  - IPv4, IPv6
  - Subnetting
  - TCP, UDP, ICMP

- ### [109.2 Persistent network configuration](https://learning.lpi.org/en/learning-materials/102-500/109/109.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/109/109.2/109.2_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/109/109.2/109.2_02/)

- **terms and utilities:**

  - /etc/hostname
  - /etc/hosts
  - /etc/nsswitch.conf
  - /etc/resolv.conf
  - nmcli
  - hostnamectl
  - ifup
  - ifdown

- ### [109.3 Basic network troubleshooting](https://learning.lpi.org/en/learning-materials/102-500/109/109.3/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/109/109.3/109.3_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/109/109.3/109.3_02/)

- **terms and utilities:**

  - ip
  - hostname
  - ss
  - ping
  - ping6
  - traceroute
  - traceroute6
  - tracepath
  - tracepath6
  - netcat
  - ifconfig
  - netstat
  - route

- ### [109.4 Configure client side DNS](https://learning.lpi.org/en/learning-materials/102-500/109/109.4/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/109/109.4/109.4_01/)

- **terms and utilities:**

  - /etc/hosts
  - /etc/resolv.conf
  - /etc/nsswitch.conf
  - host
  - dig
  - getent

## Topic 110: Security

- ### [110.1 Perform security administration tasks](https://learning.lpi.org/en/learning-materials/102-500/110/110.1/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/110/110.1/110.1_01/)

- **terms and utilities:**

  - find
  - passwd
  - fuser
  - lsof
  - nmap
  - chage
  - netstat
  - sudo
  - /etc/sudoers
  - su
  - usermod
  - ulimit
  - who, w, last

- ### [110.2 Setup host security](https://learning.lpi.org/en/learning-materials/102-500/110/110.2/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/110/110.2/110.2_01/)

- **terms and utilities:**

  - /etc/nologin
  - /etc/passwd
  - /etc/shadow
  - /etc/xinetd.d/
  - /etc/xinetd.conf
  - systemd.socket
  - /etc/inittab
  - /etc/init.d/
  - /etc/hosts.allow
  - /etc/hosts.deny

- ### [110.3 Securing data with encryption](https://learning.lpi.org/en/learning-materials/102-500/110/110.3/)

  - [**lesson one**](https://learning.lpi.org/en/learning-materials/102-500/110/110.3/110.3_01/)
  - [**lesson two**](https://learning.lpi.org/en/learning-materials/102-500/110/110.3/110.3_02/)

- **terms and utilities:**

  - ssh
  - ssh-keygen
  - ssh-agent
  - ssh-add
  - ~/.ssh/id_rsa and id_rsa.pub
  - ~/.ssh/id_dsa and id_dsa.pub
  - ~/.ssh/id_ecdsa and id_ecdsa.pub
  - ~/.ssh/id_ed25519 and id_ed25519.pub
  - /etc/ssh/ssh_host_rsa_key and ssh_host_rsa_key.pub
  - /etc/ssh/ssh_host_dsa_key and ssh_host_dsa_key.pub
  - /etc/ssh/ssh_host_ecdsa_key and ssh_host_ecdsa_key.pub
  - /etc/ssh/ssh_host_ed25519_key and ssh_host_ed25519_key.pub
  - ~/.ssh/authorized_keys
  - ssh_known_hosts
  - gpg
  - gpg-agent
  - ~/.gnupg/
