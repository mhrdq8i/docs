# Concept

## Install nginx via package manager

### debian base

> sudo apt install nginx

### redhat base

> sudo yum install nginx

### build from source

Download Nginx source code from [**this page**](http://nginx.org/en/download.html) extract tar file

```bash
./configure nginx with this parameters:
--sbin-path=/usr/bin/nginx nginx executable binary file path
--conf-path=/etc/nginx/nginx.conf nginx configuration file path
--error-log-path=/var/log/nginx/error.log nginx error log path
---http-log-path=/var/log/nginx/access.log nginx access log path
---with-pcre regex module for nginx
--pid-path=/var/run/nginx.pid nginx running process location
--with-http_ssl_module nginx 3rd party module
make
make install
```

> Save this file as `/lib/systemd/system/nginx.service` to create `systemctl unit`

```bash
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

[**get more help**](https://www.nginx.com/nginx-wiki/build/dirhtml/start/topics/examples/initscripts/)

## [Official Site](#official-site)

> [**_nginx.org_**](http://nginx.org/) is nginx **documentation**
> but
> [**_nginx.com_**](https://www.nginx.com) is nginx **production review** page

## Useful Commands

```bash
nginx -t (test all nginx config files)
nginx -c /etc/nginx/nginx.conf -t (test nginx.conf)
```

## Some useful Documentation & Reference link

- [Hub Nginx Docs](https://github.com/fcambus/nginx-resources)
- [Official Documentation](https://docs.nginx.com/)
- [nginx.org docs](http://nginx.org/en/docs/)
- [Nginx Best Practice Configuration](https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/)
- [DigitalOcean Tutorial](https://www.digitalocean.com/community/tutorials?q=nginx)
- [Nginx for Wordpress](https://wordpress.org/support/article/nginx/)

## Nginx GEO IP

### build from source

- add `--with-http_geoip_module` to configure
- fix error dependency with `apt install libgeoip-dev`
- make
- make install

download `GeoIP` and `GeoLiteCity` package from [**maxmind**](https://dev.maxmind.com/)

## Video Streaming

### build from source

- add `--with-http_mp4_module` to configure
- make
- make install

```nginx
worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

  server {
    listen 80;

    location ~\.mp4$ {
      root /tmp/videos/;
      mp4;
      mp4_buffer_size 512K;
      mp4_max_buffer_size 10M;
    }

  }
}
```
