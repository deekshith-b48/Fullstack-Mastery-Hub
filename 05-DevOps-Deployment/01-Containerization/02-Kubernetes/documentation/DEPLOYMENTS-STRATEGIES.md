# Kubernetes Deployment Strategies

## 📚 Overview

Kubernetes deployments manage the desired state of pods and replica sets. Understanding deployment strategies is crucial for achieving zero-downtime updates and reliable application rollouts.

## 🔄 Deployment Basics

### Creating Deployments

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
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
        image: nginx:1.21
        ports:
        - containerPort: 80
```

### Deployment Commands

```bash
# Create deployment
kubectl apply -f deployment.yaml

# Get deployments
kubectl get deployments

# Get deployment status
kubectl rollout status deployment/nginx-deployment

# View deployment history
kubectl rollout history deployment/nginx-deployment

# Scale deployment
kubectl scale deployment nginx-deployment --replicas=5

# Update deployment
kubectl set image deployment/nginx-deployment nginx=nginx:1.22

# Rollback deployment
kubectl rollout undo deployment/nginx-deployment

# Rollback to specific revision
kubectl rollout undo deployment/nginx-deployment --to-revision=2
```

## 🎯 Deployment Strategies

### Rolling Update (Default)

Rolling update gradually replaces old pods with new ones, ensuring zero downtime.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-deployment
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2          # Max pods above desired
      maxUnavailable: 1   # Max pods unavailable
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:v2
        ports:
        - containerPort: 8080
```

### Recreate Strategy

Recreate strategy terminates all old pods before creating new ones, causing downtime.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recreate-deployment
spec:
  replicas: 3
  strategy:
    type: Recreate  # All old pods terminated first
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:v2
```

### Blue-Green Deployment

Blue-green deployment maintains two identical production environments.

```yaml
# Blue deployment (current)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue-deployment
  labels:
    version: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: app
        image: myapp:v1
---
# Green deployment (new)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: green-deployment
  labels:
    version: green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: green
  template:
    metadata:
      labels:
        app: myapp
        version: green
    spec:
      containers:
      - name: app
        image: myapp:v2
---
# Service switching between blue and green
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
    version: blue  # Switch to green when ready
  ports:
  - port: 80
    targetPort: 8080
```

### Canary Deployment

Canary deployment gradually rolls out changes to a subset of users.

```yaml
# Stable deployment (90%)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: stable-deployment
spec:
  replicas: 9
  selector:
    matchLabels:
      app: myapp
      track: stable
  template:
    metadata:
      labels:
        app: myapp
        track: stable
    spec:
      containers:
      - name: app
        image: myapp:v1
---
# Canary deployment (10%)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: canary-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
      track: canary
  template:
    metadata:
      labels:
        app: myapp
        track: canary
    spec:
      containers:
      - name: app
        image: myapp:v2
---
# Service with both tracks
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
```

## 🔍 Advanced Deployment Features

### Deployment Conditions

```bash
# Check deployment conditions
kubectl get deployment nginx-deployment -o yaml

# Conditions indicate:
# - Progressing: Deployment is progressing
# - Available: Minimum replicas available
# - ReplicaFailure: Replica creation failed
```

### Progress Deadlines

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: timed-deployment
spec:
  progressDeadlineSeconds: 600  # 10 minutes
  replicas: 3
  # ... rest of deployment
```

### Pausing and Resuming

```bash
# Pause deployment
kubectl rollout pause deployment/nginx-deployment

# Make multiple changes
kubectl set image deployment/nginx-deployment nginx=nginx:1.22
kubectl set resources deployment/nginx-deployment -c nginx --limits=cpu=200m,memory=512Mi

# Resume deployment
kubectl rollout resume deployment/nginx-deployment
```

## 📊 Deployment Status

### Monitoring Rollout

```bash
# Watch deployment status
kubectl rollout status deployment/nginx-deployment

# Get deployment details
kubectl describe deployment nginx-deployment

# View rollout history
kubectl rollout history deployment/nginx-deployment

# View specific revision
kubectl rollout history deployment/nginx-deployment --revision=2
```

### Rollback Scenarios

```bash
# Rollback to previous version
kubectl rollout undo deployment/nginx-deployment

# Rollback to specific revision
kubectl rollout undo deployment/nginx-deployment --to-revision=3

# View rollback status
kubectl rollout status deployment/nginx-deployment
```

## 🎯 Best Practices

### Deployment Configuration

1. **Set Replicas**: Define appropriate replica count
2. **Resource Limits**: Set requests and limits
3. **Health Checks**: Use liveness and readiness probes
4. **Labels**: Use consistent labeling strategy
5. **Annotations**: Add deployment metadata
6. **Update Strategy**: Choose appropriate strategy
7. **Progress Deadline**: Set reasonable deadlines

### Update Strategy Best Practices

1. **Rolling Updates**: Default for most applications
2. **Max Surge/Unavailable**: Balance availability and speed
3. **Readiness Probes**: Ensure pods are ready before traffic
4. **Gradual Rollout**: Test canary deployments first
5. **Rollback Plan**: Always have rollback procedure ready

## 🔧 Troubleshooting

### Deployment Issues

```bash
# Check deployment status
kubectl get deployment

# Describe deployment events
kubectl describe deployment <deployment-name>

# Check replica sets
kubectl get rs

# Check pods
kubectl get pods -l app=myapp

# View deployment events
kubectl get events --field-selector involvedObject.name=<deployment-name>
```

### Common Issues

1. **ImagePullBackOff**: Image not found or pull failed
2. **CrashLoopBackOff**: Container crashing repeatedly
3. **Pending**: Pods not scheduled
4. **Failed**: Deployment failed

### Debugging

```bash
# Check pod logs
kubectl logs <pod-name>

# Execute in pod
kubectl exec -it <pod-name> -- /bin/sh

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp
```

## 📈 Scaling Strategies

### Horizontal Scaling

```bash
# Manual scaling
kubectl scale deployment nginx-deployment --replicas=5

# Auto-scaling (HPA)
kubectl autoscale deployment nginx-deployment --min=2 --max=10 --cpu-percent=80
```

### Vertical Scaling

```yaml
# Update resource requests/limits
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scaled-deployment
spec:
  template:
    spec:
      containers:
      - name: app
        resources:
          requests:
            memory: "256Mi"
            cpu: "500m"
          limits:
            memory: "512Mi"
            cpu: "1000m"
```

## 🎓 Learning Resources

- Deployments: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
- Deployment Strategies: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy

---

**Next**: Learn about [Helm Charts](./HELM-CHARTS.md)

