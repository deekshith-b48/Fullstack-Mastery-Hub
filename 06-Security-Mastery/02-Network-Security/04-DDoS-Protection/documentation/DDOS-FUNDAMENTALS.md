# DDoS Fundamentals

## 📚 Overview

Distributed Denial of Service (DDoS) attacks overwhelm systems with traffic from multiple sources. Understanding DDoS attacks is essential for implementing effective protection.

## 🎯 What is DDoS?

DDoS attacks flood a target with traffic from many sources simultaneously, making services unavailable to legitimate users. They're one of the most common cyber threats.

## 🔍 DDoS Attack Types

### 1. Volume-Based Attacks

Overwhelm bandwidth:
- UDP floods
- ICMP floods
- DNS amplification

### 2. Protocol Attacks

Exploit protocol weaknesses:
- SYN floods
- Ping of Death
- Fragmented packets

### 3. Application-Layer Attacks

Target application layer:
- HTTP floods
- Slowloris
- Zero-day exploits

## 🔍 DDoS Detection

### Traffic Analysis

```javascript
// Detect DDoS attacks
class DDoSDetector {
  constructor() {
    this.requestCounts = new Map();
    this.threshold = 100; // requests per minute
  }
  
  analyzeRequest(req) {
    const ip = req.ip;
    const now = Date.now();
    const minute = Math.floor(now / 60000);
    const key = `${ip}:${minute}`;
    
    const count = this.requestCounts.get(key) || 0;
    this.requestCounts.set(key, count + 1);
    
    if (count + 1 > this.threshold) {
      this.handleDDoS(ip);
      return false;
    }
    
    return true;
  }
  
  handleDDoS(ip) {
    // Block IP
    this.blockIP(ip);
    
    // Send alert
    sendAlert({
      type: 'ddos_detected',
      ip: ip,
      severity: 'high'
    });
  }
}
```

## 🔍 DDoS Mitigation

### Rate Limiting

```javascript
// Rate limiting middleware
const rateLimit = require('express-rate-limit');

const ddosLimiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 100, // 100 requests per minute
  message: 'Too many requests, please try again later',
  standardHeaders: true,
  legacyHeaders: false,
  skipSuccessfulRequests: false,
  skipFailedRequests: false
});

app.use('/api/', ddosLimiter);
```

## 🛡️ Best Practices

1. **Rate Limiting**: Implement rate limits
2. **Traffic Analysis**: Monitor traffic patterns
3. **CDN**: Use CDN for DDoS protection
4. **Cloud Services**: Use cloud DDoS protection
5. **Monitoring**: Continuous monitoring
6. **Incident Response**: Have response plan
7. **Testing**: Test DDoS response

---

**Next**: Learn about [DDoS Attack Types](./DDOS-ATTACK-TYPES.md)

