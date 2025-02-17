You could manually install all Kubernetes components onto your compute nodes yourself, but this can be complex, error-prone, and time-consuming. Simpler, more scalable, and robust solutions are available!

Automation tools such as Kubespray make deploying a Kubernetes cluster almost effortless. Kubespray is an open-source tool that allows for the automated deployment of Kubernetes clusters across computing resources, such as virtual machines. Built to be configurable, fast, and lightweight, Kubespray meets most needs.

## Quick Start

Download the Kubespray GitHub repository and check out the latest version. At the time of writing, we are using release `2.25.0`:

```shell linenums="1"
git clone https://github.com/kubernetes-sigs/kubespray.git
cd Kubespray
git checkout release-2.25
```

You can also directly download the release archive from the following link:

- https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v2.25.0.tar.gz

You also need to install the following Python packages with pip, and for this release we need Ansible version `9.11.0`:

```
ansible==9.11.0
ruamel.yaml
netaddr
jmespath
```

Run the following steps to initialize the config files:

```shell linenums="1"
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
```

**Note:** In small clusters, there is no need to setup `NodeLocal DNS`. So, we disable that in the file `inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml`:

```yaml
enable_nodelocaldns: false
```

**Note:** For connecting to cluster from the host that runs Ansible, you could edit the above config file:

```yaml
# Make a copy of kubeconfig on the host that runs Ansible in {{ inventory_dir }}/artifacts
kubeconfig_localhost: true
# Use ansible_host as external api ip when copying over kubeconfig.
# kubeconfig_localhost_ansible_host: false
# Download kubectl onto the host that runs Ansible in {{ bin_dir }}
kubectl_localhost: true
```

After deployment of Kubespray, the required files will be generated in the path `inventory/mycluster/artifacts`. You must do some tasks to connect the Ansible host to the cluster:

1. Make `kubectl` executable and copy to `/usr/local/bin`.
2. Copy `admin.conf` to `~/.kube/config` and check its permissions for your user.

Finally deploy Kubespray with Ansible:

```shell linenums="1"
# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

## Clean Up the Cluster

```shell linenums="1"
# Clean up old Kubernetes cluster with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example cleaning up SSL keys in /etc/,
# uninstalling old packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
# And be mind it will remove the current kubernetes cluster (if it's running)!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root reset.yml
```

## Adding a Worker Node

1. Add new node to the inventory

```yaml linenums="1"
...
 new-node:
      ansible_host: new-node
      access_ip: <172.16.x.y>
      ip: <172.16.x.y>
...
 kube_node:
      hosts:
        new-node:
...
```

2. Run scale.yml

You can use `--limit=NODE_NAME` to limit Kubespray to avoid disturbing other nodes in the cluster.

```shell
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root scale.yml --limit=<new-node>
```

Before using `--limit` run playbook `facts.yml` without the limit to refresh facts cache for all nodes.

```shell
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root playbooks/facts.yml
```

For more information refer to the following link:

- https://github.com/kubernetes-sigs/kubespray/blob/master/docs/operations/nodes.md

## Sample hosts.yaml

```yaml linenums="1"
all:
  hosts:
    master:
      ansible_host: master
      ip: 192.168.197.12
      access_ip: 192.168.197.12
    grafana:
      ansible_host: grafana
      ip: 192.168.197.13
      access_ip: 192.168.197.13
    collector:
      ansible_host: 192.168.197.14
      ip: 192.168.197.14
      access_ip: 192.168.197.14
    tm1:
      ansible_host: 192.168.197.15
      ip: 192.168.197.15
      access_ip: 192.168.197.15
  children:
    kube_control_plane:
      hosts:
        master:
    kube_node:
      hosts:
        master:
        grafana:
        collector:
        tm1:
    etcd:
      hosts:
        master:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
  vars:
    ansible_user: nahanet
    ansible_ssh_private_key_file: ~/.ssh/id_rsa
    ansible_become: true
    ansible_become_user: root
    ansible_become_pass: nahanet
```

**Note:** The `ip` and `access_ip` hosts variables are mandatory for deployment of Kubespray and must be defined.

## Deployment from a Public Mirror

The public mirror is useful to make the public resources download quickly in some areas of the world (such as China).
If you want to download quickly in China, the configuration can be like:

```shell linenums="1"
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"

files_repo: "https://files.m.daocloud.io"
```

You can follow the full steps to use the kubesray with mirror. for example:

```shell linenums="1"
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Use the download mirror
cp inventory/mycluster/group_vars/all/offline.yml inventory/mycluster/group_vars/all/mirror.yml
sed -i -E '/# .*\{\{ files_repo/s/^# //g' inventory/mycluster/group_vars/all/mirror.yml
tee -a inventory/mycluster/group_vars/all/mirror.yml <<EOF
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"
files_repo: "https://files.m.daocloud.io"
EOF

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

## Offline Deployment

In case your servers don't have access to the internet directly (for example when deploying on premises with security constraints), you need to get the required artifacts from another environment where has access to the internet.

For more information refer to the following link:

- https://kubespray.io/#/docs/operations/offline-environment

You can get artifact lists with generate_list.sh script. In addition, you can find some tools for offline deployment under contrib/offline.

For more information refer to the following link:

- https://github.com/kubernetes-sigs/kubespray/tree/master/contrib/offline

We used a Nexus service and the following `inventory/mycluster/group_vars/all/mirror.yml`:

```yaml linenums="1"
---
## Global Offline settings
### Private Container Image Registry
# registry_host: "myprivateregisry.com"
# files_repo: "http://myprivatehttpd"
### If using CentOS, RedHat, AlmaLinux or Fedora
# yum_repo: "http://myinternalyumrepo"
### If using Debian
# debian_repo: "http://myinternaldebianrepo"
### If using Ubuntu
# ubuntu_repo: "http://myinternalubunturepo"

## Container Registry overrides
kube_image_repo: "{{ registry_host }}"
gcr_image_repo: "{{ registry_host }}"
github_image_repo: "{{ registry_host }}"
docker_image_repo: "{{ registry_host }}"
quay_image_repo: "{{ registry_host }}"

## Kubernetes components
kubeadm_download_url: "{{ files_repo }}/dl.k8s.io/release/{{ kubeadm_version }}/bin/linux/{{ image_arch }}/kubeadm"
kubectl_download_url: "{{ files_repo }}/dl.k8s.io/release/{{ kube_version }}/bin/linux/{{ image_arch }}/kubectl"
kubelet_download_url: "{{ files_repo }}/dl.k8s.io/release/{{ kube_version }}/bin/linux/{{ image_arch }}/kubelet"


## Two options - Override entire repository or override only a single binary.

## [Optional] 1 - Override entire binary repository
# github_url: "https://my_github_proxy"
# dl_k8s_io_url: "https://my_dl_k8s_io_proxy"
# storage_googleapis_url: "https://my_storage_googleapi_proxy"
# get_helm_url: "https://my_helm_sh_proxy"

## [Optional] 2 - Override a specific binary
## CNI Plugins
cni_download_url: "{{ files_repo }}/github.com/containernetworking/plugins/releases/download/{{ cni_version }}/cni-plugins-linux-{{ image_arch }}-{{ cni_version }}.tgz"

## cri-tools
crictl_download_url: "{{ files_repo }}/github.com/kubernetes-sigs/cri-tools/releases/download/{{ crictl_version }}/crictl-{{ crictl_version }}-{{ ansible_system | lower }}-{{ image_arch }}.tar.gz"

## [Optional] etcd: only if you use etcd_deployment=host
etcd_download_url: "{{ files_repo }}/github.com/etcd-io/etcd/releases/download/{{ etcd_version }}/etcd-{{ etcd_version }}-linux-{{ image_arch }}.tar.gz"

# [Optional] Calico: If using Calico network plugin
calicoctl_download_url: "{{ files_repo }}/github.com/projectcalico/calico/releases/download/{{ calico_ctl_version }}/calicoctl-linux-{{ image_arch }}"
# [Optional] Calico with kdd: If using Calico network plugin with kdd datastore
calico_crds_download_url: "{{ files_repo }}/github.com/projectcalico/calico/archive/{{ calico_version }}.tar.gz"

# [Optional] Cilium: If using Cilium network plugin
ciliumcli_download_url: "{{ files_repo }}/github.com/cilium/cilium-cli/releases/download/{{ cilium_cli_version }}/cilium-linux-{{ image_arch }}.tar.gz"

# [Optional] helm: only if you set helm_enabled: true
helm_download_url: "{{ files_repo }}/get.helm.sh/helm-{{ helm_version }}-linux-{{ image_arch }}.tar.gz"

# [Optional] crun: only if you set crun_enabled: true
crun_download_url: "{{ files_repo }}/github.com/containers/crun/releases/download/{{ crun_version }}/crun-{{ crun_version }}-linux-{{ image_arch }}"

# [Optional] kata: only if you set kata_containers_enabled: true
kata_containers_download_url: "{{ files_repo }}/github.com/kata-containers/kata-containers/releases/download/{{ kata_containers_version }}/kata-static-{{ kata_containers_version }}-{{ ansible_architecture }}.tar.xz"

# [Optional] cri-dockerd: only if you set container_manager: docker
cri_dockerd_download_url: "{{ files_repo }}/github.com/Mirantis/cri-dockerd/releases/download/v{{ cri_dockerd_version }}/cri-dockerd-{{ cri_dockerd_version }}.{{ image_arch }}.tgz"

# [Optional] runc: if you set container_manager to containerd or crio
runc_download_url: "{{ files_repo }}/github.com/opencontainers/runc/releases/download/{{ runc_version }}/runc.{{ image_arch }}"

# [Optional] cri-o: only if you set container_manager: crio
# crio_download_base: "download.opensuse.org/repositories/devel:kubic:libcontainers:stable"
# crio_download_crio: "http://{{ crio_download_base }}:/cri-o:/"
crio_download_url: "{{ files_repo }}/storage.googleapis.com/cri-o/artifacts/cri-o.{{ image_arch }}.{{ crio_version }}.tar.gz"
skopeo_download_url: "{{ files_repo }}/github.com/lework/skopeo-binary/releases/download/{{ skopeo_version }}/skopeo-linux-{{ image_arch }}"

# [Optional] containerd: only if you set container_runtime: containerd
containerd_download_url: "{{ files_repo }}/github.com/containerd/containerd/releases/download/v{{ containerd_version }}/containerd-{{ containerd_version }}-linux-{{ image_arch }}.tar.gz"
nerdctl_download_url: "{{ files_repo }}/github.com/containerd/nerdctl/releases/download/v{{ nerdctl_version }}/nerdctl-{{ nerdctl_version }}-{{ ansible_system | lower }}-{{ image_arch }}.tar.gz"

# [Optional] runsc,containerd-shim-runsc: only if you set gvisor_enabled: true
gvisor_runsc_download_url: "{{ files_repo }}/storage.googleapis.com/gvisor/releases/release/{{ gvisor_version }}/{{ ansible_architecture }}/runsc"
gvisor_containerd_shim_runsc_download_url: "{{ files_repo }}/storage.googleapis.com/gvisor/releases/release/{{ gvisor_version }}/{{ ansible_architecture }}/containerd-shim-runsc-v1"

# [Optional] Krew: only if you set krew_enabled: true
krew_download_url: "{{ files_repo }}/github.com/kubernetes-sigs/krew/releases/download/{{ krew_version }}/krew-{{ host_os }}_{{ image_arch }}.tar.gz"

## CentOS/Redhat/AlmaLinux
### For EL7, base and extras repo must be available, for EL8, baseos and appstream
### By default we enable those repo automatically
# rhel_enable_repos: false
### Docker / Containerd
# docker_rh_repo_base_url: "{{ yum_repo }}/docker-ce/$releasever/$basearch"
# docker_rh_repo_gpgkey: "{{ yum_repo }}/docker-ce/gpg"

## Fedora
### Docker
# docker_fedora_repo_base_url: "{{ yum_repo }}/docker-ce/{{ ansible_distribution_major_version }}/{{ ansible_architecture }}"
# docker_fedora_repo_gpgkey: "{{ yum_repo }}/docker-ce/gpg"
### Containerd
# containerd_fedora_repo_base_url: "{{ yum_repo }}/containerd"
# containerd_fedora_repo_gpgkey: "{{ yum_repo }}/docker-ce/gpg"

## Debian
### Docker
# docker_debian_repo_base_url: "{{ debian_repo }}/docker-ce"
# docker_debian_repo_gpgkey: "{{ debian_repo }}/docker-ce/gpg"
### Containerd
# containerd_debian_repo_base_url: "{{ debian_repo }}/containerd"
# containerd_debian_repo_gpgkey: "{{ debian_repo }}/containerd/gpg"
# containerd_debian_repo_repokey: 'YOURREPOKEY'

## Ubuntu
### Docker
# docker_ubuntu_repo_base_url: "{{ ubuntu_repo }}/docker-ce"
# docker_ubuntu_repo_gpgkey: "{{ ubuntu_repo }}/docker-ce/gpg"
### Containerd
# containerd_ubuntu_repo_base_url: "{{ ubuntu_repo }}/containerd"
# containerd_ubuntu_repo_gpgkey: "{{ ubuntu_repo }}/containerd/gpg"
# containerd_ubuntu_repo_repokey: 'YOURREPOKEY'

registry_host: "nexus.inside.nahanet.ir:8082"
files_repo: "https://nexus.inside.nahanet.ir/repository/file"
```

To set up the Nexus offline repository, first, go to the `contrib/offline` path in the project and then use the following command to generate the list of required images:

```shell
./generate_list.sh
```

By executing this command, the `temp` directory will be generated as follows:

```shell
./generate_list.sh
tree temp
temp
├── files.list
├── files.list.template
├── images.list
└── images.list.template
0 directories, 5 files
```

Then, using the following command, the required images are pulled and stored as tar archive files in a file called `container-images.tar.gz`. It should be noted that these scripts are executed through one of `podman`, `nerdctl`, and `docker` tools, depending on which one is installed.

```shell
IMAGES_FROM_FILE=temp/images.list ./manage-offline-container-images.sh create
```

Also, a Docker repository should be created on Nexus, for example on port `8082`. In addition, you must enable the `Docker Bearer Token Realm` in Nexus `Security->Realms` tab and also
enable the `Allow anonymous docker pull` option.

For more information refer to the following link:

- https://community.sonatype.com/t/docker-login-401-unauthorized/1345/6

In addition, the following settings should be added to the `/etc/docker/daemon.json` file:

```json
{ "insecure-registries":["https://nexus.inside.nahanet.ir:8082"] }
```

Then use the following commands to apply these settings and finally log in to the desired repository:

```shell linenums="1"
sudo systemctl daemon-reload
sudo service docker restart
sudo docker login nexus.inside.nahanet.ir:8082
```

Next, by running the following command, the images will be pushed into the Nexus repository:

```shell
DESTINATION_REGISTRY=nexus.inside.nahanet.ir:8082 ./manage-offline-container-images.sh register
```

**Note:** To use the Nexus service for Kubespray deployment, it needs to be set up on the HTTPS protocol. Nginx service is used for this.

We used the following `docker-compose.yaml`:

```yaml linenums="1"
services:
  nexus:
    image: sonatype/nexus3:3.70.1
    container_name: nexus
    hostname: nexus
    user: root
    volumes:
      - nexus-data:/nexus-data
    restart: always

  nginx:
    image: nginx
    container_name: nginx
    hostname: nginx
    ports:
      - 80:80
      - 443:443
      - 8082:8082
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/sites:/etc/nginx/sites
      - ./nginx/ssl:/etc/nginx/ssl
      - ./nginx/log:/var/log/nginx
    restart: always

volumes:
  nexus-data:
```

Also, the Nginx configuration file is defined as follows:

```linenums="1"
# HTTP Server Redirects to HTTPS
server {
    listen 80;
    server_name nexus.inside.nahanet.ir;

    return 301 https://$host$request_uri;
}

# HTTPS Server
server {
    listen 443 ssl;
    server_name nexus.inside.nahanet.ir;

    location / {
        proxy_pass http://nexus:8081;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Nginx-Proxy true;

        proxy_redirect off;
    }
}

# Docker Host HTTPS Server
server {
    listen 8082 ssl;
    server_name nexus.inside.nahanet.ir;

    location / {
        proxy_pass http://nexus:8082;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Nginx-Proxy true;

        proxy_redirect off;
    }
}
```

In summary, the following are defined in the Nexus service:

1. A raw repository called `files` which can be accessed through `https://nexus.inside.nahanet.ir/repository/files`.
2. A Docker repository that can be accessed through the address `nexus.inside.nahanet.ir:8082`.
3. An apt proxy that can be accessed via `https://nexus.inside.nahanet.ir/repository/apt`.

**Note:** The apt proxy is filled with required files during Kubespray deployment. It can later become a repository.
