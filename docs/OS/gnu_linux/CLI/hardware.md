# Hardware in Linux

## Check mainboard info

```bash
sudo dmidecode -t 2
```

## Check CPU info

```bash
lscpu
cat /proc/cpuinfo
sudo lshw -c cpu
```

## Check Memory info

```bash
free -m
lsmem
sudo dmidecode --type 17
sudo lshw -c memory
sudo inxi --memory
cat /proc/meminfo
```

## Check Disk info

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

## Check Monitor info

```bash
sudo apt-get install read-edid
sudo get-edid | parse-edid
```
