# Kubernetes Security

## 📚 Overview

Kubernetes security is critical for protecting clusters and applications. This guide covers security best practices, authentication, authorization, network policies, and security hardening techniques.

## 🔐 Authentication

### Service Accounts

```yaml
# Create service account
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-serviceaccount
  namespace: default
---
# Use in pod
apiVersion: v1
kind: Pod
metadata:
  name: sa-pod
spec:
  serviceAccountName: my-serviceaccount
  containers:
  - name: app
    image: nginx
```

### RBAC (Role-Based Access Control)

```yaml
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
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
  namespace: default
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### ClusterRole

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin
rules:
- apiGroups: [""]
  resources: ["*"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-admin-binding
subjects:
- kind: User
  name: admin
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
```

## 🛡️ Pod Security

### Security Context

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
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: app
    image: nginx:alpine
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
        add:
        - NET_BIND_SERVICE
```

### Pod Security Standards

```yaml
# Pod Security Policy
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

### Pod Security Admission

```yaml
# Namespace with Pod Security
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

## 🔒 Secrets Management

### Creating Secrets

```bash
# From literal values
kubectl create secret generic my-secret \
  --from-literal=username=admin \
  --from-literal=password=secret123

# From file
kubectl create secret generic my-secret \
  --from-file=username=./username.txt \
  --from-file=password=./password.txt

# From YAML
kubectl create secret generic my-secret \
  --from-literal=username=admin \
  --from-literal=password=secret123 \
  --dry-run=client -o yaml | kubectl apply -f -
```

### Using Secrets

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: app
    image: nginx
    env:
    - name: USERNAME
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: username
    - name: PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: password
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secret
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: my-secret
```

### External Secrets

```yaml
# Use external secret management (e.g., HashiCorp Vault)
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: vault-secrets
spec:
  provider: vault
  parameters:
    vaultAddress: "https://vault.example.com"
    roleName: "my-role"
    objects: |
      - objectName: "secret"
        secretPath: "secret/data/myapp"
        secretKey: "password"
```

## 🌐 Network Security

### Network Policies

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

```yaml
# Allow specific ingress
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress
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

### Egress Policies

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
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: UDP
      port: 53
```

## 🔐 TLS/SSL

### TLS Secrets

```bash
# Create TLS secret
kubectl create secret tls tls-secret \
  --cert=./tls.crt \
  --key=./tls.key
```

### Ingress TLS

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
spec:
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

## 🔍 Security Scanning

### Image Scanning

```bash
# Scan images for vulnerabilities
trivy image nginx:alpine

# Scan Kubernetes cluster
kubectl-scan scan

# Scan with Snyk
snyk test --docker nginx:alpine
```

### Runtime Security

```yaml
# Falco for runtime security
apiVersion: v1
kind: ConfigMap
metadata:
  name: falco-config
data:
  falco.yaml: |
    rules_file:
      - /etc/falco/falco_rules.yaml
    # Runtime security monitoring
```

## 🎯 Security Best Practices

### General Security

1. **RBAC**: Implement least privilege
2. **Network Policies**: Restrict network access
3. **Secrets**: Use proper secrets management
4. **Image Scanning**: Scan all images
5. **Pod Security**: Use security contexts
6. **Updates**: Keep Kubernetes updated
7. **Audit Logging**: Enable audit logs

### Hardening Checklist

- [ ] Enable RBAC
- [ ] Use network policies
- [ ] Implement pod security policies
- [ ] Scan images regularly
- [ ] Use secrets management
- [ ] Enable audit logging
- [ ] Restrict API server access
- [ ] Use TLS everywhere
- [ ] Regular security updates
- [ ] Monitor for vulnerabilities

## 🔄 Security Updates

### Updating Kubernetes

```bash
# Check current version
kubectl version

# Plan upgrade
kubeadm upgrade plan

# Execute upgrade
kubeadm upgrade apply v1.28.0
```

### Updating Container Images

```bash
# Update deployment images
kubectl set image deployment/my-deployment nginx=nginx:1.23

# Or update in YAML
kubectl apply -f deployment.yaml
```

## 📊 Audit Logging

### Enable Audit Logging

```yaml
# /etc/kubernetes/audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
```

```yaml
# kube-apiserver configuration
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
apiServer:
  extraArgs:
    audit-log-path: /var/log/audit.log
    audit-policy-file: /etc/kubernetes/audit-policy.yaml
```

## 🎓 Learning Resources

- Kubernetes Security: https://kubernetes.io/docs/concepts/security/
- Pod Security: https://kubernetes.io/docs/concepts/security/pod-security-standards/
- Network Policies: https://kubernetes.io/docs/concepts/services-networking/network-policies/

---

**Next**: Learn about [Monitoring Kubernetes](./MONITORING-KUBERNETES.md)

