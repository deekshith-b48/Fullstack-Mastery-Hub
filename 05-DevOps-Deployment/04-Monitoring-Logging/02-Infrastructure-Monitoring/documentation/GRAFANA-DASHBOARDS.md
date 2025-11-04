# Grafana Dashboards

## 📚 Overview

Grafana is an open-source analytics and visualization platform. It creates dashboards to visualize metrics from various data sources including Prometheus, InfluxDB, and CloudWatch.

## 🎯 Grafana Fundamentals

### What is Grafana?

Grafana provides rich visualization capabilities for time-series data. It connects to various data sources and creates beautiful dashboards.

### Key Features

- **Data Sources**: Connect to multiple data sources
- **Dashboards**: Create custom dashboards
- **Alerts**: Set up alerts
- **Plugins**: Extend functionality
- **Sharing**: Share dashboards

## 🚀 Installation

### Docker

```bash
# Run Grafana
docker run -d \
  -p 3000:3000 \
  -v grafana-storage:/var/lib/grafana \
  grafana/grafana

# Access Grafana
# http://localhost:3000
# Default: admin/admin
```

### Linux

```bash
# Install Grafana
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
sudo apt-get install grafana

# Start Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

## 🔧 Configuration

### Data Sources

```bash
# Add data source
# Configuration > Data Sources > Add
# Select Prometheus
# Configure URL and credentials
```

### Dashboard Creation

```bash
# Create dashboard
# Dashboards > New Dashboard
# Add panels
# Configure queries
# Save dashboard
```

## 📊 Panel Types

### Time Series

```promql
# Time series panel
rate(http_requests_total[5m])
```

### Stat Panel

```promql
# Stat panel
sum(http_requests_total)
```

### Table Panel

```promql
# Table panel
topk(10, http_requests_total)
```

### Graph Panel

```promql
# Graph panel
cpu_usage
```

## 🔔 Alerts

### Alert Configuration

```bash
# Create alert
# Panel > Alert > Create Alert
# Define conditions
# Configure notifications
```

### Notification Channels

```bash
# Email
# Slack
# PagerDuty
# Webhooks
```

## 🎯 Best Practices

1. **Organization**: Organize dashboards logically
2. **Reusability**: Create reusable dashboards
3. **Performance**: Optimize queries
4. **Documentation**: Document dashboards
5. **Sharing**: Share useful dashboards
6. **Testing**: Test dashboard changes
7. **Maintenance**: Keep dashboards updated

## 🎓 Learning Resources

- Grafana: https://grafana.com/docs/grafana/latest/
- Dashboards: https://grafana.com/docs/grafana/latest/dashboards/
- Best Practices: https://grafana.com/docs/grafana/latest/best-practices/

---

**Next**: Learn about [Nagios & Zabbix](./NAGIOS-ZABBIX.md)

