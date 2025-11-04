# Kubernetes Networking

## 📚 Overview

Kubernetes networking enables pods to communicate with each other and with external services. Understanding Kubernetes networking is essential for building distributed applications and managing service communication.

## 🎯 Network Model

### Kubernetes Network Requirements

1. **Pod-to-Pod Communication**: All pods can communicate without NAT
2. **Node-to-Pod Communication**: Nodes can communicate with all pods
3. **Service Discovery**: Pods can discover services via DNS
4. **Load Balancing**: Services provide load balancing

### Network Plugins

- **CNI (Container Network Interface)**: Standard interface for network plugins
- **Flannel**: Simple overlay network
- **Calico**: Policy-driven networking
- **Weave**: Multi-host networking
- **Cilium**: eBPF-based networking

## 🌐 Services

### Service Types Recap

```yaml
# ClusterIP (default)
apiVersion: v1
kind: Service
metadata:
  name: clusterip-service
spec:
  type: ClusterIP
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
```

```yaml
# NodePort
apiVersion: v1
kind: Service
metadata:
  name: nodeport-service
spec:
  type: NodePort
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080
```

```yaml
# LoadBalancer
apiVersion: v1
kind: Service
metadata:
  name: loadbalancer-service
spec:
  type: LoadBalancer
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
```

## 🔗 Ingress

### Ingress Controller

Ingress provides HTTP and HTTPS routing to services based on host and path rules.

```yaml
# Basic Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

### Multiple Paths

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: multi-path-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: example.com
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 8080
      - path: /web
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

### TLS/SSL

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - example.com
    secretName: tls-secret
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

### Ingress Annotations

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: annotated-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

## 🔐 Network Policies

### Network Policy Basics

Network policies control traffic flow between pods and namespaces.

```yaml
# Deny all ingress
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

### Allow Specific Ingress

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-specific-ingress
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api
    ports:
    - protocol: TCP
      port: 80
```

### Allow Egress

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-egress
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: api
    ports:
    - protocol: TCP
      port: 8080
```

### Namespace Isolation

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: namespace-isolation
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: frontend
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: backend
```

## 🔍 DNS

### Service DNS

```bash
# Service DNS format
<service-name>.<namespace>.svc.cluster.local

# Examples
my-service.default.svc.cluster.local
my-service.production.svc.cluster.local

# Short forms (same namespace)
my-service

# Cross-namespace
my-service.other-namespace.svc.cluster.local
```

### CoreDNS Configuration

```yaml
# CoreDNS ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
        forward . /etc/resolv.conf {
           max_concurrent 1000
        }
        cache 30
        loop
        reload
        loadbalance
    }
```

## 🌍 External Access

### Port Forwarding

```bash
# Forward local port to pod
kubectl port-forward pod/my-pod 8080:80

# Forward to service
kubectl port-forward svc/my-service 8080:80

# Forward to deployment
kubectl port-forward deployment/my-deployment 8080:80
```

### External Services

```yaml
# External service endpoint
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

### Endpoints

```yaml
# Manual endpoints
apiVersion: v1
kind: Endpoints
metadata:
  name: external-service
subsets:
- addresses:
  - ip: 192.168.1.100
  ports:
  - port: 80
---
apiVersion: v1
kind: Service
metadata:
  name: external-service
spec:
  ports:
  - port: 80
```

## 🔄 Service Mesh

### Istio

```yaml
# VirtualService
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service
  http:
  - match:
    - headers:
        version:
          exact: v1
    route:
    - destination:
        host: my-service
        subset: v1
  - route:
    - destination:
        host: my-service
        subset: v2
```

### Linkerd

```yaml
# ServiceProfile
apiVersion: linkerd.io/v1alpha2
kind: ServiceProfile
metadata:
  name: my-service
spec:
  routes:
  - name: default
    condition:
      pathRegex: "/.*"
    isRetryable: true
    timeout: 30s
```

## 🎯 Best Practices

1. **Use Services**: Don't connect pods directly
2. **Network Policies**: Implement network segmentation
3. **DNS**: Use service DNS for discovery
4. **Ingress**: Use Ingress for HTTP/HTTPS routing
5. **TLS**: Enable TLS for external traffic
6. **Load Balancing**: Leverage service load balancing
7. **Monitoring**: Monitor network metrics

## 🔍 Troubleshooting

### Network Debugging

```bash
# Check service endpoints
kubectl get endpoints my-service

# Test service connectivity
kubectl run test-pod --image=busybox --rm -it -- wget -qO- http://my-service

# Check DNS resolution
kubectl run test-pod --image=busybox --rm -it -- nslookup my-service

# Check network policies
kubectl get networkpolicies

# Describe network policy
kubectl describe networkpolicy my-policy
```

### Common Issues

1. **Service not accessible**: Check selectors and endpoints
2. **DNS not resolving**: Check CoreDNS
3. **Network policy blocking**: Review network policies
4. **Ingress not working**: Check ingress controller

## 🎓 Learning Resources

- Kubernetes Networking: https://kubernetes.io/docs/concepts/services-networking/
- Network Policies: https://kubernetes.io/docs/concepts/services-networking/network-policies/
- Ingress: https://kubernetes.io/docs/concepts/services-networking/ingress/

---

**Next**: Learn about [Kubernetes Storage](./KUBERNETES-STORAGE.md)

