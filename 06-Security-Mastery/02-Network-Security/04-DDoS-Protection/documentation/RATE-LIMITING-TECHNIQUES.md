# Rate Limiting Techniques

## 📚 Overview

Rate limiting controls the number of requests a client can make within a time period. It's essential for preventing abuse and DDoS attacks.

## 🎯 Rate Limiting Types

### 1. Fixed Window

Simple time window:
```javascript
const rateLimitStore = new Map();

function fixedWindowRateLimit(ip, limit, windowMs) {
  const now = Date.now();
  const window = Math.floor(now / windowMs);
  const key = `${ip}:${window}`;
  
  const count = rateLimitStore.get(key) || 0;
  
  if (count >= limit) {
    return { allowed: false, remaining: 0 };
  }
  
  rateLimitStore.set(key, count + 1);
  return { allowed: true, remaining: limit - count - 1 };
}
```

### 2. Sliding Window

More accurate:
```javascript
class SlidingWindowRateLimit {
  constructor(limit, windowMs) {
    this.limit = limit;
    this.windowMs = windowMs;
    this.requests = new Map();
  }
  
  check(ip) {
    const now = Date.now();
    const windowStart = now - this.windowMs;
    
    // Get requests in current window
    const ipRequests = this.requests.get(ip) || [];
    const validRequests = ipRequests.filter(time => time > windowStart);
    
    if (validRequests.length >= this.limit) {
      return { allowed: false, remaining: 0 };
    }
    
    validRequests.push(now);
    this.requests.set(ip, validRequests);
    
    return { 
      allowed: true, 
      remaining: this.limit - validRequests.length 
    };
  }
}
```

### 3. Token Bucket

Allows bursts:
```javascript
class TokenBucket {
  constructor(capacity, refillRate) {
    this.capacity = capacity;
    this.tokens = capacity;
    this.refillRate = refillRate; // tokens per second
    this.lastRefill = Date.now();
  }
  
  consume(tokens = 1) {
    this.refill();
    
    if (this.tokens >= tokens) {
      this.tokens -= tokens;
      return { allowed: true, tokens: this.tokens };
    }
    
    return { allowed: false, tokens: this.tokens };
  }
  
  refill() {
    const now = Date.now();
    const elapsed = (now - this.lastRefill) / 1000;
    const tokensToAdd = elapsed * this.refillRate;
    
    this.tokens = Math.min(this.capacity, this.tokens + tokensToAdd);
    this.lastRefill = now;
  }
}
```

## 🔍 Implementation

### Express Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');

const limiter = rateLimit({
  store: new RedisStore({
    client: redisClient
  }),
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests
  message: 'Too many requests',
  standardHeaders: true,
  legacyHeaders: false
});

app.use('/api/', limiter);
```

## 🔍 Per-User Rate Limiting

```javascript
// Rate limit by user ID
const userLimiter = rateLimit({
  keyGenerator: (req) => req.user?.id || req.ip,
  windowMs: 60 * 1000,
  max: 50
});

app.use('/api/user/', userLimiter);
```

## 🛡️ Best Practices

1. **Choose Algorithm**: Select appropriate algorithm
2. **Redis Storage**: Use Redis for distributed systems
3. **Headers**: Include rate limit headers
4. **Graceful Handling**: Handle limits gracefully
5. **Monitoring**: Monitor rate limit effectiveness
6. **Tuning**: Tune limits based on usage
7. **Documentation**: Document rate limits

---

**Next**: Learn about [Cloud DDoS Protection](./CLOUD-DDOS-PROTECTION.md)

