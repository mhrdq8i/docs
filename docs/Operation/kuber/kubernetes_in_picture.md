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

## Configs

### ENV variables

![pod-cntnr-envs]

### Pod Config Methods

![pod-config-methods]

## Security

### TLS Certificates

![apiserver-base-tls]

### Certification Types

![certs-types]

### Client Certificates

![client-certificates]

### All Services Certificates

![all-service-certs]

### ETCD Peers Cluster Certificates

![etcd-peers-certs]
![etcd-peers-certs-2]

### KubeConfig File

![kube-config-file]

## APIs

### api (core group)

![k8s-apis-api]

### apis (named group)

![k8s-apis-apis]

## Authorization

### RBAC Authorization

![rbac]

### Webhook Authorization

![webhook]

### RollBinding

Relation between **RoleBinding**, **User** and **Namespace**

![roll-binding-ns]

## Storage

### CSI vs CNI vs CRI

![csi-cni-cri]

### Mount Volumes

![mount-volumes]

## PV & PVC

![pv-pvc-pod]

## Storage Class

### Static Provisioning

![storage-class-static-provisioning]

### Dynamic Provisioning

![storage-class-dynamic-provisioning]

## Network Policy

### Ingress & Egress Direction

![ingress-egress-direction]

### Pods Default Connections

![pod-default-con]

### Close Ingress or Egress Traffic

![close-ingress-egress]

## Ingress Service

### Ingress Schema

![ingress-01]

### Ingress Schema with External LoadBalancer

![ingress-02]

### Ingress Types

![ingress-03]

## T-Shoot and Debug

### Diagnostic Probes

![diagnostic-probes-1]

### Diagnostic Probes Flow

![diagnostic-probes-2]

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

[pod-cntnr-envs]: ../../assets/kuber/kinpic/S05-environment-variables.png
[pod-config-methods]: ../../assets/kuber/kinpic/S05-config-map-methods.png
[diagnostic-probes-1]: ../../assets/kuber/kinpic/S05-k8s-probes-1.png
[diagnostic-probes-2]: ../../assets/kuber/kinpic/S05-k8s-probes-2.png

[apiserver-base-tls]: ../../assets/kuber/kinpic/S07-security-tls-certs.png
[certs-types]: ../../assets/kuber/kinpic/S07-security-cert-types.png
[all-service-certs]: ../../assets/kuber/kinpic/S07-security-services-certs.png
[client-certificates]: ../../assets/kuber/kinpic/S07-security-client-certs.png
[etcd-peers-certs]: ../../assets/kuber/kinpic/S07-etcd-peers-cluster.png
[etcd-peers-certs-2]: ../../assets/kuber/kinpic/S07-security-etcd-peers-certs.png
[kube-config-file]: ../../assets/kuber/kinpic/S07-security-kube-config-file.png

[k8s-apis-api]: ../../assets/kuber/kinpic/S08-security-APIs-api.png
[k8s-apis-apis]: ../../assets/kuber/kinpic/S08-security-APIs-apis.png

[rbac]: ../../assets/kuber/kinpic/S08-security-authorization-rbac.png
[webhook]: ../../assets/kuber/kinpic/S08-security-authorization-webhook.png
[roll-binding-ns]: ../../assets/kuber/kinpic/S08-security-authorization-rollbinding.png

[ingress-egress-direction]: ../../assets/kuber/kinpic/S08-security-network-policy-1.png
[pod-default-con]: ../../assets/kuber/kinpic/S08-security-network-policy-2.png
[close-ingress-egress]: ../../assets/kuber/kinpic/S08-security-network-policy-3.png

[csi-cni-cri]: ../../assets/kuber/kinpic/S09-storage-csi-cri-cni.png
[mount-volumes]: ../../assets/kuber/kinpic/S09-storage-mount-volumes.png
[pv-pvc-pod]: ../../assets/kuber/kinpic/S09-storage-pv-pvc-pod.png
[storage-class-static-provisioning]: ../../assets/kuber/kinpic/S09-storage-class-static-provisioning.png
[storage-class-dynamic-provisioning]: ../../assets/kuber/kinpic/S09-storage-class-dynamic-provisioning.png

[ingress-01]: ../../assets/kuber/kinpic/S11-ingress-1.png
[ingress-02]: ../../assets/kuber/kinpic/S11-ingress-2.png
[ingress-03]: ../../assets/kuber/kinpic/S11-ingress-3.png
