# Ubuntu

## Config netplan (network)

Open netplan file under the `/ect/netplan/01-netcfg.yaml` path

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
   enp0s3:
     dhcp4: no
     addresses:
     - 192.168.1.100/24
     routes:
     - to: default
       via: 192.168.1.1
     nameservers:
      addresses:
      - 192.168.1.1
      - 8.8.8.8
```

**Note:** if your face to this warning "WARNING:root:Cannot call Open vSwitch: ovsdb-server.service is not running" install openvswitch-switch package

```bash
sudo apt install -y openvswitch-switch
```

## Get the list of installed packages

```bash
dpkg -l | grep kube
dpkg -l ubuntu-desktop
dpkg -l ubuntu-server
```

## Set APT Proxy

### via squid

```bash
cat << EOF | sudo tee /etc/apt/apt.conf.d/21proxy
Acquire::http::proxy::download.docker.com "http://user:pass@proxy.example.com:3128/";
Acquire::http::proxy::apt.kubernetes.io "http://user:pass@proxy.example.com:3128/";
EOF
```

### via socks

```bash
cat << EOF | sudo tee /etc/apt/apt.conf.d/21proxy
Acquire::http::proxy "socks5h://localhost:9090";
EOF
```

## Show and Edit gnome shortkeys

Install gnome related package

```bash
sudo apt install gnome-tweaks
```

Get the list of shortkeys

```bash
gsettings list-recursively org.gnome.desktop.wm.keybindings
or
gsettings list-recursively org.gnome.desktop.wm.keybindings | grep switch-to-workspace
```

Replace the value for the specific key

```bash
gsettings set org.gnome.desktop.wm.keybindings key-name "[pattern]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right  "['<Super>Page_Down', '<Super><Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left   "['<Super>Page_Up', '<Super><Alt>Left']"
```

## snap

### Set an alias for snap's apps

```bash
sudo snap alias [snap-app] [alias-for-snap-app]
```
