# GitLab

## Install gitlab-ce over CentOS

### Install and configure the necessary dependencies

```bash
sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix
```

### Add the GitLab package repository and install the package

```bash
curl <https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh> | sudo bash
sudo EXTERNAL_URL="<https://gitlab.example.com>" yum install -y gitlab-ce
```

### Run Gitlab

```bash
sudo gitlab-ctl reconfigure
sudo gitlab-ctl start
```

**Note:** if you want to setup git over the DNS [_follow the link_](https://about.gitlab.com/install/#centos-7)

## Configuration

### reconfigure gitlab setting

```bash
sudo gitlab-ctl reconfigure
```

### Restart user password

```bash
gitlab-rake "gitlab:password:reset"
```

## Initiate gitlab runner

```bash
 gitlab-runner start
 gitlab-runner register
```
