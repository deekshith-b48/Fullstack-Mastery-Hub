# Azure Kubernetes Service (AKS)

## 📚 Overview

Azure Kubernetes Service (AKS) is a managed Kubernetes service that simplifies deploying and managing containerized applications. AKS provides a production-ready Kubernetes environment.

## 🎯 AKS Fundamentals

### Key Features

- **Managed Control Plane**: Fully managed Kubernetes control plane
- **Auto-scaling**: Automatic node and pod scaling
- **Auto-upgrade**: Automatic Kubernetes version updates
- **Integration**: Integrated with Azure services
- **Security**: Built-in security features

## 🚀 Creating AKS Cluster

### Create Cluster

```bash
# Create AKS cluster
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 3 \
  --enable-addons monitoring \
  --generate-ssh-keys

# Create with specific configuration
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 3 \
  --node-vm-size Standard_B2s \
  --enable-addons monitoring \
  --enable-managed-identity \
  --generate-ssh-keys
```

### Node Pools

```bash
# Create additional node pool
az aks nodepool add \
  --resource-group myResourceGroup \
  --cluster-name myAKSCluster \
  --name mynodepool \
  --node-count 3 \
  --node-vm-size Standard_B2s \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 10
```

## 🔧 Cluster Management

### Cluster Operations

```bash
# List clusters
az aks list

# Get cluster credentials
az aks get-credentials \
  --resource-group myResourceGroup \
  --name myAKSCluster

# Get cluster details
az aks show \
  --resource-group myResourceGroup \
  --name myAKSCluster

# Scale cluster
az aks scale \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 5

# Upgrade cluster
az aks upgrade \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --kubernetes-version 1.28.0

# Delete cluster
az aks delete \
  --resource-group myResourceGroup \
  --name myAKSCluster
```

## 🔄 Auto-Scaling

### Cluster Autoscaler

```bash
# Enable cluster autoscaler
az aks nodepool update \
  --resource-group myResourceGroup \
  --cluster-name myAKSCluster \
  --name agentpool \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 10
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

### Managed Identity

```bash
# Create cluster with managed identity
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --enable-managed-identity
```

### Azure AD Integration

```bash
# Enable Azure AD integration
az aks update \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --enable-aad
```

### Network Policies

```bash
# Enable network policy
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --network-policy azure
```

## 📊 Monitoring

### Azure Monitor

```bash
# Enable monitoring
az aks enable-addons \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --addons monitoring
```

## 🎯 Best Practices

1. **Use Managed Identity**: For service authentication
2. **Enable Auto-scaling**: For variable workloads
3. **Network Policies**: Implement network security
4. **Monitoring**: Enable Azure Monitor
5. **Regular Updates**: Keep cluster updated
6. **Resource Limits**: Set appropriate limits
7. **Backup**: Regular backups

## 🎓 Learning Resources

- AKS Documentation: https://docs.microsoft.com/azure/aks/
- Best Practices: https://docs.microsoft.com/azure/aks/best-practices
- AKS: https://azure.microsoft.com/services/kubernetes-service/

---

**Next**: Learn about [Azure CDN](./AZURE-CDN.md)

