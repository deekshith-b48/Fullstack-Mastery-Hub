# Traffic Analysis

## 📚 Overview

Traffic analysis helps identify DDoS attacks, understand traffic patterns, and optimize network performance. It's essential for effective DDoS protection.

## 🎯 Traffic Analysis Goals

### Analysis Objectives

1. **Attack Detection**: Identify attacks early
2. **Pattern Recognition**: Recognize attack patterns
3. **Baseline Establishment**: Understand normal traffic
4. **Performance Optimization**: Optimize network

## 🔍 Traffic Monitoring

### Real-Time Monitoring

```javascript
class TrafficAnalyzer {
  constructor() {
    this.metrics = {
      requestsPerSecond: 0,
      bytesPerSecond: 0,
      uniqueIPs: new Set(),
      topEndpoints: new Map()
    };
    
    this.baseline = {
      avgRPS: 100,
      avgBPS: 1000000,
      normalIPCount: 50
    };
  }
  
  analyzeRequest(req) {
    const now = Date.now();
    
    // Update metrics
    this.metrics.requestsPerSecond++;
    this.metrics.bytesPerSecond += req.headers['content-length'] || 0;
    this.metrics.uniqueIPs.add(req.ip);
    
    // Track endpoints
    const endpoint = req.path;
    const count = this.metrics.topEndpoints.get(endpoint) || 0;
    this.metrics.topEndpoints.set(endpoint, count + 1);
    
    // Check for anomalies
    this.checkAnomalies();
  }
  
  checkAnomalies() {
    // Check RPS
    if (this.metrics.requestsPerSecond > this.baseline.avgRPS * 10) {
      this.alert('high_rps', {
        current: this.metrics.requestsPerSecond,
        baseline: this.baseline.avgRPS
      });
    }
    
    // Check unique IPs
    if (this.metrics.uniqueIPs.size > this.baseline.normalIPCount * 5) {
      this.alert('high_ip_count', {
        current: this.metrics.uniqueIPs.size,
        baseline: this.baseline.normalIPCount
      });
    }
  }
  
  alert(type, data) {
    sendAlert({
      type: type,
      severity: 'medium',
      data: data,
      timestamp: Date.now()
    });
  }
}
```

## 🔍 Pattern Detection

### Detect Attack Patterns

```javascript
function detectAttackPatterns(traffic) {
  const patterns = [];
  
  // Check for sudden traffic spike
  const avgTraffic = calculateAverage(traffic, 60); // 60 seconds
  const currentTraffic = traffic.slice(-10); // Last 10 seconds
  
  if (currentTraffic > avgTraffic * 5) {
    patterns.push({
      type: 'traffic_spike',
      severity: 'high',
      current: currentTraffic,
      average: avgTraffic
    });
  }
  
  // Check for distributed sources
  const uniqueIPs = new Set(traffic.map(t => t.sourceIP));
  if (uniqueIPs.size > 1000) {
    patterns.push({
      type: 'distributed_attack',
      severity: 'high',
      uniqueIPs: uniqueIPs.size
    });
  }
  
  return patterns;
}
```

## 🔍 Baseline Establishment

### Establish Normal Baseline

```javascript
async function establishBaseline(duration = 7 * 24 * 60 * 60 * 1000) {
  const traffic = await getTrafficData(duration);
  
  const baseline = {
    avgRPS: calculateAverage(traffic.map(t => t.rps)),
    avgBPS: calculateAverage(traffic.map(t => t.bps)),
    peakRPS: Math.max(...traffic.map(t => t.rps)),
    peakBPS: Math.max(...traffic.map(t => t.bps)),
    normalIPCount: calculateAverage(traffic.map(t => t.uniqueIPs)),
    topEndpoints: getTopEndpoints(traffic),
    timePatterns: analyzeTimePatterns(traffic)
  };
  
  return baseline;
}
```

## 🛡️ Best Practices

1. **Continuous Monitoring**: Monitor continuously
2. **Baseline**: Establish normal baseline
3. **Anomaly Detection**: Detect anomalies
4. **Pattern Recognition**: Recognize patterns
5. **Alerting**: Set up alerts
6. **Documentation**: Document analysis
7. **Review**: Regular review

---

**Next**: Learn about [DDoS Response Plan](./DDOS-RESPONSE-PLAN.md)

