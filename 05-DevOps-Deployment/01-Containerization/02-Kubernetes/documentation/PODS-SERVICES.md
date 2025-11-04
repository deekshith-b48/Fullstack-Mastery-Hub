# Kubernetes Pods & Services

## 📚 Overview

Pods are the smallest deployable units in Kubernetes, while Services provide stable network endpoints for pods. Understanding pods and services is fundamental to Kubernetes application deployment.

## 📦 Pods Deep Dive

### Pod Lifecycle

1. **Pending**: Pod accepted but not scheduled
2. **Running**: Pod bound to node, containers running
3. **Succeeded**: All containers terminated successfully
4. **Failed**: At least one container terminated in failure
5. **Unknown**: Pod state cannot be determined

### Pod States

```bash
# Get pod status
kubectl get pods

# Detailed pod status
kubectl describe pod <pod-name>

# Watch pod status
kubectl get pods -w
```

### Basic Pod Definition

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: myapp
    version: v1
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
      protocol: TCP
    env:
    - name: ENV_VAR
      value: "value"
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

### Multi-Container Pods

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
    command: ['sh', '-c', 'while true; do echo logging; sleep 5; done']
  - name: init-container
    image: busybox
    command: ['sh', '-c', 'echo Initializing...']
```

### Init Containers

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-pod
spec:
  initContainers:
  - name: init-db
    image: busybox
    command: ['sh', '-c', 'until nslookup db-service; do echo waiting for db; sleep 2; done']
  containers:
  - name: app
    image: myapp:latest
```

### Pod Health Checks

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: healthcheck-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    livenessProbe:
      httpGet:
        path: /health
        port: 80
      initialDelaySeconds: 30
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 3
    readinessProbe:
      httpGet:
        path: /ready
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5
```

### Pod Security Context

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: nginx
    image: nginx:alpine
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
```

## 🌐 Services

### Service Types

#### ClusterIP (Default)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
  type: ClusterIP
```

#### NodePort

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nodeport-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080
  type: NodePort
```

#### LoadBalancer

```yaml
apiVersion: v1
kind: Service
metadata:
  name: loadbalancer-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
  type: LoadBalancer
```

#### ExternalName

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-service
spec:
  type: ExternalName
  externalName: external.example.com
  ports:
  - port: 80
```

### Headless Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: headless-service
spec:
  selector:
    app: myapp
  clusterIP: None  # Headless service
  ports:
  - port: 80
    targetPort: 8080
```

### Service Discovery

```bash
# Service DNS format
<service-name>.<namespace>.svc.cluster.local

# Example
my-service.default.svc.cluster.local

# Short form (same namespace)
my-service
```

### Session Affinity

```yaml
apiVersion: v1
kind: Service
metadata:
  name: sticky-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
```

## 🔗 Pod-Service Communication

### Internal Communication

```yaml
# Pod can access service by name
apiVersion: v1
kind: Pod
metadata:
  name: client-pod
spec:
  containers:
  - name: curl
    image: curlimages/curl
    command: ['sh', '-c', 'curl http://my-service:80']
```

### Endpoints

```bash
# Get service endpoints
kubectl get endpoints my-service

# Endpoints automatically managed
# Updated when pods are created/destroyed
```

## 📊 Service Examples

### Web Application Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  labels:
    app: web
spec:
  selector:
    app: web
    tier: frontend
  ports:
  - name: http
    port: 80
    targetPort: 8080
    protocol: TCP
  - name: https
    port: 443
    targetPort: 8443
    protocol: TCP
  type: LoadBalancer
```

### Database Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: db-service
  labels:
    app: database
spec:
  selector:
    app: database
    tier: backend
  ports:
  - port: 5432
    targetPort: 5432
    protocol: TCP
  type: ClusterIP  # Internal only
```

## 🎯 Best Practices

### Pod Best Practices

1. **Use Deployments**: Don't create pods directly
2. **Resource Limits**: Always set requests and limits
3. **Health Checks**: Use liveness and readiness probes
4. **Labels**: Use consistent labeling
5. **Security**: Run as non-root user
6. **One Process**: One primary process per container

### Service Best Practices

1. **Use Selectors**: Match pod labels correctly
2. **Port Naming**: Name ports for clarity
3. **Service Type**: Choose appropriate type
4. **DNS**: Use service DNS for discovery
5. **Session Affinity**: Use when needed
6. **Headless Services**: For stateful applications

## 🔍 Troubleshooting

### Pod Issues

```bash
# Check pod status
kubectl get pods

# Describe pod for events
kubectl describe pod <pod-name>

# Check pod logs
kubectl logs <pod-name>

# Execute in pod
kubectl exec -it <pod-name> -- /bin/sh
```

### Service Issues

```bash
# Check service
kubectl get svc

# Describe service
kubectl describe svc <service-name>

# Check endpoints
kubectl get endpoints <service-name>

# Test service connectivity
kubectl run test-pod --image=busybox --rm -it -- wget -qO- http://<service-name>
```

## 📚 Learning Resources

- Pods: https://kubernetes.io/docs/concepts/workloads/pods/
- Services: https://kubernetes.io/docs/concepts/services-networking/service/

---

**Next**: Learn about [Deployment Strategies](./DEPLOYMENTS-STRATEGIES.md)

