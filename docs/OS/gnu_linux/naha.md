# Things that I've learned from Naha

## GRUB Config

Update GRUB for CPU isolation and change memory page size

```bash
vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="default_hugepagesz=1G  hugepagesz=1G  hugepages=40  isolcpus=0-10,22-32  nohz_ful=0-10,22-32  rcu_nocbs=0-10,22-32"
update-grub
```

Show Isolated CPUs and Huge Memory Pages

```bash
cat /proc/meminfo | grep Huge
cat /sys/devices/system/cpu/isolated
```