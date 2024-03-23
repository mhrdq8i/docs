# # Stack.Push(GitLab Doc\)

## [Install gitlab-ce over CentOS](#install-gitlab-ce-over-centos)

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

> - curl <https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh> | sudo bash
> - sudo EXTERNAL_URL="<https://gitlab.example.com>" yum install -y gitlab-ce

### Run Gitlab

```bash
sudo gitlab-ctl reconfigure
sudo gitlab-ctl start
```

**Note:** if you want to setup git over the DNS [_follow the link_](https://about.gitlab.com/install/#centos-7)

## [Configuration](#configuration)

### reconfigure gitlab setting

```bash
sudo gitlab-ctl reconfigure
```

### Restart user password

```bash
gitlab-rake "gitlab:password:reset"
```

## [Install & Configure via ansible playbook](#install--configure-via-ansible-playbook)

### Click [here](https://gitlab.com/mehrdad-companies/spara/iac/-/tree/master) to see gitlab ansible playbook

## [Initiate gitlab runner](#initiate-gitlab-runner)

```bash
 gitlab-runner start
 gitlab-runner register
```
