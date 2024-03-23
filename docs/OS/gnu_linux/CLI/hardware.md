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
sudo df -h
sudo hdparm -I /dev/sda
check disk in 10 ways
```

## Check Monitor info

```bash
sudo apt-get install read-edid
sudo get-edid | parse-edid
```
