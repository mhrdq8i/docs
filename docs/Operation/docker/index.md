# Docker

## Commands

Add user to docker group

```bash
sudo usermod -aG <docker-grp> <user-name>

# Activate without logout
sudo exec newgrp <docker-grp>
```
