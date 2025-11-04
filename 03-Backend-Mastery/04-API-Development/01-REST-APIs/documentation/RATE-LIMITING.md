# API Rate Limiting

## 📚 Overview

Rate limiting protects APIs from abuse and ensures fair usage.

## 🎯 Implementation

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // Limit each IP to 100 requests per windowMs
});

app.use('/api/', limiter);
```

## 📊 Rate Limit Headers

```javascript
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

---

**Next**: Learn about [API Gateway Patterns](./API-GATEWAY-PATTERNS.md)

