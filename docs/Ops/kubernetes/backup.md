
# Kubernetes Cluster Backup

## Backup Kubernetes Resources

```bash
- kubectl get all      --all-namespaces -o yaml > cluster-backup.yaml
- kubectl get secrets  --all-namespaces -o yaml > secrets-backup.yaml
- kubectl get ns       --all-namespaces -o yaml > namespace-backup.yaml
```

## Backup Persistent Volumes (PVs)

```bash
- rsync -avz <source-directory> <backup-directory>
```

## ETCD Backup

### Create snapshot from current etcd

```bash
etcdctl snapshot save /var/lib/etcd/save_snap.db\
  --cert=/etc/ssl/etcd/ssl/admin-master.pem \
  --key=/etc/ssl/etcd/ssl/admin-master-key.pem \
  --cacert=/etc/ssl/etcd/ssl/ca.pem
```

### Watch the taken snapshot

```bash
etcdctl snapshot status --write-out=table save_snap.db \
  --cert=/etc/ssl/etcd/ssl/admin-master.pem  \
  --key=/etc/ssl/etcd/ssl/admin-master-key.pem  \
  --cacert=/etc/ssl/etcd/ssl/ca.pem
```

### Get the snapshot status

```bash
etcdutl snapshot status /etc/ssl/etcd/ssl/save_snap.db -w table
```

### Stop ApiServer for Kubelet auto-scheduling

```bash
mv /etc/kubernetes/manifests/kube-apiserver.yaml /tmp/
```

### Fetch config values from the etcd config file

```bash
etcdutl snapshot restore snapshot.db \
        --name m1 \
        --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
        --initial-cluster-token etcd-cluster-1 \
        --initial-advertise-peer-urls http://host1:2380
```

**Tips:** etcd config path maybe in `/etc/kubernetes/manifest/` or `/etc/etcd.conf`

**Note:** If you have more than one master nodes, you should restore to all etcd instance separately

> Master node 1

```bash
etcdutl snapshot restore snapshot.db \
        --name m1 \
        --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
        --initial-cluster-token etcd-cluster-1 \
        --initial-advertise-peer-urls http://host1:2380
```

> Master node 2

```bash
etcdutl snapshot restore snapshot.db \
        --name m2 \
        --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
        --initial-cluster-token etcd-cluster-1 \
        --initial-advertise-peer-urls http://host2:2380
```

> Master node 3

```bash
etcdutl snapshot restore snapshot.db \
        --name m3 \
        --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
        --initial-cluster-token etcd-cluster-1 \
        --initial-advertise-peer-urls http://host3:2380
```

### Next, start etcd with the new data directories

> Master node 1

```bash
etcd --name m1 \
     --listen-client-urls http://host1:2379 \
     --advertise-client-urls http://host1:2379 \
     --listen-peer-urls http://host1:2380 &
```

> Master node 2

```bash
etcd --name m2 \
     --listen-client-urls http://host2:2379 \
     --advertise-client-urls http://host2:2379 \
     --listen-peer-urls http://host2:2380 &
```

> Master node 3

```bash
etcd --name m3 \
     --listen-client-urls http://host3:2379 \
     --advertise-client-urls http://host3:2379 \
     --listen-peer-urls http://host3:2380 &
```

Reference links:

- [Save](https://etcd.io/docs/v3.5/tutorials/how-to-save-database/)
- [Restore](https://etcd.io/docs/v3.5/op-guide/recovery/)
