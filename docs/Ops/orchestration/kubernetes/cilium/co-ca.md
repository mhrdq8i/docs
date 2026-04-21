# Cilium Agent and Cilium Operator

The core difference is scope and lifecycle: the **Cilium Agent** is a per-node DaemonSet that handles the actual dataplane work, 
while the **Cilium Operator** is a cluster-wide Deployment that handles control-plane tasks that only need to happen once per cluster (not once per node).

**Cilium Agent (`cilium-agent`)**
- Runs as a DaemonSet — one pod on every node
- Owns the dataplane on its node: programs eBPF into the kernel, manages endpoints when pods start/stop, enforces NetworkPolicies, handles service load balancing (kube-proxy replacement), encryption, and Hubble flow visibility
- Talks directly to the kernel and to the local CNI plugin binary
- If an agent dies, only that node loses Cilium functionality

**Cilium Operator (`cilium-operator`)**
- Runs as a Deployment — typically 2 replicas with leader election, cluster-wide
- Handles tasks that don't belong on every node:
  - IPAM garbage collection (reclaiming IPs from deleted nodes/pods, managing the cluster pool in cluster-pool or ENI modes)
  - CiliumNode and CiliumEndpoint CRD lifecycle — creating/cleaning up objects for nodes that have come and gone
  - CoreDNS NodeLocal DNS management, Ingress/Gateway API resource synchronization to LB services
  - Syncing kvstore state if you use etcd-backed identity allocation
  - Identity GC for stale security identities
- If the operator is down, the cluster keeps running — existing pods and policies work fine — but new node provisioning, IP GC, and some CRD reconciliation will stall

A useful mental model: the **agent is the hands** (doing the work on each node), and the **operator is the bookkeeper** (handling cluster-wide state that would be wasteful or incorrect to run N times). This is why you scale agents with nodes but keep operator replicas low (2 for HA via leader election).

For your CAPV/multi-cluster setup, this distinction matters when planning HA — operator downtime won't hurt running workloads, but agent issues on a node will sever dataplane for pods scheduled there, so node-level monitoring on the agent DaemonSet is what you want to alert on aggressively.
