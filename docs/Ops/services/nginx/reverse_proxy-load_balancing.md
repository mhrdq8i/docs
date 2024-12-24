# Reverse Proxy & Load Balancing

## Prepare a Simple Environment

### Setup embedded light python HTTP server

#### Python 2.x

```bash
python -m SimpleHTTPServer 8000
```

#### Python 3.x

```bash
python3 -m http.server 8000
```

## Reverse Proxy

After the setup Environment

```nginx
worker_processes auto;

events {
  worker_connections 1024;
}

http {

  include mime.types;

    server {
        listen 8080;
        server_name 127.0.0.1;

        root /home/mehrdad/sb/lab/demo;

        location / {
            return 200 "Hello From Nginx\n";
        }

        location /python1 {
            add_header proxied proxied-by-nginx;
            proxy_pass "http://localhost:8011/";
        }

        location /python2 {
            proxy_set_header proxied proxied-by-nginx;
            proxy_pass "http://localhost:8012/";
        }

        location /python3 {
            proxy_pass "http://localhost:8013/";
        }
    }
}
```

## Load Balancer

```nginx
worker_processes auto;

events {
    worker_connections 1024;
}

http {

    include mime.types;

    upstream backend {
        # Load Balancing Algorithm
        # Round Robin (Default)
        # Hash
        # IP Hash
        # Least Connections

        ip_hash;
        server 127.0.0.1:8011;
        server 127.0.0.1:8012;
        server 127.0.0.1:8013;
    }

    server {
        listen 8088;

    location / {
        proxy_pass http://backend;
    }
  }
}
```

**Note:** [Nginx LoadBalancing Algorithms][NginxLoadBalancingAlgorithms]

[NginxLoadBalancingAlgorithms]: https://www.nginx.com/blog/choosing-nginx-plus-load-balancing-techniques/
