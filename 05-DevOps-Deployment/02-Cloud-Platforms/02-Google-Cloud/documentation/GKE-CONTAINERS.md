# Google Kubernetes Engine (GKE)

## 📚 Overview

Google Kubernetes Engine (GKE) is a managed Kubernetes service for deploying, managing, and scaling containerized applications. GKE provides a production-ready Kubernetes environment.

## 🎯 GKE Fundamentals

### Key Features

- **Managed Kubernetes**: Fully managed control plane
- **Auto-scaling**: Automatic node and pod scaling
- **Auto-repair**: Automatic node health monitoring
- **Auto-upgrade**: Automatic Kubernetes version updates
- **Multi-cluster**: Deploy across multiple clusters

## 🚀 Creating Clusters

### Standard Cluster

```bash
# Create standard cluster
gcloud container clusters create my-cluster \
  --zone=us-east1-b \
  --num-nodes=3 \
  --machine-type=e2-medium \
  --enable-autorepair \
  --enable-autoupgrade

# Create with custom configuration
gcloud container clusters create my-cluster \
  --zone=us-east1-b \
  --num-nodes=3 \
  --machine-type=e2-medium \
  --disk-size=50GB \
  --disk-type=pd-ssd \
  --enable-autorepair \
  --enable-autoupgrade \
  --enable-autoscaling \
  --min-nodes=1 \
  --max-nodes=10
```

### Regional Cluster

```bash
# Create regional cluster
gcloud container clusters create my-regional-cluster \
  --region=us-east1 \
  --num-nodes=3 \
  --machine-type=e2-medium \
  --enable-autorepair \
  --enable-autoupgrade
```

### Autopilot Cluster

```bash
# Create Autopilot cluster
gcloud container clusters create-auto my-autopilot-cluster \
  --region=us-east1
```

## 🔧 Cluster Management

### Cluster Operations

```bash
# List clusters
gcloud container clusters list

# Get cluster credentials
gcloud container clusters get-credentials my-cluster --zone=us-east1-b

# Describe cluster
gcloud container clusters describe my-cluster --zone=us-east1-b

# Update cluster
gcloud container clusters update my-cluster \
  --zone=us-east1-b \
  --num-nodes=5

# Delete cluster
gcloud container clusters delete my-cluster --zone=us-east1-b
```

### Node Pools

```bash
# Create node pool
gcloud container node-pools create my-pool \
  --cluster=my-cluster \
  --zone=us-east1-b \
  --num-nodes=3 \
  --machine-type=e2-medium \
  --enable-autoscaling \
  --min-nodes=1 \
  --max-nodes=10

# List node pools
gcloud container node-pools list --cluster=my-cluster --zone=us-east1-b

# Delete node pool
gcloud container node-pools delete my-pool \
  --cluster=my-cluster \
  --zone=us-east1-b
```

## 🔄 Auto-Scaling

### Cluster Autoscaler

```bash
# Enable cluster autoscaler
gcloud container clusters create my-cluster \
  --enable-autoscaling \
  --min-nodes=1 \
  --max-nodes=10 \
  --zone=us-east1-b
```

### Pod Autoscaling

```yaml
# Horizontal Pod Autoscaler
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

## 🔐 Security

### Workload Identity

```bash
# Enable workload identity
gcloud container clusters update my-cluster \
  --workload-pool=PROJECT_ID.svc.id.goog \
  --zone=us-east1-b

# Create service account
gcloud iam service-accounts create ksa-sa \
  --display-name="KSA Service Account"

# Bind service account
gcloud iam service-accounts add-iam-policy-binding \
  ksa-sa@PROJECT_ID.iam.gserviceaccount.com \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:PROJECT_ID.svc.id.goog[default/ksa]"
```

### Network Policies

```bash
# Enable network policy
gcloud container clusters create my-cluster \
  --enable-network-policy \
  --zone=us-east1-b
```

## 📊 Monitoring

### Cloud Monitoring

```bash
# Enable monitoring
gcloud container clusters update my-cluster \
  --enable-monitoring \
  --zone=us-east1-b
```

## 🎯 Best Practices

1. **Use Regional Clusters**: For high availability
2. **Enable Auto-scaling**: For variable workloads
3. **Workload Identity**: Use for service accounts
4. **Network Policies**: Implement network security
5. **Monitoring**: Enable monitoring and logging
6. **Regular Updates**: Keep clusters updated
7. **Resource Limits**: Set appropriate limits

## 🎓 Learning Resources

- GKE Documentation: https://cloud.google.com/kubernetes-engine/docs
- Best Practices: https://cloud.google.com/kubernetes-engine/docs/best-practices
- GKE: https://cloud.google.com/kubernetes-engine

---

**Next**: Learn about [Load Balancing](./LOAD-BALANCING.md)

