# Kubernetes Cluster Management

## 📚 Overview

Managing Kubernetes clusters involves configuring nodes, monitoring cluster health, handling upgrades, and ensuring high availability. This guide covers comprehensive cluster management practices.

## 🏗️ Cluster Architecture

### Master Components

- **API Server**: Exposes Kubernetes API
- **etcd**: Distributed key-value store
- **Controller Manager**: Runs controllers
- **Scheduler**: Schedules pods to nodes

### Node Components

- **kubelet**: Agent running on each node
- **kube-proxy**: Network proxy for services
- **Container Runtime**: Runs containers (Docker, containerd, etc.)

### Cluster Setup

```bash
# Initialize cluster (kubeadm)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Join worker nodes
kubeadm join <master-ip>:6443 --token <token> \
  --discovery-token-ca-cert-hash <hash>
```

## 🔧 Node Management

### Node Operations

```bash
# Get nodes
kubectl get nodes

# Describe node
kubectl describe node <node-name>

# Cordon node (prevent scheduling)
kubectl cordon <node-name>

# Uncordon node
kubectl uncordon <node-name>

# Drain node (evict pods)
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

# Delete node
kubectl delete node <node-name>
```

### Node Labels and Taints

```bash
# Label node
kubectl label nodes <node-name> disktype=ssd

# Add taint
kubectl taint nodes <node-name> key=value:NoSchedule

# Remove taint
kubectl taint nodes <node-name> key:NoSchedule-

# View taints
kubectl describe node <node-name> | grep Taints
```

### Node Affinity

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: affinity-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        preference:
          matchExpressions:
          - key: zone
            operator: In
            values:
            - us-west-1
  containers:
  - name: app
    image: nginx
```

## 📊 Cluster Monitoring

### Cluster Health

```bash
# Check cluster status
kubectl cluster-info

# Check node status
kubectl get nodes -o wide

# Check system pods
kubectl get pods -n kube-system

# Check component status
kubectl get componentstatuses
```

### Resource Usage

```bash
# Node resources
kubectl top nodes

# Pod resources
kubectl top pods

# Resources by namespace
kubectl top pods --all-namespaces

# Detailed resource usage
kubectl describe node <node-name>
```

## 🔄 Cluster Upgrades

### Upgrade Strategy

1. **Backup**: Backup etcd and cluster state
2. **Master First**: Upgrade master nodes
3. **Workers**: Upgrade worker nodes
4. **Verify**: Verify cluster functionality

### kubeadm Upgrade

```bash
# Check upgrade plan
kubeadm upgrade plan

# Upgrade control plane
kubeadm upgrade apply v1.28.0

# Upgrade kubelet
sudo apt-get update
sudo apt-get install kubelet=1.28.0-00 kubeadm=1.28.0-00
sudo systemctl restart kubelet

# Upgrade worker nodes
kubeadm upgrade node
```

### Rolling Updates

```bash
# Update node by node
kubectl drain <node-name>
# Upgrade node
kubectl uncordon <node-name>
```

## 🔒 Security Management

### RBAC

```yaml
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### Pod Security Policies

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL
  volumes:
    - 'configMap'
    - 'emptyDir'
  runAsUser:
    rule: 'MustRunAsNonRoot'
  seLinux:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'RunAsAny'
```

## 📈 Scaling

### Horizontal Pod Autoscaling

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

### Cluster Autoscaling

```bash
# Enable cluster autoscaler
# Automatically adds/removes nodes based on demand
```

## 🔍 Troubleshooting

### Cluster Issues

```bash
# Check API server
kubectl cluster-info

# Check etcd
kubectl get pods -n kube-system | grep etcd

# Check kubelet
sudo systemctl status kubelet

# Check logs
kubectl logs -n kube-system <component-pod>
```

### Node Issues

```bash
# Check node status
kubectl get nodes

# Check node conditions
kubectl describe node <node-name>

# Check node resources
kubectl top node <node-name>

# Check node events
kubectl get events --field-selector involvedObject.name=<node-name>
```

## 🎯 Best Practices

1. **High Availability**: Multiple master nodes
2. **Backup etcd**: Regular etcd backups
3. **Node Management**: Proper labeling and taints
4. **Monitoring**: Comprehensive monitoring
5. **Upgrades**: Test upgrades in staging
6. **Security**: Implement RBAC and policies
7. **Resource Limits**: Set appropriate limits

## 📊 Cluster Maintenance

### Regular Tasks

1. **Monitor**: Check cluster health daily
2. **Backup**: Backup etcd regularly
3. **Updates**: Plan and execute upgrades
4. **Cleanup**: Remove unused resources
5. **Security**: Review and update security policies

### Backup Procedures

```bash
# Backup etcd
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Restore etcd
ETCDCTL_API=3 etcdctl snapshot restore /backup/etcd-snapshot.db
```

## 🎓 Learning Resources

- Cluster Administration: https://kubernetes.io/docs/tasks/administer-cluster/
- Upgrading Clusters: https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
- Node Management: https://kubernetes.io/docs/concepts/architecture/nodes/

---

**Next**: Learn about [Kubernetes Security](./KUBERNETES-SECURITY.md)

