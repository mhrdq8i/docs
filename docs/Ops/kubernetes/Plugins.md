# Kubernetes Plugins

## Kompose

Kompose is a conversion tool for Docker Compose to container orchestrators such as Kubernetes (or OpenShift).

### Installation

```bash
curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
```

If you want to install Kompose on the other platform visit [this link]

### Usage

Convert docker-compose yaml file into the K8S resource manifest

```bash
kompose convert -f compose.yaml
```

Apply resource

```bash
kubectl apply -f .
```

Get the list of pods that created by Kompose

```bash
kubectl get po
```

## Krew

**[Krew]** is the plugin manager for kubectl command-line tool.

### Installation

Copy and execute this code into your shell

#### macOS/Linux Bash/ZSH

```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

### Documentation

Krew full documentation **[here]**

## Graph

Install with Krew

### Installation

```bash
kubectl krew install graph
```

### Usage

Draw SVG of your cluster resource based on 'namespace' name

```bash
kubectl graph pods --field-selector status.phase=Running -n kube-system | dot -T svg -o pods.svg
```

Change your namespace name and try it again.

<!-- links -->
[Krew]: https://krew.sigs.k8s.io
[here]: https://krew.sigs.k8s.io/docs/
[this link]: https://kompose.io/installation/
