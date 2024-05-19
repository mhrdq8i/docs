# Hardware

## Proces

```bash
top
htop
bpytop
ps -aux
```

## Mainboard

```bash
sudo dmidecode -t 2
```

## CPU

```bash
lscpu
cat /proc/cpuinfo
sudo lshw -c cpu
```

## Memory

Check Memory & Swap

```bash
free -hw
lsmem
sudo dmidecode --type 17
sudo lshw -c memory
sudo inxi --memory
cat /proc/meminfo
```

## Disk

### Offline

```bash
sudo lsblk -f

sudo df -h
sudo df -H /dev/sda1

df -H /dev/sda1 # disk usage

sudo hdparm -I /dev/sda

sudo lshw -class disk -class storage
sudo lshw -short -C disk

sudo hwinfo --disk
```
### Online

```bash
dstat
```

## Monitor

```bash
sudo apt-get install read-edid
sudo get-edid | parse-edid
```
