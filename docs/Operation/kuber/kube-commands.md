# All Kubernetes Commands

Kubernetes [commands] and [cheatsheet]

## Kubectl

Version and Info

```bash
kubectl version
kubectl cluster-info
kubectl cluster-info dump > cluster-info.dump
```

## Nodes

Get All Nodes

```bash
kubectl get nodes
kubectl get nodes -o wide
kubectl get nodes -o wide -w/--watch
```

Describe Nodes

```bash
kubectl describe node <node-name> #describe node details including limits
```

Set label for a node

```bash
kubectl label node <node-name> kubernetes.io/role=node
kubectl label node <node-name> label_key=label_value
kubectl label node <node-name> label_key- ;"remove added label from node"
```

Taint

```bash
kubectl taint node <node-name> taint_label_key=taint_label_value ;"add taint label to node"
kubectl taint node <node-name> taint_label_key- ;"remove added taint label to node"
```

## Pods

```bash
kubectl -n kube-system get pods -o wide
kubectl -n kube-system describe pods <podname>
kubectl delete <pod_name>
kubectl get pods --show-labels
kubectl get pods -o yaml > pods.yaml
kubectl describe pod
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.ports
kubectl explain pod.spec.containers.ports
kubectl explain pod.spec.affinity
kubectl exec -it <pod-name> bash # get an interactive shell from a running pod
kubectl get pods --selector key=value
```

## Resource

```bash
kubectl create -f <pod_file_name.yml>
kubectl replace -f <pod_file_name.yml>
kubectl get rs -o wide
kubectl apply -f <file-name.yml>
kubectl delete -f <manifest-filename.yml>

kubectl explain <config-kind>
kubectl explain resourcequota
kubectl explain resourcequota.spec
kubectl explain resourcequota.spec.hard
```

Update a resource

```bash
kubectl edit <unit-type> <unit-name>
```

## Namespace

```bash
kubectl get namespace
kubectl get ns
kubectl create namespace <ns-name>
kubectl get -n <ns-name> pods
kubectl describe <ns-name>
kubectl -n <ns-name> events
kubectl get pods --all-namespaces
```

## Config

```bash
# imperative method
kubectl create configmap <config-name> --from-file=<path-to-file>
# declarative method
kubectl create/apply -f <configmapfile.yml>
# describe
kubectl describe cm <configmapfile.yml>
kubectl describe cm <configmapfile.yml> --output yaml
```

### Drain/Cordon/Uncordon

```bash
kubectl drain <node-name>; drain execute cordon command
kubectl cordon <node-name> ;set unscheduled label to node
kubectl uncordon <node-name> ;Remove unscheduled label from node
```

## Application Lifecycle summarize commands

```bash
kubectl create -f <deployment-filename.yml>
kubectl get <deployment-name>
kubectl apply -f <deployment-filename.yml>
kubectl set image <deployment-name> <image=imagename:imagetag>
kubectl rollout status <deployment-name>
kubectl rollout history <deployment-name>
kubectl rollout undo <deployment-name>
```

<!-- links -->
[commands]: ../../assets/kuber/cheatsheet/cs-commands.jpg
[cheatsheet]: ../../assets/kuber/cheatsheet/cs-CheatSheet.jpg