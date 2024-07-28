# Ansible

## Installation

### Ubuntu

Install ansible on ubuntu servers

```bash
sudo apt update --yes
sudo apt install --yes software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install --yes ansible
```

### Debian

Signing key

```bash
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
```

Add an entry to apt’s sources pointing to the PPA

```bash
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
```

Update and install from apt repo

```bash
sudo apt update && sudo apt install ansible
```

### Arch Linux

To install the full ansible package run

```bash
sudo pacman -S ansible
```

To install the minimal ansible-core package run

```bash
sudo pacman -S ansible-core
```

### Test for Correct Installation

PingPong with ansible

```bash
ansible localhost -m ping -u root
```

Show file systems

```bash
ansible localhost -a "df -h" -u root
```

Putting arguments into your command

```bash
ansible localhost -m apt -a "name=vim state=latest" -u root
```

Install vim with ansible

```bash
ansible localhost -m apt -a "name=vim state=latest" -u root --become
```

We can specify multiple hosts by separating them with colons

```bash
ansible server1:server2 -m ping -u root
```

## Best Practice Ansible Project Structre

```bash
.
├── inventory
│   └── hosts
├── prjct-name.yml
└── roles
    └── prjct-name
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        ├── templates
        └── vars
            └── main.yml
```
