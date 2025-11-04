# Custom Metrics

## 📚 Overview

Custom metrics allow you to track business-specific metrics and KPIs beyond standard application performance metrics.

## 🎯 Custom Metrics Fundamentals

### What are Custom Metrics?

Custom metrics are application-specific measurements that track business logic, user behavior, or domain-specific events.

### Use Cases

- **Business Metrics**: Revenue, transactions, conversions
- **User Metrics**: Active users, engagement, retention
- **Domain Metrics**: Domain-specific measurements
- **KPI Tracking**: Key performance indicators

## 🚀 Implementation

### Prometheus Custom Metrics

```javascript
// Node.js with prom-client
const client = require('prom-client');

const register = new client.Registry();

const customMetric = new client.Counter({
  name: 'orders_total',
  help: 'Total number of orders',
  labelNames: ['status'],
  registers: [register]
});

customMetric.inc({ status: 'completed' });
```

### Datadog Custom Metrics

```javascript
// Node.js with dogstatsd
const StatsD = require('node-dogstatsd').StatsD;
const client = new StatsD();

client.increment('orders.total', 1, ['status:completed']);
client.gauge('cart.value', 150.50);
client.timing('checkout.duration', 2500);
```

### New Relic Custom Metrics

```javascript
// Node.js with New Relic
const newrelic = require('newrelic');

newrelic.recordMetric('Custom/Orders/Total', 1);
newrelic.recordMetric('Custom/Cart/Value', 150.50);
```

## 📊 Metric Types

### Counters

```javascript
// Count events
const counter = new Counter({
  name: 'http_requests_total',
  help: 'Total HTTP requests'
});

counter.inc();
```

### Gauges

```javascript
// Current value
const gauge = new Gauge({
  name: 'active_users',
  help: 'Number of active users'
});

gauge.set(150);
```

### Histograms

```javascript
// Distribution of values
const histogram = new Histogram({
  name: 'request_duration_seconds',
  help: 'Request duration'
});

histogram.observe(0.5);
```

## 🎯 Best Practices

1. **Naming**: Use consistent naming conventions
2. **Labels**: Use labels appropriately
3. **Cardinality**: Avoid high cardinality
4. **Documentation**: Document custom metrics
5. **Analysis**: Analyze metrics regularly
6. **Alerts**: Set up alerts for metrics
7. **Optimization**: Optimize metric collection

## 🎓 Learning Resources

- Custom Metrics: https://prometheus.io/docs/practices/naming/
- Best Practices: https://www.datadoghq.com/knowledge-center/custom-metrics/
- Metrics: https://prometheus.io/docs/concepts/metric_types/

---

**Next**: Learn about [Business Metrics](./BUSINESS-METRICS.md)

