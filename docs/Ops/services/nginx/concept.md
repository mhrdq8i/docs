# Concept

## Install nginx via package manager

### Debian

```bash
sudo apt install nginx
```

### Redhat

```bash
sudo yum install nginx
```

### Build From Source

Download Nginx source code from [this page][dlnginx] then extract tar file, like this

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

Save this file as `/lib/systemd/system/nginx.service` to create `systemctl unit`

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

[**get more help**][nginxgermorehelp]

## Nginx Official Site

- [**_nginx.org_**][nginxorg] is nginx **documentation**
- [**_nginx.com_**][nginxcom] is nginx **production review** page

## Check Nginx Config File

```bash
nginx -t (test all nginx config files)
nginx -c /etc/nginx/nginx.conf -t (test nginx.conf)
```

## Documentation & Reference

- [Hub Nginx Docs][HubNginxDocs] Awesome
- [Official Documentation][OfficialDocumentation]
- [nginx.org docs][nginxorgdocs]
- [Nginx Best Practice Configuration][NginxBestPracticeConfiguration]
- [DigitalOcean Tutorial][DigitalOceanTutorial]
- [Nginx for Wordpress][NginxForWordpress]

## Nginx GEO IP

### Build GEO IP From Source

```bash
add `--with-http_geoip_module` to configure
fix error dependency with `apt install libgeoip-dev`
make
make install
```

download `GeoIP` and `GeoLiteCity` package from [maxmind]

## Video Streaming

### Build from Source

```bash
add `--with-http_mp4_module` to configure
make
make install
```

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
<!-- links -->
[dlnginx]: http://nginx.org/en/download.html
[nginxgermorehelp]: https://www.nginx.com/nginx-wiki/build/dirhtml/start/topics/examples/initscripts/
[nginxorg]: http://nginx.org/
[nginxcom]: https://www.nginx.com
[HubNginxDocs]: https://github.com/fcambus/nginx-resources
[OfficialDocumentation]: https://docs.nginx.com
[nginxorgdocs]: http://nginx.org/en/docs/
[NginxBestPracticeConfiguration]: https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls
[DigitalOceanTutorial]: https://www.digitalocean.com/community/tutorials?q=nginx
[NginxForWordpress]: https://wordpress.org/support/article/nginx
[maxmind]: https://dev.maxmind.com/
