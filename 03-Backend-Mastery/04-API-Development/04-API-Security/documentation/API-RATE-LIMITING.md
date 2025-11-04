# API Rate Limiting

## 📚 Overview

Rate limiting protects APIs from abuse and ensures fair usage.

## 🎯 Implementation

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
```

## 📊 Advanced Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const createAccountLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5, // Limit each IP to 5 account creation requests per hour
  message: 'Too many accounts created from this IP'
});

app.post('/register', createAccountLimiter, registerHandler);
```

## 🔄 Redis-Based Rate Limiting

```javascript
const RedisStore = require('rate-limit-redis');
const redis = require('redis');

const client = redis.createClient();

const limiter = rateLimit({
  store: new RedisStore({
    client: client,
    prefix: 'rl:'
  }),
  windowMs: 15 * 60 * 1000,
  max: 100
});
```

---

**All documentation files created!**

