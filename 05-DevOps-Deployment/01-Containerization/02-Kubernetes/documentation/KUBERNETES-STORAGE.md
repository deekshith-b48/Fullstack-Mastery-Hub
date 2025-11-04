# Kubernetes Storage

## 📚 Overview

Kubernetes storage provides persistent data storage for applications. Understanding storage concepts like volumes, persistent volumes, and storage classes is essential for stateful applications.

## 💾 Volumes

### Volume Types

#### EmptyDir

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: cache
      mountPath: /cache
  volumes:
  - name: cache
    emptyDir: {}
```

#### HostPath

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: host-data
      mountPath: /data
  volumes:
  - name: host-data
    hostPath:
      path: /mnt/data
      type: DirectoryOrCreate
```

#### ConfigMap Volume

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  config.yaml: |
    key: value
---
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: config
      mountPath: /etc/config
  volumes:
  - name: config
    configMap:
      name: app-config
```

#### Secret Volume

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  password: cGFzc3dvcmQxMjM=  # base64 encoded
---
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: secret
      mountPath: /etc/secret
      readOnly: true
  volumes:
  - name: secret
    secret:
      secretName: app-secret
```

## 🔄 Persistent Volumes

### PersistentVolume (PV)

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-volume
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data
```

### PersistentVolumeClaim (PVC)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: manual
```

### Using PVC in Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: pvc-claim
```

## 📊 Storage Classes

### StorageClass Definition

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  iops: "3000"
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

### Dynamic Provisioning

```yaml
# PVC with storage class
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: fast-ssd
  resources:
    requests:
      storage: 10Gi
```

### Volume Binding Modes

- **Immediate**: Volume created immediately
- **WaitForFirstConsumer**: Volume created when pod is scheduled

## 🔄 StatefulSets

### StatefulSet with Persistent Storage

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: fast-ssd
      resources:
        requests:
          storage: 1Gi
```

## 📁 Volume Modes

### Filesystem Mode (Default)

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: fs-pv
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  # ...
```

### Block Mode

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: block-pv
spec:
  capacity:
    storage: 10Gi
  volumeMode: Block
  accessModes:
    - ReadWriteOnce
  # ...
```

## 🔐 Volume Security

### SELinux Context

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: selinux-pod
spec:
  containers:
  - name: app
    image: nginx
    securityContext:
      seLinuxOptions:
        level: "s0:c123,c456"
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: pvc-claim
```

### fsGroup

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: fsgroup-pod
spec:
  securityContext:
    fsGroup: 2000
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: pvc-claim
```

## 🔄 Volume Expansion

### Allow Volume Expansion

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: expandable-storage
allowVolumeExpansion: true
provisioner: kubernetes.io/aws-ebs
```

### Expand PVC

```bash
# Edit PVC to increase size
kubectl edit pvc my-pvc
# Change storage: 10Gi to 20Gi

# Or patch
kubectl patch pvc my-pvc -p '{"spec":{"resources":{"requests":{"storage":"20Gi"}}}}'
```

## 📊 Storage Provisioners

### Local Storage

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

### Cloud Storage

```yaml
# AWS EBS
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
  iops: "3000"

# GCE Persistent Disk
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gce-pd
provisioner: pd.csi.storage.gke.io
parameters:
  type: pd-ssd

# Azure Disk
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: azure-disk
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
```

## 🎯 Best Practices

1. **Use StorageClasses**: For dynamic provisioning
2. **StatefulSets**: For stateful applications
3. **Backup Strategy**: Regular backups of persistent volumes
4. **Resource Limits**: Set appropriate storage limits
5. **Access Modes**: Choose correct access modes
6. **Reclaim Policy**: Set appropriate reclaim policy
7. **Volume Expansion**: Enable when needed

## 🔍 Troubleshooting

### Storage Issues

```bash
# Check PVs
kubectl get pv

# Check PVCs
kubectl get pvc

# Describe PVC
kubectl describe pvc my-pvc

# Check storage classes
kubectl get storageclass

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp
```

### Common Issues

1. **Pending PVC**: No available PV or storage class
2. **Mount errors**: Check node capabilities
3. **Permission errors**: Check fsGroup and SELinux
4. **Storage full**: Expand volumes or clean up

## 🎓 Learning Resources

- Kubernetes Storage: https://kubernetes.io/docs/concepts/storage/
- Persistent Volumes: https://kubernetes.io/docs/concepts/storage/persistent-volumes/
- StatefulSets: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

---

**Next**: Learn about [Cluster Management](./CLUSTER-MANAGEMENT.md)

