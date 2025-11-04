# Loki Logging

## 📚 Overview

Loki is a horizontally-scalable, highly-available log aggregation system inspired by Prometheus. It's designed to be very cost-effective and easy to operate.

## 🎯 Loki Fundamentals

### What is Loki?

Loki is a log aggregation system that indexes metadata rather than log content, making it more efficient and cost-effective than traditional log aggregation systems.

### Key Features

- **Prometheus-inspired**: Similar to Prometheus
- **Cost-effective**: Efficient storage
- **Scalable**: Horizontal scaling
- **Label-based**: Label-based indexing
- **Grafana Integration**: Native Grafana support

## 🚀 Installation

### Docker

```bash
# Run Loki
docker run -d \
  -p 3100:3100 \
  --name=loki \
  grafana/loki:latest

# Run Promtail
docker run -d \
  -v /var/log:/var/log \
  --name=promtail \
  grafana/promtail:latest \
  -config.file=/etc/promtail/config.yml
```

### Linux

```bash
# Download Loki
wget https://github.com/grafana/loki/releases/download/v2.9.0/loki-linux-amd64.zip
unzip loki-linux-amd64.zip

# Run Loki
./loki-linux-amd64 -config.file=loki-config.yml
```

## 🔧 Configuration

### Loki Configuration

```yaml
# loki-config.yml
auth_enabled: false

server:
  http_listen_port: 3100

ingester:
  lifecycler:
    address: 127.0.0.1
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 5m
  chunk_retain_period: 30s

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

storage_config:
  boltdb_shipper:
    active_index_directory: /tmp/loki/boltdb-shipper-active
    cache_location: /tmp/loki/boltdb-shipper-cache
    shared_store: filesystem
  filesystem:
    directory: /tmp/loki/chunks

limits_config:
  reject_old_samples: true
  reject_old_samples_max_age: 168h
```

### Promtail Configuration

```yaml
# promtail-config.yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: varlogs
          __path__: /var/log/*log
```

## 📊 Querying Logs

### LogQL

```logql
# Query logs
{job="varlogs"}

# Filter by level
{job="varlogs"} |= "error"

# Aggregation
sum(rate({job="varlogs"}[5m]))
```

### Grafana Integration

```bash
# Add Loki data source
# Configuration > Data Sources > Add
# Select Loki
# Configure URL
```

## 🎯 Best Practices

1. **Labels**: Use meaningful labels
2. **Retention**: Set retention policies
3. **Performance**: Optimize queries
4. **Storage**: Manage storage efficiently
5. **Documentation**: Document configurations
6. **Monitoring**: Monitor Loki health
7. **Backup**: Regular backups

## 🎓 Learning Resources

- Loki: https://grafana.com/docs/loki/latest/
- Getting Started: https://grafana.com/docs/loki/latest/getting-started/
- LogQL: https://grafana.com/docs/loki/latest/logql/

---

**Next**: Learn about [CloudWatch Logs](./CLOUDWATCH-LOGS.md)

