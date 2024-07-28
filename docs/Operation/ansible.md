# Ansible

## Installation

### Ubuntu

Install ansible on ubuntu servers

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
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

```bash
ansible all -m ping -u root
```
