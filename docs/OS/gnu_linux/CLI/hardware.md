# Hardware

## Proces

```bash
top
htop
bpytop
ps -aux
```
### Find Zombie Process

```bash
ps aux | awk '{if ($8 == "Z") print $2}'                                                                                                                                                                      ```

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
sudo inxi --memory #nice
cat /proc/meminfo
smem
vmstat
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
## Get serial and Info

Get the hardware serial number and info

```bash
cd /sys/class/dmi/id/
cat /sys/class/dmi/id/board_serial
```
