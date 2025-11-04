# Prometheus Metrics

## 📚 Overview

Prometheus is an open-source monitoring and alerting toolkit. It collects metrics from targets at configured intervals and stores them for querying and alerting.

## 🎯 Prometheus Fundamentals

### What is Prometheus?

Prometheus is a time-series database designed for monitoring. It collects metrics, stores them, and provides a query language (PromQL) for analysis.

### Key Concepts

- **Metric**: Measurement at a point in time
- **Time Series**: Series of metric values over time
- **Label**: Key-value pair for filtering
- **Scrape**: Collecting metrics from targets
- **Alert**: Notification based on metrics

## 🚀 Installation

### Docker

```bash
# Run Prometheus
docker run -d \
  -p 9090:9090 \
  -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus
```

### Linux

```bash
# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
tar xvfz prometheus-2.45.0.linux-amd64.tar.gz
cd prometheus-2.45.0.linux-amd64

# Start Prometheus
./prometheus --config.file=prometheus.yml
```

## 🔧 Configuration

### prometheus.yml

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']
```

### Service Discovery

```yaml
scrape_configs:
  - job_name: 'kubernetes'
    kubernetes_sd_configs:
      - role: pod
```

## 📊 Querying Metrics

### PromQL

```promql
# Query metrics
cpu_usage

# Filter by label
cpu_usage{instance="server1"}

# Aggregation
avg(cpu_usage)

# Rate
rate(http_requests_total[5m])

# Functions
increase(http_requests_total[1h])
```

## 🔔 Alerting

### Alert Rules

```yaml
# alerts.yml
groups:
  - name: infrastructure
    rules:
      - alert: HighCPUUsage
        expr: cpu_usage > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ $labels.instance }}"
```

### Alertmanager

```yaml
# alertmanager.yml
route:
  receiver: 'default'
  routes:
    - match:
        severity: critical
      receiver: 'pagerduty'
```

## 🎯 Best Practices

1. **Metrics**: Use appropriate metric types
2. **Labels**: Use labels effectively
3. **Queries**: Optimize PromQL queries
4. **Alerts**: Set meaningful alerts
5. **Documentation**: Document metrics
6. **Testing**: Test alert rules
7. **Maintenance**: Keep Prometheus updated

## 🎓 Learning Resources

- Prometheus: https://prometheus.io/docs/introduction/overview/
- PromQL: https://prometheus.io/docs/prometheus/latest/querying/basics/
- Alerting: https://prometheus.io/docs/alerting/latest/overview/

---

**Next**: Learn about [Grafana Dashboards](./GRAFANA-DASHBOARDS.md)

