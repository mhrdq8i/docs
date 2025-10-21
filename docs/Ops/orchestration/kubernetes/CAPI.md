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
