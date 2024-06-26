# Commands and tips

### Check the squid proxy config file

> squid -k parse


### Accept iptables traffic

```bash
iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
iptables -I OUTPUT -p tcp --dport 3128 -j ACCEPT
```
