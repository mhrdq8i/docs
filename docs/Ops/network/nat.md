# SNAT/DNAT

Both rewrite IP headers, but they touch *different* fields and apply at different points in the path. Here's the cleanest way to see it:**The punchline.** SNAT changes "who is this from?" — the gateway hides the real sender behind its own address. DNAT changes "who is this for?" — the gateway redirects the packet to a different destination than what was originally written on it. The packet's other endpoint stays untouched in both cases.

<img width="1440" height="840" alt="image" src="https://github.com/user-attachments/assets/60ecfe22-d208-4407-9028-ba1ab7bec51e" />

<br/>

**Direction matters, but isn't the definition.** SNAT is *typically* applied as a packet leaves an interface (POSTROUTING in iptables; the egress path), DNAT *typically* as it arrives (PREROUTING; the ingress path). That's a consequence of where each rewrite is useful, not the definition. The definition is purely "which IP field gets rewritten."

**Connection state is what makes it work in both directions.** A NAT box has to remember the original tuple so reply traffic can be reverse-translated. For SNAT, when the server's reply comes back addressed to `203.0.113.1`, the gateway looks up the conntrack entry, rewrites the destination back to `10.0.0.5`, and forwards it inward. For DNAT, the backend's reply has source `10.0.0.10`; the gateway rewrites the source back to `203.0.113.1` so the external client sees a coherent conversation. This is also why ports often get rewritten alongside IPs — when many internal hosts share one public IP (PAT/masquerade), the source port becomes the demultiplexer for return traffic.

**Where you've already seen both:**
- That `netsh portproxy` setup forwarding external traffic to a VM is **DNAT** — external destination → internal VM IP.
- HAProxy in front of backends is essentially DNAT at the application layer (plus connection termination).
- A pod in your KaaS cluster reaching `8.8.8.8`: kube-proxy or Cilium does **SNAT** (masquerade) to the node's IP, because the external internet doesn't know how to route the pod CIDR back. This is exactly the friction BGP eliminates — once nodes advertise pod prefixes, return traffic finds its way and the SNAT becomes unnecessary.
- A `Service` of type ClusterIP being reached by a pod: **DNAT** from the virtual service IP to the chosen endpoint pod IP.

A useful one-liner: *SNAT lies about the sender; DNAT lies about the recipient.*
