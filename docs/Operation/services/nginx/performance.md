# Nginx Performance Tune

## Add New Header (Cache-Control)

Add some header for special goal

```nginx
http {

  include mime.types;

  server {

    listen 80;
    server_name 127.0.0.1;

    root /tmp/nginx/site/demo;


    location / {
      try_files $uri $uri/ =404;
    }

    location ~* \.(css|js|jpg|png)$ {
        access_log off;
        add_header my_header "My Header";
        add_header Cache-Control public;
        add_header Pragma public;
        add_header Vary Accept-Encoding;
        expires 1M; # expire cache after 1 minute
    }

  }
}

```

## Compressed Responses with GZIP

### Request with extra header

```bash
curl -H "Accept-Encoding: gzip, deflate" <http://127.0.0.1/style.css>
```

**Note:** modern browser can support this feature, curl does not support in this example

### Check the file size

```bash
curl <http://127.0.0.1/style.css> > style.css
curl -H "Accept-Encoding: gzip, deflate" <http://127.0.0.1/style.css> > style.min.css
```

## gzip configuration directive

```nginx
worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

  gzip on;
  gzip_comp_level 3;

  gzip_types text/css;
  gzip_types text/javascript;

  server {

    listen 80;
    server_name 127.0.0.1

    root /sites/demo;

    location / {
      try_files $uri $uri/ =404;
    }

  }
}
```

## Fast CGI Cache

### Request to check

```bash
curl -I <http://127.0.0.1> X-Cache: HIT response header

curl -I <http://127.0.0.1?skipcache=1> X-Cache: BYPASS response header
```

```nginx
user www-data;

worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

  # Configure microcache (fastcgi)
  fastcgi_cache_path /tmp/nginx_cache levels=1:2 keys_zone=ZONE_1:100m inactive=60m;
  fastcgi_cache_key "$scheme$request_method$host$request_uri";
  add_header X-Cache $upstream_cache_status;

  server {

    listen 80;
    server_name 167.99.93.26;

    root /sites/demo;

    index index.php index.html;

    # Cache by default
    set $no_cache 0;

    # Check for cache bypass
    if ($arg_skipcache = 1) {
      set $no_cache 1;
    }

    location / {
      try_files $uri $uri/ =404;
    }

    location ~\.php$ {
      # Pass php requests to the php-fpm service (fastcgi)
      include fastcgi.conf;
      fastcgi_pass unix:/run/php/php7.1-fpm.sock;

      # Enable cache
      fastcgi_cache ZONE_1;
      fastcgi_cache_valid 200 60m;
      fastcgi_cache_bypass $no_cache;
      fastcgi_no_cache $no_cache;
    }
  }
}
```

## HTTP2

### HTTP2 Main Feature

- Binary Protocol
- Compressed Headers
- Persistent Connections
- Multiplex Streaming
- Server Push

### Install HTTP2 over nginx

### Install nginx via package manager

Debian

```bash
 sudo apt install nginx
```

Redhat base

```bash
sudo yum install nginx
```

### [Build from Source][bldhttp2frmsrc]

add the following instruction and also check the dependency module

```bash
--with_http_ssl_module
--with_http_v2_module

make
make install
```

### Active _SSL_ for _HTTP2_

```bash
- Generate 'self-sign' and 'private-key'
- mkdir -p /etc/nginx/ssl
- sudo openssl req -x509 -days 365 -nodes -newkey rsa:2048 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt
- add 'listen' 443 ssl http2; 'ssl_certificate', 'ssl_certificate_key' to 'nginx.conf'
```

### Add _SSL_ directive to nginx.conf

```nginx
worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

  server {

    listen 443 ssl http2;
    server_name 127.0.0.1;

    root /sites/demo;

    ssl_certificate /etc/nginx/ssl/self.crt;
    ssl_certificate_key /etc/nginx/ssl/self.key;

    location / {
      try_files $uri $uri/ =404;
    }
  }
}
```

## Server Push

**Describe:** push the resources `/style.css` and `/thumb.png` to the `index.html` request (all together into the one request)

```nginx
worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

  server {

    listen 443 ssl http2;
    server_name 127.0.01;

    root /tmp/nginx/site/demo;

    ssl_certificate /etc/nginx/ssl/self.crt;
    ssl_certificate_key /etc/nginx/ssl/self.key;

    location = /index.html {
      http2_push /style.css;
      http2_push /thumb.png;
    }

    location / {
      try_files $uri $uri/ =404;
    }

  }

}
```

**Tips:** test via [nghttp2] tool

```bash
sudo nghttp -nysa <https://127.0.0.1>
```

<!-- links -->
[bldhttp2frmsrc]: https://trello.com/c/uLe6hcU4/6-installation
[nghttp2]: https://github.com/nghttp2/nghttp2
