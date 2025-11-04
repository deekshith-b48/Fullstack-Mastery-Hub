# Helm Charts

## 📚 Overview

Helm is the package manager for Kubernetes, providing a way to define, install, and upgrade Kubernetes applications. Helm charts are packages of pre-configured Kubernetes resources.

## 🎯 What is Helm?

Helm helps you manage Kubernetes applications through Helm Charts, which are collections of files that describe a related set of Kubernetes resources. Charts make it easy to create, version, share, and publish Kubernetes applications.

### Key Concepts

- **Chart**: A package of Kubernetes resources
- **Release**: An instance of a chart running in a cluster
- **Repository**: A collection of charts
- **Values**: Configuration parameters for charts
- **Templates**: Kubernetes manifest files with placeholders

### Benefits

1. **Simplified Deployment**: Package complex applications
2. **Versioning**: Manage application versions
3. **Configuration**: Parameterize deployments
4. **Reusability**: Share and reuse charts
5. **Rollback**: Easy rollback to previous versions

## 🚀 Installation

### Linux

```bash
# Download Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Or using package manager
wget https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz
tar -zxvf helm-v3.12.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
```

### macOS

```bash
# Using Homebrew
brew install helm

# Or download binary
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### Verify Installation

```bash
helm version
```

## 📦 Basic Helm Commands

### Repository Management

```bash
# Add repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# List repositories
helm repo list

# Update repositories
helm repo update

# Remove repository
helm repo remove bitnami
```

### Installing Charts

```bash
# Install from repository
helm install my-release bitnami/nginx

# Install with custom name
helm install my-nginx bitnami/nginx

# Install with values file
helm install my-nginx bitnami/nginx -f values.yaml

# Install with custom values
helm install my-nginx bitnami/nginx --set service.type=LoadBalancer

# Install from local chart
helm install my-app ./my-chart
```

### Managing Releases

```bash
# List releases
helm list

# List all releases (including deleted)
helm list --all

# Get release status
helm status my-release

# Upgrade release
helm upgrade my-release bitnami/nginx

# Upgrade with values
helm upgrade my-release bitnami/nginx -f values.yaml

# Rollback release
helm rollback my-release 1

# Uninstall release
helm uninstall my-release
```

## 📝 Creating Charts

### Chart Structure

```bash
# Create new chart
helm create my-chart

# Chart structure
my-chart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── templates/          # Template files
│   ├── deployment.yaml
│   ├── service.yaml
│   └── _helpers.tpl   # Helper templates
└── charts/             # Chart dependencies
```

### Chart.yaml

```yaml
apiVersion: v2
name: my-chart
description: A Helm chart for my application
type: application
version: 0.1.0
appVersion: "1.0.0"
maintainers:
  - name: Developer
    email: developer@example.com
keywords:
  - web
  - application
home: https://example.com
sources:
  - https://github.com/example/my-app
```

### values.yaml

```yaml
# Default values
replicaCount: 1

image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "1.21"

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  className: ""
  annotations: {}
  hosts:
    - host: chart-example.local
      paths:
        - path: /
          pathType: Prefix
  tls: []

resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

### Template Files

```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "my-chart.fullname" . }}
  labels:
    {{- include "my-chart.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "my-chart.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "my-chart.selectorLabels" . | nindent 8 }}
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - containerPort: 80
        resources:
          {{- toYaml .Values.resources | nindent 12 }}
```

### Helper Templates

```yaml
# templates/_helpers.tpl
{{- define "my-chart.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "my-chart.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "my-chart.labels" -}}
helm.sh/chart: {{ include "my-chart.chart" . }}
{{ include "my-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "my-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
```

## 🔧 Template Functions

### Built-in Functions

```yaml
# String functions
{{ .Values.name | upper }}
{{ .Values.name | lower }}
{{ .Values.name | title }}
{{ .Values.name | trunc 10 }}

# Default values
{{ .Values.replicaCount | default 1 }}
{{ .Values.image.tag | default "latest" }}

# Conditionals
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
{{- end }}

# Loops
{{- range .Values.env }}
- name: {{ .name }}
  value: {{ .value }}
{{- end }}

# With scope
{{- with .Values.resources }}
resources:
  limits:
    cpu: {{ .limits.cpu }}
{{- end }}
```

### Advanced Templates

```yaml
# Include templates
{{ include "my-chart.fullname" . }}

# Required values
{{ required "image.repository is required" .Values.image.repository }}

# ToYaml
{{- toYaml .Values.config | nindent 8 }}

# FromYaml
{{- $config := .Values.config | fromYaml }}

# Lookup
{{- $deployment := lookup "apps/v1" "Deployment" .Release.Namespace "my-deployment" }}
```

## 📊 Chart Dependencies

### Chart Dependencies

```yaml
# Chart.yaml
dependencies:
  - name: postgresql
    version: "11.0.0"
    repository: "https://charts.bitnami.com/bitnami"
  - name: redis
    version: "17.0.0"
    repository: "https://charts.bitnami.com/bitnami"
```

### Managing Dependencies

```bash
# Update dependencies
helm dependency update

# Build dependencies
helm dependency build

# List dependencies
helm dependency list
```

## 🎯 Best Practices

### Chart Organization

1. **Use templates**: Create reusable templates
2. **Values validation**: Validate input values
3. **Documentation**: Include README.md
4. **Versioning**: Follow semantic versioning
5. **Testing**: Test charts before publishing

### Template Best Practices

1. **Use helpers**: Create reusable helper templates
2. **Conditional resources**: Use if/unless for optional resources
3. **Default values**: Provide sensible defaults
4. **Comments**: Document complex templates
5. **Indentation**: Use nindent for proper YAML

## 🔍 Testing Charts

### Template Testing

```bash
# Dry run install
helm install my-release ./my-chart --dry-run --debug

# Template rendering
helm template my-release ./my-chart

# Validate chart
helm lint ./my-chart

# Test with values
helm install my-release ./my-chart -f test-values.yaml --dry-run
```

### Chart Testing Plugin

```bash
# Install chart-testing
helm plugin install https://github.com/helm/chart-testing

# Run tests
ct lint
ct install
```

## 📦 Publishing Charts

### Chart Repository

```bash
# Package chart
helm package ./my-chart

# Create index
helm repo index . --url https://charts.example.com

# Serve repository
helm serve
```

### Chart Museum

```bash
# Install ChartMuseum
helm install chartmuseum stable/chartmuseum

# Push chart
helm push my-chart-0.1.0.tgz chartmuseum
```

## 🎓 Learning Resources

- Helm Documentation: https://helm.sh/docs/
- Chart Best Practices: https://helm.sh/docs/chart_best_practices/
- Chart Template Guide: https://helm.sh/docs/chart_template_guide/

---

**Next**: Learn about [Kubernetes Networking](./KUBERNETES-NETWORKING.md)

