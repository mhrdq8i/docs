# Service-Mesh - Service-Discovery - Ingress/API Gateway

## Service-Mesh vs Ingress/API Gateway

### Tasks

They handle **different traffic**:

- **Service Mesh** = Pod-to-Pod (EAST-WEST) inside cluster
- **Ingress** = External-to-Pod (NORTH-SOUTH) into cluster

### Visual Explanation

```bash
═══════════════════════════════════════════════════════════════════════════
                    NORTH-SOUTH vs EAST-WEST TRAFFIC
═══════════════════════════════════════════════════════════════════════════

                         External Users
                         (Internet/Corp Network)
                                 │
                                 │ NORTH-SOUTH
                                 │ (Ingress handles this)
                                 │
                    ┌────────────▼────────────┐
                    │    KUBERNETES CLUSTER   │
                    │                         │
                    │    ┌──────────────┐     │
                    │    │   Ingress    │     │
                    │    │  Controller  │     │
                    │    └──────┬───────┘     │
                    │           │             │
                    │  ┌────────▼────────┐    │
                    │  │  Frontend Pod   │    │
                    │  └────────┬────────┘    │
                    │           │             │
                    │           │ EAST-WEST   │
                    │           │ (Service Mesh handles this)
                    │           │             │
                    │  ┌────────▼────────┐    │
                    │  │   API Pod       │────┼─► Database Pod
                    │  └────────┬────────┘    │
                    │           │             │
                    │  ┌────────▼────────┐    │
                    │  │   Auth Pod      │────┼─► Cache Pod
                    │  └─────────────────┘    │
                    │                         │
                    └─────────────────────────┘
```

### What Each Does

#### Ingress/API Gateway (NORTH-SOUTH)

**Purpose:** Get traffic **INTO** the cluster

**Handles:**

```bash
✅ External → Cluster routing
✅ TLS termination (HTTPS)
✅ Hostname routing (api.mci.local)
✅ Path routing (/users, /orders)
✅ External load balancing
✅ Public IP exposure
```

**Example Flow:**

```bash
User Browser (Internet)
    ↓
http://api.mci.local/users
    ↓
LoadBalancer IP (192.168.228.200)
    ↓
Ingress Controller
    ↓
Routes to "api-service"
    ↓
API Pod receives request
```

#### Service Mesh (EAST-WEST)

**Purpose:** Manage traffic **BETWEEN** pods inside cluster

**Handles:**

```bash
✅ Pod → Pod communication
✅ mTLS (encrypted pod-to-pod)
✅ Service-to-service policies
✅ Retries, timeouts, circuit breakers
✅ Traffic splitting (A/B testing)
✅ Observability between services
✅ Service discovery
```

**Example Flow:**

```bash
API Pod wants to call Auth Service
    ↓
Service Mesh intercepts
    ↓
Checks: Is API pod allowed to call Auth?
    ↓
Encrypts with mTLS
    ↓
Load balances across Auth pods
    ↓
Tracks latency, errors
    ↓
Auth Pod receives request
```

### Complete Architecture

```bash
═══════════════════════════════════════════════════════════════════════════
              BOTH INGRESS AND SERVICE MESH TOGETHER
═══════════════════════════════════════════════════════════════════════════

External User
    │
    │ 1. NORTH-SOUTH (Ingress)
    ▼
┌────────────────────────────────────────────────────────────────┐
│  Ingress Controller (Cilium Envoy)                             │
│  • TLS termination                                             │
│  • Hostname routing                                            │
│  • External authentication                                     │
└────────────────┬───────────────────────────────────────────────┘
                 │
                 ▼
            Frontend Pod
                 │
                 │ 2. EAST-WEST (Service Mesh)
                 │    • mTLS encryption
                 │    • L7 policies
                 │    • Retry logic
                 │    • Circuit breaker
                 ▼
            API Pod ──────► Auth Pod
                 │              │
                 │              │ 3. EAST-WEST
                 │              ▼
                 │         Database Pod
                 │
                 │ 4. EAST-WEST
                 ▼
            Payment Pod ───► Kafka Pod
                 │
                 │ 5. EAST-WEST
                 ▼
            Notification Pod
```

### Why You Need Both

#### Scenario Without Service Mesh (Only Ingress)

```bash
✅ External traffic reaches cluster
❌ No encryption between pods
❌ No pod-to-pod policies
❌ No retry logic between services
❌ No circuit breakers
❌ Limited observability of internal traffic
❌ No canary deployments
```

#### Scenario Without Ingress (Only Service Mesh)

```bash
❌ External traffic can't reach cluster
❌ No TLS termination for external clients
❌ No hostname-based routing from outside
✅ Internal pod-to-pod works great
```

### Cilium's Unique Position

**Cilium does BOTH Ingress AND Service Mesh!**

```bash
┌────────────────────────────────────────────┐
│               CILIUM STACK                 │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  Ingress Controller (Cilium Envoy)   │  │
│  │  Handles: NORTH-SOUTH                │  │
│  └──────────────────────────────────────┘  │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  Service Mesh (Cilium + Envoy)       │  │
│  │  Handles: EAST-WEST                  │  │
│  └──────────────────────────────────────┘  │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  Kube-proxy Replacement (eBPF)       │  │
│  │  Handles: Load balancing             │  │
│  └──────────────────────────────────────┘  │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  Network Policies (eBPF + Envoy)     │  │
│  │  Handles: L3/L4/L7 security          │  │
│  └──────────────────────────────────────┘  │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  Observability (Hubble)              │  │
│  │  Handles: All traffic visibility     │  │
│  └──────────────────────────────────────┘  │
└────────────────────────────────────────────┘
```

**This is why Cilium is powerful** - it's an all-in-one solution.

### Feature Comparison

| Feature           | Ingress Only   | Service Mesh Only  | Both (Cilium)    |
| ----------------- | -------------  | -----------------  | ---------------- |
| External access   | ✅             | ❌                 | ✅               |
| TLS termination   | ✅             | ❌                 | ✅               |
| Hostname routing  | ✅             | ❌                 | ✅               |
| Pod-to-pod mTLS   | ❌             | ✅                 | ✅               |
| Retries/timeouts  | ❌             | ✅                 | ✅               |
| Circuit breakers  | ❌             | ✅                 | ✅               |
| Traffic splitting | ❌             | ✅                 | ✅               |
| L7 observability  | ⚠️ (edge only) | ✅ (internal)      | ✅ (everywhere)  |
| Network policies  | ⚠️ (limited)   | ✅                 | ✅               |

### Real-World Example

#### E-commerce Application

```bash
User Request: https://shop.mci.local/checkout
    │
    │ ┌─────────────────────────────────────────┐
    │ │ INGRESS NEEDED                          │
    │ │ • Accept HTTPS from internet            │
    │ │ • Route /checkout to frontend           │
    │ │ • TLS termination                       │
    │ └─────────────────────────────────────────┘
    ▼
Frontend Pod
    │
    │ Makes API call: POST /api/payment
    │
    │ ┌─────────────────────────────────────────┐
    │ │ SERVICE MESH NEEDED                     │
    │ │ • Encrypt traffic (mTLS)                │
    │ │ • Retry if payment service down         │
    │ │ • Circuit breaker if failing            │
    │ │ • L7 policy: only POST allowed          │
    │ └─────────────────────────────────────────┘
    ▼
Payment Service Pod
    │
    │ Calls: GET /api/inventory
    │
    │ ┌─────────────────────────────────────────┐
    │ │ SERVICE MESH NEEDED                     │
    │ │ • Check authorization                   │
    │ │ • Track latency                         │
    │ │ • Load balance across inventory pods    │
    │ └─────────────────────────────────────────┘
    ▼
Inventory Service Pod
```

**You need both:**

- **Ingress** to get the user's request into the cluster
- **Service Mesh** to manage the internal service calls

#### When You DON'T Need Service Mesh

**Simple applications:**

```bash
User → Ingress → Single Monolith Pod → Database
```

**If you have:**

- Only 1-3 services
- No pod-to-pod communication
- No need for mTLS
- No complex retry logic
- Simple architecture

**Then skip Service Mesh**, just use Ingress.

#### When You DON'T Need Ingress

**Internal-only cluster:**

```bash
No external access needed
Pods only talk to each other
All traffic is EAST-WEST
```

**Examples:**

- Data processing cluster (Kafka, Spark)
- Batch job cluster
- ML training cluster

**Then skip Ingress**, just use Service Mesh.

### Summary Table

| Traffic Type       | Component    | Purpose                 | Do You Need It?           |
| ------------------ | ------------ | ----------------------- | ------------------------  |
| External → Cluster | Ingress      | Get traffic in          | ✅ YES (always)           |
| Pod → Pod          | Service Mesh | Manage internal traffic | ⚠️ Only if microservices  |
| External APIs      | API Gateway  | Advanced API features   | ❌ Not for internal tools |

#### Bottom Line

**Service Mesh ≠ Replacement for Ingress**

They're complementary:

- **Ingress** = Front door to your cluster
- **Service Mesh** = Internal traffic management

**For MCI:**

- ✅ Use Cilium Ingress (you need external access)
- ⚠️ Service Mesh features later (if you build microservices)
- ❌ Skip API Gateway (internal tools don't need it)

## Service Mesh vs Service Discovery 

These two concepts are often mentioned together, but operate at very different layers of your cluster. Here's a clear breakdown:

### Service Discovery

**What it is:** The mechanism by which workloads *find* each other inside the cluster.

In Kubernetes, this is handled natively and automatically through:

- **kube-dns / CoreDNS** — Every Service gets a DNS record like `my-svc.my-namespace.svc.cluster.local`. Pods resolve this to a ClusterIP.
- **kube-proxy** — Watches the API server for Endpoint changes and programs iptables/ipvs rules on each node to route traffic to healthy pods behind a Service.
- **Endpoints / EndpointSlices** — The control plane continuously reconciles which pod IPs back a given Service, so dead pods are removed automatically.

**Think of it as:** *"How do I find where service B is running right now?"*

It answers the **WHERE** question — address resolution and basic load balancing.


### Service Mesh

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


### The Core Distinction

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


### Practical Guidance for Your Stack

Given your KaaS platform works with Cilium:

- **Cilium** already replaces kube-proxy for service discovery using eBPF, which is faster and more scalable than iptables.
- **Cilium Service Mesh** (with Hubble) can give you a significant portion of service mesh capabilities — L7 visibility, mTLS via WireGuard, network policies — **without the sidecar overhead**. This is worth considering over Istio for your air-gapped enterprise clusters since it has fewer moving parts.
- For entry-level tiers (vCluster), service discovery alone is usually enough. A full mesh makes more sense at the dedicated cluster tier, where tenants need SLA-grade observability and zero-trust networking.
