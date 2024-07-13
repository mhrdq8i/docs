# Kubernetes in Picture

All kubernetes **resources**, **services**, **components** and etc... in picture

## Kubernetes Big Picture

### Cluster Schema

![k-cluster]

### ChestSheet

![k-cheatsheet]

### Commands

![k-commands]

### Road Map

![k-roadmap]

### Helm Chart

![k-helmchart]

### RollBack

![k-rbac]

### Traffic Routing

![k-trafficrouting]

## Controller Plan Components

### Master Node Components

![kube-components]

### Cloud Controller

![kc_cc_arch]

### Kube API-Server

![kube-api-server]

### Kube Scheduler

![kube-scheduler]

### Kube Control Manager

![kube-controller]
![kube-controller-components]

#### Node Controller

![node-controller]

#### Replication Controller

![replication-controller]

## Node Components

### Kubelet

![kubelet-1]
![kubelet-2]

### Kube Proxy

![kuber-proxy]

## Workloads

### Pods

![kube-api-pods]

### Static Pods

![static-pods-1]
![static-pods-2]

[static-pods-1]: ../../assets/kuber/kinpic/S04-static-pod-1.png
[static-pods-2]: ../../assets/kuber/kinpic/S04-static-pod-2.png

### Deployment

![deployment]

### Daemon Set

![S04-workload-daemonset-1]
![S04-workload-daemonset-2]
![S04-workload-daemonset-3]

## Services

![S03-service-01]
![S03-service-02]
![S03-service-03]

### Cluster IP

![service-cluster-ip-1]
![service-cluster-ip-2]

### NodePort

![service-node-port-1]
![service-node-port-2]
![service-node-port-3]
![service-node-port-4]

## Load Balancer

![service-load-balancer-1]

## DNS

![dns]

## Labels and Selector

![labels-selector-1]

### GroupBy App

![labels-selector-2]

### GroupBy Type

![labels-selector-3]

### Manifest Usage

![labels-selector-4]

## Rollout & Versioning

![rollout-versioning]

### Deployment Strategy

![rollout-versioning-deploymet-strategy]

### Upgrade

![deployment-update-strategy]

### Rollback

![deployment-rollback-strategy]

## T-Shoot and Debug

### K8S debug flowchart

![k-debug-flowchart]

<!-- links -->
[k-debug-flowchart]: ../../assets/kuber/cheatsheet/cs-k8s-debug-flowchart.png
[k-cheatsheet]: ../../assets/kuber/cheatsheet/cs-CheatSheet.jpg
[k-commands]: ../../assets/kuber/cheatsheet/cs-commands.jpg
[k-roadmap]: ../../assets/kuber/cheatsheet/cs-roadmap.gif
[k-cluster]: ../../assets/kuber/cheatsheet/cs-kcluster.jpeg
[k-helmchart]: ../../assets/kuber/cheatsheet/cs-HelmChart.jpg
[k-rbac]: ../../assets/kuber/cheatsheet/cs-krbacobj.png
[k-trafficrouting]: ../../assets/kuber/cheatsheet/cs-k8s-traffic_routing.gif

[kube-components]: ../../assets/kuber/kinpic/S02-kube-components.png
[kube-api-server]: ../../assets/kuber/kinpic/S02-kube-components-api-server.png
[kube-scheduler]: ../../assets/kuber/kinpic/S02-kube-components-schedular.png
[kube-controller]: ../../assets/kuber/kinpic/S02-kube-components-control-manager.png
[node-controller]: ../../assets/kuber/kinpic/S02-kube-components-node-controller.png
[replication-controller]: ../../assets/kuber/kinpic/S02-kube-components-replication-controller.png
[kube-controller-components]: ../../assets/kuber/kinpic/S02-kube-components-control-manager-components.png

[kubelet-1]: ../../assets/kuber/kinpic/S02-kube-components-kubelet-1.png
[kubelet-2]: ../../assets/kuber/kinpic/S02-kube-components-kubelet-2.png
[kuber-proxy]: ../../assets/kuber/kinpic/S02-kube-components-kube-proxy.png
[kc_cc_arch]: ../../assets/kuber/kinpic/S01-kuber-cloud-arch.png
[kube-api-pods]: ../../assets/kuber/kinpic/S02-kube-api-pods.png

[deployment]: ../../assets/kuber/kinpic/S03-deployment.png
[dns]: ../../assets/kuber/kinpic/S03-DNS.png

[S04-workload-daemonset-1]: ../../assets/kuber/kinpic/S04-workload-daemonset-01.png
[S04-workload-daemonset-2]: ../../assets/kuber/kinpic/S04-workload-daemonset-02.png
[S04-workload-daemonset-3]: ../../assets/kuber/kinpic/S04-workload-daemonset-03.png

[S03-service-01]: ../../assets/kuber/kinpic/S03-service-01.png
[S03-service-02]: ../../assets/kuber/kinpic/S03-service-02.jpg
[S03-service-03]: ../../assets/kuber/kinpic/S03-service-03.png

[service-cluster-ip-1]: ../../assets/kuber/kinpic/S03-service-cluster-ip-1.png
[service-cluster-ip-2]: ../../assets/kuber/kinpic/S03-service-cluster-ip-2.png

[service-node-port-1]: ../../assets/kuber/kinpic/S03-service-node-port-1.png
[service-node-port-2]: ../../assets/kuber/kinpic/S03-service-node-port-2.png
[service-node-port-3]: ../../assets/kuber/kinpic/S03-service-node-port-3.png
[service-node-port-4]: ../../assets/kuber/kinpic/S03-service-node-port-4.png

[service-load-balancer-1]: ../../assets/kuber/kinpic/S03-service-load-balancer-1.png

[labels-selector-1]: ../../assets/kuber/kinpic/S03-labels-selectors-1.png
[labels-selector-2]: ../../assets/kuber/kinpic/S03-labels-selectors-2.png
[labels-selector-3]: ../../assets/kuber/kinpic/S03-labels-selectors-3.png
[labels-selector-4]: ../../assets/kuber/kinpic/S03-labels-selectors-4.png

[rollout-versioning]: ../../assets/kuber/kinpic/S04-rollout-versioning.png
[rollout-versioning-deploymet-strategy]: ../../assets/kuber/kinpic/S04-rollout-versioning-deploymet-strategy.png
[deployment-update-strategy]: ../../assets/kuber/kinpic/S04-deployment-update-strategy.png
[deployment-rollback-strategy]: ../../assets/kuber/kinpic/S04-deployment-rollback-strategy.png
