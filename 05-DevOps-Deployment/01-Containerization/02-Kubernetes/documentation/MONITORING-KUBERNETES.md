# Monitoring Kubernetes

## 📚 Overview

Monitoring Kubernetes clusters is essential for maintaining application health, performance, and reliability. This guide covers monitoring strategies, tools, and best practices for Kubernetes environments.

## 📊 Monitoring Stack

### Prometheus + Grafana

#### Prometheus Setup

```yaml
# Prometheus ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    scrape_configs:
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
      - role: pod
    - job_name: 'kubernetes-nodes'
      kubernetes_sd_configs:
      - role: node
```

#### Prometheus Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus
  template:
    metadata:
      labels:
        app: prometheus
    spec:
      containers:
      - name: prometheus
        image: prom/prometheus:latest
        ports:
        - containerPort: 9090
        volumeMounts:
        - name: config
          mountPath: /etc/prometheus
      volumes:
      - name: config
        configMap:
          name: prometheus-config
```

### Grafana Setup

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        ports:
        - containerPort: 3000
        env:
        - name: GF_SECURITY_ADMIN_PASSWORD
          valueFrom:
            secretKeyRef:
              name: grafana-secret
              key: password
        volumeMounts:
        - name: grafana-storage
          mountPath: /var/lib/grafana
      volumes:
      - name: grafana-storage
        persistentVolumeClaim:
          claimName: grafana-pvc
```

## 🔍 Key Metrics

### Cluster Metrics

```promql
# Node CPU usage
100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Node memory usage
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100

# Pod CPU usage
rate(container_cpu_usage_seconds_total[5m])

# Pod memory usage
container_memory_usage_bytes
```

### Application Metrics

```promql
# Request rate
rate(http_requests_total[5m])

# Error rate
rate(http_requests_total{status=~"5.."}[5m])

# Response time
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))
```

## 📈 Monitoring Tools

### cAdvisor

```bash
# cAdvisor is included in kubelet
# Exposes container metrics
# Access via node metrics endpoint
```

### Node Exporter

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      containers:
      - name: node-exporter
        image: prom/node-exporter:latest
        ports:
        - containerPort: 9100
```

### kube-state-metrics

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-state-metrics
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kube-state-metrics
  template:
    metadata:
      labels:
        app: kube-state-metrics
    spec:
      containers:
      - name: kube-state-metrics
        image: k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.8.0
        ports:
        - containerPort: 8080
```

## 🔔 Alerting

### Prometheus Alerting Rules

```yaml
# alert-rules.yaml
groups:
- name: kubernetes
  rules:
  - alert: HighCPUUsage
    expr: node_cpu_usage > 80
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "High CPU usage on {{ $labels.instance }}"
  
  - alert: PodCrashLooping
    expr: rate(kube_pod_container_status_restarts_total[15m]) > 0
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "Pod {{ $labels.pod }} is crash looping"
```

### Alertmanager

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: alertmanager
spec:
  replicas: 1
  selector:
    matchLabels:
      app: alertmanager
  template:
    metadata:
      labels:
        app: alertmanager
    spec:
      containers:
      - name: alertmanager
        image: prom/alertmanager:latest
        ports:
        - containerPort: 9093
```

## 📊 Logging

### Fluentd/Fluent Bit

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit
spec:
  selector:
    matchLabels:
      app: fluent-bit
  template:
    metadata:
      labels:
        app: fluent-bit
    spec:
      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:latest
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
```

### Elasticsearch + Kibana

```yaml
# Elasticsearch for log storage
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: elasticsearch
spec:
  serviceName: elasticsearch
  replicas: 3
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
      - name: elasticsearch
        image: docker.elastic.co/elasticsearch/elasticsearch:8.0.0
        ports:
        - containerPort: 9200
        env:
        - name: discovery.type
          value: "single-node"
```

## 🎯 Best Practices

1. **Monitor All Layers**: Cluster, node, pod, application
2. **Set Alerts**: Configure meaningful alerts
3. **Retention**: Set appropriate metric retention
4. **Dashboards**: Create comprehensive dashboards
5. **Log Aggregation**: Centralize logs
6. **Performance**: Monitor performance metrics
7. **Capacity Planning**: Track resource usage trends

## 🔍 Troubleshooting

### Common Monitoring Issues

```bash
# Check Prometheus targets
curl http://prometheus:9090/api/v1/targets

# Check metrics endpoint
curl http://node-exporter:9100/metrics

# Check kube-state-metrics
curl http://kube-state-metrics:8080/metrics
```

## 🎓 Learning Resources

- Kubernetes Monitoring: https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/
- Prometheus: https://prometheus.io/docs/
- Grafana: https://grafana.com/docs/

---

**Next**: Learn about [Kubernetes Best Practices](./KUBERNETES-BEST-PRACTICES.md)

