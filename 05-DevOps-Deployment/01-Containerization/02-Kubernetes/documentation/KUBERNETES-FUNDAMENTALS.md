# Kubernetes Fundamentals

## 📚 Overview

Kubernetes (K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It provides a robust framework for running distributed systems resiliently.

## 🎯 What is Kubernetes?

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services. It facilitates both declarative configuration and automation, making it ideal for managing complex distributed applications.

### Key Concepts

- **Cluster**: A set of nodes that run containerized applications
- **Node**: A worker machine (physical or virtual) in Kubernetes
- **Pod**: The smallest deployable unit, containing one or more containers
- **Service**: An abstraction that defines a logical set of pods and a policy to access them
- **Deployment**: Manages a set of identical pods
- **Namespace**: Virtual cluster for organizing resources

### Benefits

1. **Service Discovery**: Automatic service discovery and load balancing
2. **Storage Orchestration**: Automatic mounting of storage systems
3. **Self-Healing**: Automatic restart, replacement, and rescheduling
4. **Secret Management**: Manage sensitive information
5. **Horizontal Scaling**: Scale applications up or down automatically
6. **Rolling Updates**: Update applications with zero downtime

## 🚀 Installation

### Using Minikube (Local Development)

```bash
# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube
minikube start

# Verify installation
kubectl get nodes
```

### Using kubeadm (Production)

```bash
# On master node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Join worker nodes
kubectl join <master-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>
```

### Cloud Providers

```bash
# Google Kubernetes Engine (GKE)
gcloud container clusters create my-cluster

# Amazon EKS
eksctl create cluster --name my-cluster

# Azure AKS
az aks create --resource-group myResourceGroup --name myCluster
```

## 🔧 kubectl Basics

### Installation

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client
```

### Basic Commands

```bash
# Get cluster information
kubectl cluster-info

# Get nodes
kubectl get nodes

# Get all resources
kubectl get all

# Get pods
kubectl get pods

# Get pods in namespace
kubectl get pods -n kube-system

# Describe resource
kubectl describe pod <pod-name>

# Get logs
kubectl logs <pod-name>

# Execute command in pod
kubectl exec -it <pod-name> -- /bin/sh
```

## 📦 Pods

### Create Pod

```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
```

```bash
# Create pod
kubectl apply -f pod.yaml

# Get pod
kubectl get pod nginx-pod

# Describe pod
kubectl describe pod nginx-pod

# Delete pod
kubectl delete pod nginx-pod
```

### Multi-Container Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
  - name: sidecar
    image: busybox
    command: ['sh', '-c', 'while true; do echo sidecar; sleep 5; done']
```

## 🔄 Deployments

### Create Deployment

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
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
        ports:
        - containerPort: 80
```

```bash
# Create deployment
kubectl apply -f deployment.yaml

# Get deployments
kubectl get deployments

# Scale deployment
kubectl scale deployment nginx-deployment --replicas=5

# Update deployment
kubectl set image deployment/nginx-deployment nginx=nginx:1.21

# Rollout status
kubectl rollout status deployment/nginx-deployment

# Rollback
kubectl rollout undo deployment/nginx-deployment
```

## 🌐 Services

### ClusterIP Service

```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```

### NodePort Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
```

### LoadBalancer Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-loadbalancer
spec:
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
```

## 📁 Namespaces

### Create Namespace

```bash
# Create namespace
kubectl create namespace production
kubectl create namespace development

# Get namespaces
kubectl get namespaces

# Create resource in namespace
kubectl apply -f deployment.yaml -n production

# Switch namespace context
kubectl config set-context --current --namespace=production
```

### Namespace YAML

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    name: production
```

## 🔍 Resource Management

### Resource Requests and Limits

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

## 🎯 Best Practices

1. **Use Deployments**: Don't create Pods directly
2. **Set Resource Limits**: Prevent resource exhaustion
3. **Use Namespaces**: Organize resources
4. **Health Checks**: Use liveness and readiness probes
5. **Labels**: Use consistent labeling strategy
6. **ConfigMaps and Secrets**: Externalize configuration
7. **Service Discovery**: Use Services for pod communication

## 🎓 Learning Resources

- Kubernetes Documentation: https://kubernetes.io/docs/
- Kubernetes Tutorials: https://kubernetes.io/docs/tutorials/
- kubectl Cheat Sheet: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

---

**Next**: Learn about [Pods & Services](./PODS-SERVICES.md)

