# Kubernetes

## Service

### How Kubernetes service loadbalance input traffic?

In Kubernetes, a Service is responsible for load balancing the incoming traffic to the appropriate Pods. The way a Kubernetes Service load balances the input traffic depends on the type of Service and the load balancing mechanism used.

Here's how Kubernetes Service load balances the input traffic:

1. **Service Types**:

    - **ClusterIP**: This is the default Service type. It exposes the Service on a cluster-internal IP address, which is only accessible from within the cluster.

    - **NodePort**: This type of Service exposes the Service on each Node's IP address at a static port. This makes the Service accessible from outside the cluster.

    - **LoadBalancer**: This type of Service provisions a load balancer for the Service, typically in cloud environments, and assigns a publicly accessible IP address to the Service.

    - **ExternalName**: This type of Service maps the Service to an external DNS name, without any proxy or load balancing.

2. **Load Balancing Mechanisms**:

    - **Kube-proxy**: Kube-proxy is a component that runs on each Node and is responsible for implementing the Service abstraction. It uses various load balancing mechanisms, such as iptables or IPVS, to distribute the traffic to the appropriate Pods.

    - **Ingress**: Ingress is a Kubernetes resource that provides advanced routing and load balancing capabilities. Ingress controllers, such as NGINX Ingress Controller or Traefik, are responsible for load balancing the incoming traffic to the appropriate Services.

    - **Cloud Load Balancers**: When using the `LoadBalancer` Service type, Kubernetes provisions a load balancer in the cloud environment (e.g., AWS Elastic Load Balancing, Google Cloud Load Balancing) and assigns a public IP address to the Service.

The load balancing mechanism used by a Kubernetes Service depends on the Service type and the underlying infrastructure. For example:

- **ClusterIP**: Kube-proxy is responsible for load balancing the traffic to the appropriate Pods.

- **NodePort**: Kube-proxy is responsible for load balancing the traffic to the appropriate Pods on the Node's IP address and port.

- **LoadBalancer**: Kubernetes provisions a cloud load balancer and assigns a public IP address to the Service.

- **Ingress**: The Ingress controller is responsible for load balancing the incoming traffic to the appropriate Services.

The load balancing mechanism used by Kubernetes Services ensures that the incoming traffic is distributed across the appropriate Pods, providing _high availability_ and _scalability_ for your applications.

### What is default algorithm for Services in Kubernetes?

In Kubernetes, the **default load-balancing algorithm** for Services depends on the type of Service and the underlying implementation. By default, Kubernetes uses a **round-robin** load-balancing algorithm for distributing traffic to pods behind a Service. However, the exact behavior can vary based on the Service type and the networking components (e.g., `kube-proxy` mode) in use.

### 1. Default Load-Balancing Algorithm: Round-Robin

- **Round-Robin** is the default algorithm used by Kubernetes to distribute traffic across the pods backing a Service.
- This means that each request is directed to the next available pod in a cyclic manner, ensuring an even distribution of traffic under normal conditions.

### 2. Factors Influencing Load Balancing

#### **a. Service Type**

The load-balancing behavior can vary depending on the type of Service:

- **ClusterIP**:

    - The most common Service type, which exposes the Service only within the cluster.
    - Uses round-robin by default for load balancing traffic to pods.

- NodePort**:

    - Exposes the Service on a specific port on each node's IP address.
    -   Also uses round-robin for load balancing traffic to pods.

- **LoadBalancer**:

    - Exposes the Service externally using a cloud provider's load balancer (e.g., AWS ELB, GCP Load Balancer).
    - The external load balancer may have its own load-balancing algorithm, but internally within the cluster, Kubernetes still uses round-robin.

- **ExternalName**:
    - Maps the Service to an external DNS name and does not involve load balancing.

#### **b. kube-proxy Mode**

Kubernetes uses `kube-proxy` to implement Service load balancing. The behavior of `kube-proxy` depends on its operating mode:

- **Userspace Mode** (Deprecated):

    - In this mode, `kube-proxy` runs as a userspace process and manually forwards packets between the Service and pods.
    - Uses round-robin for load balancing.

- **iptables Mode** (Default in most clusters):

    - In this mode, `kube-proxy` configures iptables rules to redirect traffic to the appropriate pod.
    - Still uses round-robin as the default algorithm, but it is implemented at the kernel level for better performance.

- **IPVS Mode**:
    - IPVS (IP Virtual Server) is an advanced load-balancing solution that provides more efficient and scalable load balancing compared to iptables.
    - Supports multiple algorithms, including:
        - **rr (Round-Robin)** (default)
        - **lc (Least Connections)**
        - **dh (Destination Hashing)**
        - **sh (Source Hashing)**
        - **wrr (Weighted Round-Robin)**
        - **wlc (Weighted Least Connections)**

If your cluster is configured to use IPVS, you can specify a different algorithm using the `service.spec.sessionAffinityConfig.clientIP` or other configuration options.

### 3. Session Affinity

Kubernetes allows you to configure **session affinity** for Services, which can affect the load-balancing behavior.

- **None** (Default):

    - No session affinity; each request is distributed using the default round-robin algorithm.

- **ClientIP**:
    - Ensures that requests from the same client IP are routed to the same pod for the duration of a session.
    - This overrides the default round-robin behavior and is useful for stateful applications.

You can enable session affinity by setting the `service.spec.sessionAffinity` field to `ClientIP` in the Service definition.

### 4. Custom Load-Balancing with External Proxies

For more advanced load-balancing requirements, you can use an **Ingress controller** or an external proxy (e.g., NGINX, HAProxy, Envoy) to handle traffic distribution. These tools often provide additional algorithms, such as:

- **Least Connections**
- **Weighted Round-Robin**
- **IP Hashing**
- **URL Hashing**

### Summary Table

| Factor               | Default Algorithm | Notes                                                           |
| -------------------- | ----------------- | --------------------------------------------------------------- |
| **Service Type**     | Round-Robin       | Applies to ClusterIP, NodePort, and LoadBalancer.               |
| **kube-proxy Mode**  | Round-Robin       | Userspace, iptables, and IPVS modes all default to round-robin. |
| **IPVS Mode**        | Round-Robin (rr)  | Supports multiple algorithms like lc, wrr, wlc, etc.            |
| **Session Affinity** | None              | Can be set to ClientIP for sticky sessions.                     |

---

### **Conclusion**

By default, Kubernetes uses a **round-robin** algorithm for load balancing traffic to pods behind a Service. This behavior can be customized using session affinity or by switching to advanced networking modes like IPVS, which support additional algorithms. For more complex use cases, external proxies or Ingress controllers can provide fine-grained control over load-balancing behavior.

## CNI

### How many CNI does Kubernetes have?

Kubernetes itself does not have a specific number of **CNI (Container Network Interface) plugins** built into the core platform. Instead, Kubernetes is designed to work with a wide variety of CNI plugins, which are developed and maintained by third-party organizations or communities. These plugins implement the networking functionality required by Kubernetes, such as pod-to-pod communication, network policy enforcement, and service discovery.

The **CNI specification** defines a standard interface for container runtimes (like Docker or containerd) to interact with network plugins. Kubernetes relies on this specification to delegate networking tasks to the chosen CNI plugin.

### **How Many CNI Plugins Are Available?**

There is no fixed number of CNI plugins for Kubernetes because new plugins are continuously being developed, and existing ones are updated or deprecated over time. However, some of the most popular and widely used CNI plugins in the Kubernetes ecosystem include:

1. **Calico**

    - Provides robust networking and network policy enforcement.
    - Uses **BGP** for efficient routing and supports advanced security features.
    - Works in **_L3_** network stack.
    - Popular for production-grade Kubernetes clusters.

2. **Flannel**

    - A simple **overlay** network solution that satisfies the basic networking requirements of Kubernetes.
    - Supports multiple backends like _VXLAN_, _UDP_, and _host-gw_.
    - Ideal for smaller clusters or environments where simplicity is prioritized.

3. **Cilium**

    - Leverages **eBPF** for _high-performance networking_ and advanced security features.
    - Supports **_L7_** network policies and integrates well with service meshes.
    - Suitable for large-scale, high-performance environments.

4. **Weave Net**

    - An easy-to-use networking solution that creates a virtual network for containers.
    - Automatically sets up an overlay network with encryption and DNS support.
    - Suitable for small to medium-sized clusters.

5. **Canal**

    - Combines Flannel for networking and Calico for network policies.
    - Provides a hybrid solution for clusters that need both simple networking and advanced policy enforcement.

6. **Multus**

    - Allows pods to have multiple network interfaces, enabling multi-networking use cases.
    - Often used in conjunction with other CNI plugins to provide additional network interfaces.

7. **Kube-Router**

    - Combines networking, network policy, and service proxy functionality into a single lightweight solution.
    - Focuses on performance and simplicity.

### Conclusion

While Kubernetes does not have a fixed number of CNI plugins, there are dozens of CNI-compatible plugins available in the ecosystem. The exact number depends on how you count them, but the most commonly used ones include **Calico**, **Flannel**, **Cilium**, **Weave Net**, **Canal**, **Multus**, and others. Additionally, the official CNI project provides a set of foundational plugins that can be used to build custom networking solutions.

If you're looking for a specific CNI plugin, the choice depends on your use case, such as _performance requirements_, _network policy_ needs, or _multi-networking_ capabilities.

## Deployment

### What is the default deployment strategy in Kubernetes?

The default deployment strategy in Kubernetes is the **Rolling Update** strategy.

### Key Characteristics of Rolling Update

- **Gradual Replacement**: The Rolling Update strategy gradually replaces old Pods with new ones, ensuring that the application remains available during the update.

- **Controlled Process**: It updates a small number of Pods at a time, rather than all at once, to minimize downtime and risk.

- **Readiness and Liveness Probes**: Kubernetes uses readiness and liveness probes to ensure that new Pods are functioning correctly before scaling down the old ones.

- **Rollback Capability**: If something goes wrong during the update, Kubernetes can roll back to the previous version of the deployment.

### How It Works

1. When you update a Deployment (e.g., by changing the container image or configuration), Kubernetes creates new Pods with the updated configuration.

2. It scales up the new Pods while scaling down the old ones, ensuring that the desired number of Pods specified in the Deployment is always running.

3. This process continues until all old Pods are replaced with new ones.

### Example

If you have a Deployment with 3 replicas and you update the container image, Kubernetes might:

- Create 1 new Pod with the updated image.
- Wait for the new Pod to become ready.
- Terminate 1 old Pod.
- Repeat this process until all 3 Pods are running the new version.

### Customization

You can customize the Rolling Update strategy by specifying parameters like:

- `maxUnavailable`: The maximum number of Pods that can be unavailable during the update.
- `maxSurge`: The maximum number of Pods that can be created above the desired number of Pods during the update.

These parameters are defined in the `strategy` section of a Deployment's YAML file.

Example:

```yaml
spec:
    strategy:
        type: RollingUpdate
        rollingUpdate:
            maxUnavailable: 1
            maxSurge: 1
```

This default strategy ensures high availability and smooth updates for applications running in Kubernetes.
