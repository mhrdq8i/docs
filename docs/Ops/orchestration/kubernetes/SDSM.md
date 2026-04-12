# Service Mesh vs Service Discovery in Kubernetes

These two concepts are often mentioned together, but operate at very different layers of your cluster. Here's a clear breakdown:

## Service Discovery

**What it is:** The mechanism by which workloads *find* each other inside the cluster.

In Kubernetes, this is handled natively and automatically through:

- **kube-dns / CoreDNS** — Every Service gets a DNS record like `my-svc.my-namespace.svc.cluster.local`. Pods resolve this to a ClusterIP.
- **kube-proxy** — Watches the API server for Endpoint changes and programs iptables/ipvs rules on each node to route traffic to healthy pods behind a Service.
- **Endpoints / EndpointSlices** — The control plane continuously reconciles which pod IPs back a given Service, so dead pods are removed automatically.

**Think of it as:** *"How do I find where service B is running right now?"*

It answers the **WHERE** question — address resolution and basic load balancing.


## Service Mesh

**What it is:** An infrastructure layer that **controls**, **observes**, and **secures** *traffic between* services — ***after discovery has already happened***.

It's typically implemented via a **sidecar proxy** (e.g., Envoy) injected into every pod, plus a **control plane** (Istio, Linkerd, Cilium Service Mesh, Consul Connect).

A service mesh gives you:

| Capability | What it does |
|---|---|
| **mTLS** | Encrypts and authenticates all pod-to-pod traffic automatically |
| **Traffic management** | Canary releases, traffic splitting (90/10), retries, circuit breaking, timeouts |
| **Observability** | Golden signals (latency, error rate, throughput) per service pair — L7 metrics |
| **Authorization policies** | "Service A is allowed to call Service B on `/api/*` only" |
| **Fault injection** | Inject delays or errors for chaos testing |

**Think of it as:** *"Now that I found service B, HOW should traffic flow, and is it safe/observable?"*

It answers the **HOW, WHO, and WHY** questions — behavior, security, and visibility.


## The Core Distinction

```
Request from Pod A  →  CoreDNS resolves "service-b"  →  kube-proxy routes to a healthy pod
        ↑                        ↑
   [ Service Discovery — built into k8s, always present ]


Request from Pod A  →  Envoy sidecar intercepts  →  applies policy/mTLS/retries  →  Envoy on Pod B
        ↑                             ↑
   [ Service Mesh — optional add-on, operates at L7 ]
```

| | Service Discovery | Service Mesh |
|---|---|---|
| **Layer** | L3/L4 (IP, TCP) | L7 (HTTP, gRPC) |
| **Built into k8s?** | ✅ Yes (CoreDNS + kube-proxy) | ❌ No, add-on |
| **Scope** | Finding & routing to a service | Controlling traffic between services |
| **Observability** | None (basic) | Full L7 metrics, tracing |
| **Security** | None beyond network policies | mTLS, RBAC per route |
| **Complexity** | Zero (transparent) | High — significant ops overhead |


## Practical Guidance for Your Stack

Given your KaaS platform works with Cilium:

- **Cilium** already replaces kube-proxy for service discovery using eBPF, which is faster and more scalable than iptables.
- **Cilium Service Mesh** (with Hubble) can give you a significant portion of service mesh capabilities — L7 visibility, mTLS via WireGuard, network policies — **without the sidecar overhead**. This is worth considering over Istio for your air-gapped enterprise clusters since it has fewer moving parts.
- For entry-level tiers (vCluster), service discovery alone is usually enough. A full mesh makes more sense at the dedicated cluster tier, where tenants need SLA-grade observability and zero-trust networking.
