# HAProxy

## Installation

Install HAProxy via vim plugin

```bash
sudo apt update -y
sudo apt install -y haproxy vim-haproxy
```

## Configuration

### A simiple HAProxy config file

write the below config to _/etc/haproxy/haproxy.cfg_

```bash
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

        setenv int_ip_addr 45.92.94.213 # set internal-IP variable
        setenv ext_ip_addr 65.108.92.60 # set external-IP variable
        setenv PSLN extsrv


defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http



listen mehrdad_hetzner_admin_panel
        bind "$int_ip_addr":80
        server "$PSLN" "$ext_ip_addr":47917 check

listen mehrdad_hetzner
        bind "$int_ip_addr":27523
        server "$PSLN" "$ext_ip_addr":27523 check
```

validation config file

```bash
haproxy -C /etc/haproxy/haproxy.cfg
```

Restart haproxy to apply new config

```bash
sudo systemctl restart haproxy
sudo systemctl status haproxy
```
