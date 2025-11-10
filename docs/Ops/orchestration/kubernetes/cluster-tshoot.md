# Debug and T-Shoot K8S Cluster

## NetShoot

=== "Over POD"

    ### 1. Basic Netshoot Debug Pod

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: netshoot
      namespace: default
    spec:
      containers:
      - name: netshoot
        image: nicolaka/netshoot:latest
        command:
          - sleep
          - "infinity"
        resources:
          limits:
            cpu: 500m
            memory: 512Mi
          requests:
            cpu: 100m
            memory: 128Mi
    ```

=== "Privileged"

    ### 2. Privileged Netshoot (for advanced debugging)

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: netshoot-privileged
      namespace: default
    spec:
      hostNetwork: true
      hostPID: true
      hostIPC: true
      containers:
      - name: netshoot
        image: nicolaka/netshoot:latest
        command:
          - sleep
          - "infinity"
        securityContext:
          privileged: true
          capabilities:
            add:
              - NET_ADMIN
              - SYS_ADMIN
        resources:
          limits:
            cpu: 500m
            memory: 512Mi
          requests:
            cpu: 100m
            memory: 128Mi
    ```

=== "Daemon Set"

    ### 3. Netshoot DaemonSet (one pod per node)

    ```yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: netshoot
      namespace: default
      labels:
        app: netshoot
    spec:
      selector:
        matchLabels:
          app: netshoot
      template:
        metadata:
          labels:
            app: netshoot
        spec:
          hostNetwork: true
          hostPID: true
          containers:
          - name: netshoot
            image: nicolaka/netshoot:latest
            command:
              - sleep
              - "infinity"
            securityContext:
              privileged: true
            resources:
              limits:
                cpu: 200m
                memory: 256Mi
              requests:
                cpu: 100m
                memory: 128Mi
    ```

=== "Deployment"

    ### 4. Netshoot Deployment (for general debugging)

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: netshoot
      namespace: default
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: netshoot
      template:
        metadata:
          labels:
            app: netshoot
        spec:
          containers:
          - name: netshoot
            image: nicolaka/netshoot:latest
            command:
              - sleep
              - "infinity"
            resources:
              limits:
                cpu: 500m
                memory: 512Mi
              requests:
                cpu: 100m
                memory: 128Mi
    ```

---

### Usage Examples

**Deploy:**

```bash
kubectl apply -f netshoot.yaml
```

**Exec into the container:**

```bash
# For pod
kubectl exec -it netshoot -- bash

# For DaemonSet (specify node name)
kubectl exec -it netshoot-<node-suffix> -- bash
```

**Common debugging commands inside netshoot:**

```bash
# DNS lookup
nslookup kubernetes.default
dig @10.96.0.10 kubernetes.default.svc.cluster.local

# Test connectivity to a service
curl http://my-service:8080
wget -O- http://my-service:8080

# Network troubleshooting
ping 8.8.8.8
traceroute google.com
mtr google.com

# Port scanning
nmap -p 80,443 my-service

# HTTP testing
curl -v http://my-service:8080/health
ab -n 100 -c 10 http://my-service:8080/

# TCP/UDP testing
nc -zv my-service 8080
tcpdump -i any port 8080

# Check network interfaces
ip addr
ip route
iptables -L -n -v

# Performance testing
iperf3 -c my-service

# Check DNS resolution
cat /etc/resolv.conf
```

---

### For Debugging Specific Pods

If you want to debug a specific pod's network namespace:

```bash
# Get the pod's node
kubectl get pod <pod-name> -o wide

# Use netshoot on that node (if using DaemonSet)
kubectl exec -it netshoot-<node> -- bash

# Then you can nsenter into the pod's namespace
# First find the container PID on the host
crictl ps | grep <pod-name>
nsenter -t <PID> -n bash
```
