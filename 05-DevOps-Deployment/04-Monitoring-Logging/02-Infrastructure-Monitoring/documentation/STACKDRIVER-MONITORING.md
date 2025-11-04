# Google Cloud Stackdriver Monitoring

## 📚 Overview

Google Cloud Monitoring (formerly Stackdriver) provides monitoring, logging, and diagnostics for applications running on Google Cloud Platform and other platforms.

## 🎯 Monitoring Features

### Key Features

- **Metrics**: Collect and analyze metrics
- **Logs**: Centralized logging
- **Traces**: Distributed tracing
- **Dashboards**: Custom dashboards
- **Alerts**: Alerting and notifications

## 🚀 Getting Started

### Enable Monitoring

```bash
# Enable Monitoring API
gcloud services enable monitoring.googleapis.com

# Install monitoring agent
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh
```

### Metrics

```bash
# View metrics
gcloud monitoring metrics list

# Get metric data
gcloud monitoring time-series list \
  --metric cpu/utilization
```

## 📊 Custom Metrics

### Create Custom Metric

```bash
# Create custom metric
gcloud monitoring metric-descriptors create \
  --type=myapp.custom/metric \
  --display-name="Custom Metric" \
  --unit=1
```

## 🔔 Alerts

### Create Alert Policy

```bash
# Create alert policy
gcloud alpha monitoring policies create \
  --notification-channels=CHANNEL_ID \
  --display-name="High CPU Usage" \
  --condition-display-name="CPU > 80%" \
  --condition-threshold-value=80 \
  --condition-threshold-duration=300s
```

## 📈 Dashboards

### Create Dashboard

```bash
# Create dashboard via API
# Or use Cloud Console
# Monitoring > Dashboards > Create Dashboard
```

## 🎯 Best Practices

1. **Metrics**: Collect comprehensive metrics
2. **Alerts**: Set meaningful alerts
3. **Dashboards**: Create useful dashboards
4. **Logs**: Integrate with logging
5. **Documentation**: Document setup
6. **Cost**: Monitor costs
7. **Optimization**: Optimize monitoring

## 🎓 Learning Resources

- Monitoring: https://cloud.google.com/monitoring/docs
- Getting Started: https://cloud.google.com/monitoring/docs/quickstart
- Best Practices: https://cloud.google.com/monitoring/docs/best-practices

---

**Next**: Learn about [Azure Monitor](./AZURE-MONITOR.md)

