# Docker

## Commands

### docker privilege

Add user to docker group

```bash
sudo usermod -aG <docker-grp> <user-name>

# Activate without logout
sudo exec newgrp <docker-grp>
```

Add insecure docker registry to bypass TLS error

```bash
sudo vim /etc/docker/daemon.
{
  "insecure-registries":
  [
      "<private-registry-domain:port_number>",
  ]
}

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl status docker.service
```

### docker repository

Get a list of local registry

```bash
curl localhost:5000/v2/_catalog
```

### docker images

Output filter over columns

```bash
docker images --format '{{.Repository}}:{{.Tag}}'
```
