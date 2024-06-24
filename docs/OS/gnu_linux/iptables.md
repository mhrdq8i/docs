# IP-Tables

## Configure

### Save and Restore

save all the current rules

```bah
sudo iptables-save > ipt.rules
```

restore the saved rules

```bash
sudo iptables-restore ipt.rules
```

### Persiste iptables rules

```bash
sudo apt install iptables-persistent
```

make sure services are enabled on Debian or Ubuntu using the systemctl

```bash
sudo systemctl is-enabled netfilter-persistent.service
```

If not enable it

```bash
sudo systemctl enable netfilter-persistent.service
```

get status

```bash
sudo systemctl status netfilter-persistent.service
```

## Tables

### NAT

forward SSH port from proxy machine

```bash
iptables -t nat -A PREROUTING  -d 172.16.2.20/32 -i vmbr0 -p tcp -m tcp --dport 22150 -j DNAT --to-destination 192.168.1.150:22
```

masquerade "SNAT" packages

```bash
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o vmbr0 -j MASQUERADE
```
