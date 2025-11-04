# Kubernetes Best Practices

## 📚 Overview

Following Kubernetes best practices ensures efficient, secure, and maintainable cluster operations. This guide covers comprehensive best practices for Kubernetes development and operations.

## 🎯 Resource Management

### Resource Requests and Limits

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
  - name: app
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

### Resource Quotas

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    persistentvolumeclaims: "10"
```

## 🔒 Security Best Practices

### Pod Security

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: app
    image: nginx:alpine
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
```

### RBAC

```yaml
# Use least privilege
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

## 📝 Labeling Strategy

### Consistent Labels

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
    version: v1.0.0
    environment: production
    team: backend
spec:
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        version: v1.0.0
        environment: production
        team: backend
```

### Label Conventions

- **app**: Application name
- **version**: Application version
- **environment**: dev, staging, production
- **team**: Team responsible
- **component**: Component type (frontend, backend, db)

## 🔄 Deployment Best Practices

### Use Deployments

```yaml
# ✅ Good: Use Deployments
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
```

### Health Checks

```yaml
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: app
    image: nginx
    livenessProbe:
      httpGet:
        path: /health
        port: 80
      initialDelaySeconds: 30
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5
```

## 📊 Configuration Management

### ConfigMaps

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  config.yaml: |
    key: value
    environment: production
---
apiVersion: v1
kind: Pod
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

### Secrets

```yaml
# Use external secrets management
# Don't commit secrets to git
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
stringData:
  password: secret123
```

## 🌐 Networking Best Practices

### Use Services

```yaml
# Always use Services for pod communication
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - port: 80
    targetPort: 8080
```

### Network Policies

```yaml
# Implement network policies
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

## 💾 Storage Best Practices

### Use PersistentVolumes

```yaml
# Use PVCs for persistent data
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: fast-ssd
```

### StatefulSets for Stateful Apps

```yaml
# Use StatefulSets for stateful applications
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  serviceName: database
  replicas: 3
  # ...
```

## 🎯 Best Practices Checklist

### General

- [ ] Use Deployments instead of Pods
- [ ] Set resource requests and limits
- [ ] Use health checks
- [ ] Implement RBAC
- [ ] Use network policies
- [ ] Regular backups
- [ ] Monitor cluster health

### Security

- [ ] Run pods as non-root
- [ ] Use secrets management
- [ ] Scan images regularly
- [ ] Enable audit logging
- [ ] Network isolation
- [ ] Pod security policies

### Performance

- [ ] Set appropriate resource limits
- [ ] Use HPA for scaling
- [ ] Optimize images
- [ ] Monitor metrics
- [ ] Clean up resources

## 🎓 Learning Resources

- Kubernetes Best Practices: https://kubernetes.io/docs/concepts/cluster-administration/
- Security Best Practices: https://kubernetes.io/docs/concepts/security/
- Production Best Practices: https://kubernetes.io/docs/setup/best-practices/

---

**Kubernetes section complete!** Next: Learn about [AWS Fundamentals](./../../02-Cloud-Platforms/01-AWS/documentation/AWS-FUNDAMENTALS.md)

