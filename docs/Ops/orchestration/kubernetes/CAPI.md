# ClusterAPI (CAPI)

```bash
+-----------------------------------------+
| (1) Management Cluster (kind/k3s)       |
|  - Runs ClusterAPI controllers          |
|  - Knows how to create clusters         |
+--------------------+--------------------+
                     |
                     | clusterctl create cluster ...
                     v
+-----------------------------------------+
| (2) Workload Cluster (main cluster)     |
|  - Control plane + nodes                |
|  - Created via CAPI (BYOH, AWS, etc.)   |
|  - Managed declaratively                |
+-----------------------------------------+
```

```bash
gitops-repo/
├── infrastructure/          # مدیریت زیرساخت
│   ├── management-cluster/
│   ├── workload-clusters/
│   │   ├── production/
│   │   │   ├── cluster.yaml      # تعریف CAPI
│   │   │   ├── machinedeployment.yaml
│   │   │   └── addons/          # CNI, CSI, etc.
│   │   └── staging/
│   └── bootstrap/           # نصب اولیه ArgoCD
└── applications/           # اپلیکیشن‌های بیزینس
    ├── frontend/
    │   ├── production/
    │   └── staging/
    ├── backend/
    │   ├── production/
    │   └── staging/
    └── databases/
        ├── production/
        └── staging/
```

```bash
تغییر در Git → ArgoCD در کلاستر مدیریت →
├── اگر تغییر در infrastructure/ → به‌روزرسانی کلاسترهای ورک‌لود
└── اگر تغییر در applications/ → deploy اپلیکیشن در کلاسترهای مربوطه
```

```bash
+------------------------------------------------------+
| Management Cluster (permanent, HA)                   |
|                                                      |
| Components:                                          |
|  - Cluster API controllers (CAPI core)               |
|  - Infrastructure provider(s) (BYOH, AWS, vSphere)   |
|  - Bootstrap provider (kubeadm)                      |
|  - ArgoCD / Flux (GitOps controller)                 |
|                                                      |
| Responsibilities:                                    |
|  - Create and manage workload clusters               |
|  - Reconcile cluster lifecycle (upgrade, scale)      |
|  - Monitor machine health                            |
|  - GitOps sync: both infra manifests (clusters)      |
|    and application manifests                         |
+---------------------------+--------------------------+
                            |
                            v
+------------------------------------------------------+
| Workload Cluster(s)                                  |
|                                                      |
| Components:                                          |
|  - Control plane nodes                               |
|  - Worker nodes                                      |
|  - Optional monitoring / logging / apps              |
|                                                      |
| Responsibilities:                                    |
|  - Run business applications                         |
|  - Optionally receive ArgoCD app deployments from    |
|    the management cluster                            |
+------------------------------------------------------+
```

## Architecture Schema

<img width="1440" height="1200" alt="image" src="https://github.com/user-attachments/assets/55459ed2-7917-4bae-ba7a-8302abd5ad49" />

### Colors in the diagram encode *who is acting*: 

- gray = Git
- purple = management cluster
- teal = vCenter
- amber = workload cluster.

### phase-by-phase detail:

**1 — Declare.** You write four CRs in Git: `Cluster` (the top-level object), `VSphereCluster` (infra-side config — vCenter endpoint, datacenter, network), `KubeadmControlPlane` (replicas, version, kubeadm config) referencing a `VSphereMachineTemplate`, and one or more `MachineDeployment` objects for workers, each referencing their own machine template. Nothing happens in the cluster yet — these are just YAML files.

**2 — Sync.** ArgoCD notices the commit and applies the manifests to the management cluster's API server. At this point the objects exist in etcd but have empty `status` fields. This is the step where your GitOps audit trail gets written.

**3 — Reconcile.** The three controllers wake up and start watching:
- **CAPI core** sees the `Cluster` and creates the `Machine` objects implied by the `KubeadmControlPlane` and `MachineDeployment`.
- **Kubeadm bootstrap provider** generates cloud-init `BootstrapData` secrets for each `Machine` — one for the first control-plane node with `kubeadm init` commands and a freshly-generated token, then others with `kubeadm join`.
- **IPAM in-cluster provider** watches `IPAddressClaim` objects created by CAPV and hands out IPs from your `IPPool`.
- **CAPV** sees each `Machine` needs a `VSphereMachine` and starts planning the VM spec (template, folder, datastore, network, resource pool).

**4 — Provision.** CAPV makes the vCenter call. Using govmomi, it clones the OVA from your content library into the target folder, attaches the network with the static IP from IPAM baked into the cloud-init `metadata`, injects the bootstrap secret as cloud-init `userdata` via the VM's guestinfo interface, and powers it on. This is where most failures happen — wrong permissions on the vSphere user, wrong folder path, missing OVA template, or network reachability from the CAPV pod to vCenter.

**5 — Bootstrap.** The VM boots, cloud-init runs, and the kubeadm commands execute:
- First control-plane node: `kubeadm init` brings up etcd and the API server. kube-vip runs as a static pod on every control-plane node, advertising the control-plane VIP via ARP or BGP. The workload cluster's API is now reachable at the VIP.
- Remaining control-plane nodes: `kubeadm join --control-plane` — etcd and API server scale out.
- Worker nodes (from `MachineDeployment`): `kubeadm join` — they register with the API server but stay `NotReady` because there's no CNI yet.

CAPV watches each VM's cloud-init status via vCenter's guest OS agent and updates `Machine.status.ready`.

**6 — Install addons.** Once the workload cluster's API is up, CAPI writes a `Secret` named `<cluster>-kubeconfig` into the management cluster. This is the handoff point. Whatever addon mechanism you chose picks it up:
- With **CAAPH**, a `HelmChartProxy` matching the cluster's labels installs Cilium, then vSphere CPI (needed for node `ProviderID` — nodes stay `uninitialized` until this runs), then vSphere CSI.
- With **ArgoCD ApplicationSets**, the cluster generator discovers the new kubeconfig secret and fans out your Helm/manifest apps targeted at the new cluster.

Cilium lands first, nodes flip to `Ready`, then CPI/CSI follow. Ordering matters — don't let CPI race Cilium.

**7 — Cluster ready.** `Cluster.status.phase = Provisioned`, all `Machine` objects show `Running`, nodes are `Ready`, and workload ArgoCD Applications targeted at the new cluster begin to sync.

Two operational details worth pinning down early:

- **The management cluster holds the "source of truth" for every workload cluster it built.** If the management cluster's etcd is lost and you don't have Velero backups of the CAPI CRDs + kubeconfig secrets, the workload clusters keep running but become orphaned — no scaling, no upgrades, no node repair. This is why Velero isn't optional.
- **Day-2 operations use the exact same flow in reverse.** Bumping `KubeadmControlPlane.spec.version` triggers a rolling replace: CAPV provisions a new VM with the new OVA, kubeadm joins it, the old one is cordoned/drained/deleted. You get rolling upgrades for free as long as you've built OVAs for the target version and put them in the content library.
