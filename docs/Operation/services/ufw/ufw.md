# Ubuntu FireWall

## Commands

### Get Status

```bash
ufw status
ufw status numbered
```

### Allow

```bash
ufw allow \<port-number\>
```

### Delete

```bash
ufw delete \<rule-line-number\>
```

### Open/Close ICMP(ping)

edit `/etc/ufw/before.rules` file

```bash
# ok icmp codes for INPUT
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type time-exceeded -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type parameter-problem -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT/DROP
```
