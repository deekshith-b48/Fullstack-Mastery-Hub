# Azure Monitor

## 📚 Overview

Azure Monitor provides comprehensive monitoring for Azure resources and applications. It collects metrics, logs, and traces for full observability.

## 🎯 Azure Monitor Features

### Key Features

- **Metrics**: Performance and health metrics
- **Logs**: Centralized log management
- **Application Insights**: APM integration
- **Alerts**: Alerting and notifications
- **Dashboards**: Custom dashboards

## 🚀 Getting Started

### Enable Monitoring

```bash
# Enable monitoring for resources
# Automatic for most Azure services
# Configure in resource settings
```

### Metrics

```bash
# Get metrics
az monitor metrics list \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM \
  --metric "Percentage CPU"
```

## 📊 Custom Metrics

### Publish Custom Metrics

```bash
# Publish custom metric
az monitor metrics create \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup \
  --metric-name CustomMetric \
  --value 100
```

## 🔔 Alerts

### Create Alert Rule

```bash
# Create alert rule
az monitor metrics alert create \
  --name "high-cpu" \
  --resource-group myResourceGroup \
  --scopes /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM \
  --condition "avg Percentage CPU > 80" \
  --window-size 5m \
  --evaluation-frequency 1m
```

## 📈 Dashboards

### Create Dashboard

```bash
# Create dashboard
az portal dashboard create \
  --resource-group myResourceGroup \
  --name my-dashboard \
  --input-path dashboard.json
```

## 🎯 Best Practices

1. **Metrics**: Collect relevant metrics
2. **Alerts**: Set meaningful alerts
3. **Dashboards**: Create useful dashboards
4. **Logs**: Centralize logs
5. **Cost**: Monitor costs
6. **Documentation**: Document setup
7. **Optimization**: Optimize monitoring

## 🎓 Learning Resources

- Azure Monitor: https://docs.microsoft.com/azure/azure-monitor/
- Metrics: https://docs.microsoft.com/azure/azure-monitor/essentials/metrics-supported
- Alerts: https://docs.microsoft.com/azure/azure-monitor/alerts/alerts-overview

---

**Next**: Learn about [Alerting Strategies](./ALERTING-STRATEGIES.md)

