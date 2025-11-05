# API Rate Limiting

## 📚 Overview

API rate limiting prevents abuse and ensures fair usage. It protects APIs from DDoS attacks and ensures service availability.

## 🎯 Rate Limiting Strategies

### Strategies

1. **Fixed Window**: Simple time window
2. **Sliding Window**: More accurate
3. **Token Bucket**: Allows bursts
4. **Per-User**: User-specific limits

## 🔍 Rate Limiting Implementation

### Express Rate Limiting

```javascript
// API rate limiting
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');

const apiLimiter = rateLimit({
  store: new RedisStore({
    client: redisClient
  }),
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests
  keyGenerator: (req) => req.apiKey?.id || req.user?.id || req.ip,
  message: 'Too many requests, please try again later',
  standardHeaders: true,
  legacyHeaders: false
});

app.use('/api/', apiLimiter);
```

## 🔍 Tiered Rate Limiting

### Different Limits by Tier

```javascript
// Tiered rate limiting
function getRateLimitByTier(tier) {
  const limits = {
    free: { windowMs: 60000, max: 10 }, // 10/min
    pro: { windowMs: 60000, max: 100 }, // 100/min
    enterprise: { windowMs: 60000, max: 1000 } // 1000/min
  };
  
  return rateLimit(limits[tier] || limits.free);
}

app.use('/api/', (req, res, next) => {
  const tier = req.apiKey?.tier || 'free';
  const limiter = getRateLimitByTier(tier);
  limiter(req, res, next);
});
```

## 🛡️ Best Practices

1. **Appropriate Limits**: Set appropriate limits
2. **Tiered**: Different limits by tier
3. **Headers**: Include rate limit headers
4. **Graceful**: Handle limits gracefully
5. **Monitoring**: Monitor rate limits
6. **Documentation**: Document limits
7. **Testing**: Test rate limiting

---

**Next**: Learn about [API Security Best Practices](./API-SECURITY-BEST-PRACTICES.md)

