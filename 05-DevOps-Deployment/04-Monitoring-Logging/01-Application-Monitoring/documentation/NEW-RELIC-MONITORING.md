# New Relic Monitoring

## 📚 Overview

New Relic is a comprehensive APM platform that provides application performance monitoring, infrastructure monitoring, and log management.

## 🎯 New Relic Features

### Key Features

- **APM**: Application performance monitoring
- **Infrastructure**: Infrastructure monitoring
- **Browser**: Browser performance monitoring
- **Synthetics**: Synthetic monitoring
- **Logs**: Log management
- **Alerts**: Alerting and notifications

## 🚀 Getting Started

### Account Setup

```bash
# Sign up for New Relic account
# https://newrelic.com

# Get license key
# Account Settings > API Keys
```

### Agent Installation

```bash
# Node.js agent
npm install newrelic

# Python agent
pip install newrelic

# Java agent
# Download agent JAR
```

### Configuration

```javascript
// newrelic.js
exports.config = {
  app_name: ['My Application'],
  license_key: 'your-license-key',
  logging: {
    level: 'info'
  }
};
```

## 📊 Monitoring

### APM Dashboard

```bash
# View APM dashboard
# Performance metrics
# Error rates
# Throughput
```

### Custom Dashboards

```bash
# Create custom dashboards
# Add widgets
# Configure alerts
```

### Queries (NRQL)

```sql
-- Query performance data
SELECT average(duration) FROM Transaction 
WHERE appName = 'MyApp' 
FACET name 
TIMESERIES

-- Error rate
SELECT count(*) FROM TransactionError 
WHERE appName = 'MyApp' 
FACET error.class 
TIMESERIES
```

## 🔔 Alerts

### Alert Policies

```bash
# Create alert policy
# Define conditions
# Configure notifications
# Set thresholds
```

### Notification Channels

```bash
# Email notifications
# Slack integration
# PagerDuty integration
# Webhook notifications
```

## 🎯 Best Practices

1. **Instrumentation**: Instrument all key operations
2. **Dashboards**: Create useful dashboards
3. **Alerts**: Set up meaningful alerts
4. **NRQL**: Use NRQL for custom queries
5. **Analysis**: Regular performance analysis
6. **Documentation**: Document monitoring setup
7. **Optimization**: Act on findings

## 🎓 Learning Resources

- New Relic: https://docs.newrelic.com/
- APM: https://docs.newrelic.com/docs/apm/
- NRQL: https://docs.newrelic.com/docs/query-your-data/nrql-query-tutorial/

---

**Next**: Learn about [Datadog APM](./DATADOG-APM.md)

