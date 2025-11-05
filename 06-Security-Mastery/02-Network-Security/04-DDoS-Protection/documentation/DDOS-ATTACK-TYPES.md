# DDoS Attack Types

## 📚 Overview

Understanding different DDoS attack types helps implement targeted protection strategies. This guide covers major DDoS attack categories and their characteristics.

## 🎯 Attack Categories

### Volume-Based Attacks

Overwhelm bandwidth:
```javascript
// UDP flood detection
function detectUDPFlood(packets) {
  const udpCount = packets.filter(p => p.protocol === 'udp').length;
  const threshold = 10000; // packets per second
  
  if (udpCount > threshold) {
    return {
      type: 'udp_flood',
      detected: true,
      severity: 'high'
    };
  }
  
  return { detected: false };
}
```

### Protocol Attacks

Exploit protocol weaknesses:
```javascript
// SYN flood detection
function detectSYNFlood(connections) {
  const synConnections = connections.filter(c => 
    c.state === 'SYN_SENT' && 
    (Date.now() - c.timestamp) > 30000 // 30 seconds
  );
  
  if (synConnections.length > 1000) {
    return {
      type: 'syn_flood',
      detected: true,
      severity: 'high',
      count: synConnections.length
    };
  }
  
  return { detected: false };
}
```

### Application-Layer Attacks

Target application layer:
```javascript
// HTTP flood detection
function detectHTTPFlood(requests) {
  const requestRate = requests.length / 60; // requests per second
  const threshold = 100; // RPS
  
  if (requestRate > threshold) {
    return {
      type: 'http_flood',
      detected: true,
      severity: 'medium',
      rate: requestRate
    };
  }
  
  return { detected: false };
}
```

## 🔍 Specific Attack Types

### 1. SYN Flood

Half-open connections:
- Exploits TCP handshake
- Exhausts connection resources
- High volume SYN packets

### 2. UDP Flood

UDP packet flood:
- Targets random ports
- Overwhelms bandwidth
- Difficult to filter

### 3. HTTP Flood

HTTP request flood:
- Legitimate-looking requests
- Targets application layer
- Harder to detect

### 4. DNS Amplification

DNS response amplification:
- Small queries, large responses
- Uses open DNS servers
- High amplification factor

## 🛡️ Best Practices

1. **Multi-Layer Defense**: Protect all layers
2. **Traffic Analysis**: Analyze traffic patterns
3. **Rate Limiting**: Implement rate limits
4. **Filtering**: Filter malicious traffic
5. **Monitoring**: Continuous monitoring
6. **Response Plan**: Have mitigation plan
7. **Testing**: Test protection mechanisms

---

**Next**: Learn about [DDoS Mitigation Strategies](./DDOS-MITIGATION-STRATEGIES.md)

