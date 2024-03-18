# Ubuntu FireWall

## commands

- ufw status
- ufw status numbered 
- ufw allow \<port-number\>
- ufw delete \<rule-line-number\>
  
## close/open ICMP(ping) status

- edit `/etc/ufw/before.rules` file

```bash
# ok icmp codes for INPUT
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type time-exceeded -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type parameter-problem -j ACCEPT/DROP
-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT/DROP
```
