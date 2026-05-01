# BGP

## BGP and the OSI Model

**BGP operates at Layer 7 (Application Layer)** — but this surprises most people, so let me explain the full picture.

### The Full Stack BGP Sits On

```
┌─────────────────────────────────┐
│  Layer 7 - Application          │  ← BGP protocol logic lives here
│  (BGP messages: OPEN, UPDATE..) │
├─────────────────────────────────┤
│  Layer 4 - Transport            │  ← TCP port 179
├─────────────────────────────────┤
│  Layer 3 - Network              │  ← IP (peers addressed by IP)
├─────────────────────────────────┤
│  Layer 2 - Data Link            │  ← Ethernet, whatever carries IP
├─────────────────────────────────┤
│  Layer 1 - Physical             │
└─────────────────────────────────┘
```

BGP rides on **TCP**, which rides on **IP**, which rides on **Ethernet**. So it touches multiple layers but lives at the top.


### Why People Say "Layer 3"

The confusion is understandable. BGP is called a **Layer 3 routing protocol** because:

- Its **purpose** is to build Layer 3 (IP) routing tables
- Peers are identified by **IP addresses** (Layer 3 addresses)
- It deals with **IP prefixes** — pure Layer 3 concepts
- It has no concept of MAC addresses or any Layer 2 constructs

So when network engineers say *"BGP is a Layer 3 protocol"*, they mean it **operates on and manages Layer 3**, not that it sits at Layer 3 in the OSI stack.

---

### Compare With Other Protocols

| Protocol | Actual OSI Layer | Manages |
|---|---|---|
| BGP | Layer 7 (over TCP/IP) | Layer 3 routing |
| OSPF | Layer 3 (runs directly on IP) | Layer 3 routing |
| STP | Layer 2 | Layer 2 topology |
| ARP | Between L2/L3 | L2↔L3 mapping |
| RIP | Layer 7 (over UDP) | Layer 3 routing |

Notice that **OSPF actually runs directly on IP** (protocol number 89), without TCP or UDP. BGP is unusual among routing protocols in choosing TCP for reliability.

---

### The Practical Implication

Because BGP uses TCP, two BGP peers **must have IP reachability to each other before BGP can run**. This means:

- For **directly connected peers** (your node and its ToR switch), Layer 2 and a shared subnet are enough
- For **multi-hop BGP** (peers not directly connected), you need an IGP like OSPF or static routes first to establish IP reachability, and *then* BGP can form a session on top

This is a fundamental rule: **BGP needs the network to already exist before it can help build the network.** IGPs handle the local fabric, BGP handles the inter-domain policy routing on top.

In Cilium's case, your nodes already have IP connectivity via your vCenter/VM networking — BGP then runs on top of that to advertise Pod CIDRs and Service IPs to your physical fabric.

## BGP Control Plane

### BGP is simultaneously:

- A session management protocol
- A route distribution system
- A policy engine
- A failure detection mechanism
- An internet-scale coordination system

```
┌──────────────────────────────────────────┐
│          BGP (Control Plane)             │  ← decides WHAT the routes are
│   "10.244.5.0/24 should go via Node-3"   │
└────────────────┬─────────────────────────┘
                 │ programs
┌────────────────▼─────────────────────────┐
│        IP Routing Table / FIB            │  ← L3 forwarding plane
│   (kernel, ASIC, eBPF)                   │  ← actually moves packets
└──────────────────────────────────────────┘
```

## BGP Can Do

- **Session Management**
Establishes and maintains TCP connections between peers, detects failures, and automatically withdraws routes when a session drops.

- **Route Advertisement**
Announces IP prefixes to peers — "I can reach this network, here's the path metadata." Keeps the entire network informed about reachability.

- **Route Withdrawal**
When a destination becomes unreachable, BGP propagates that removal to all peers automatically. No manual cleanup needed.

- **Path Selection**
When multiple paths exist to the same destination, BGP runs a deterministic best-path algorithm to pick the winner based on attributes like AS path length, local preference, and MED.

- **Policy Control**
Filter, tag, prefer, or reject routes based on any attribute. This is BGP's most powerful capability — you express business and network policy through route manipulation.

- **ECMP / Multi-path**
Install multiple equal-cost paths simultaneously, distributing traffic across them at the routing level.

- **Route Reflection**
Scale iBGP inside large networks without requiring full-mesh peering between every router.

- **Community Tagging**
Attach metadata tags to routes so downstream peers can make policy decisions without needing to know the full context.

---

In one line each:

| Method | What it does |
|---|---|
| Session management | Keep peers connected, detect failures |
| Advertisement | Tell peers what you can reach |
| Withdrawal | Tell peers what you can no longer reach |
| Path selection | Pick the best route when multiple exist |
| Policy control | Control what you accept and announce |
| ECMP | Spread traffic across multiple paths |
| Communities | Tag routes with metadata for policy |

Everything BGP does falls into one of these categories.
