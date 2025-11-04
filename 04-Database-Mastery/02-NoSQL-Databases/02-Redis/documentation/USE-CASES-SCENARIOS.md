# Redis Use Cases & Scenarios

## 📚 Overview

Redis is versatile and can be used for various use cases. This guide covers common scenarios and implementation patterns.

## 💾 Caching

### Web Application Cache

```javascript
// Cache database queries
async function getProduct(productId) {
    const cacheKey = `product:${productId}`;
    let product = await redis.get(cacheKey);
    
    if (product) {
        return JSON.parse(product);
    }
    
    product = await db.getProduct(productId);
    await redis.setex(cacheKey, 3600, JSON.stringify(product));
    return product;
}
```

## 🔑 Session Storage

```javascript
// Store session data
await redis.setex(`session:${sessionId}`, 3600, JSON.stringify(sessionData));

// Retrieve session
const session = await redis.get(`session:${sessionId}`);
```

## 📊 Real-Time Analytics

```javascript
// Track page views
await redis.incr(`pageviews:${pageId}`);

// Track unique visitors
await redis.pfadd(`visitors:${date}`, userId);

// Get unique count
const count = await redis.pfcount(`visitors:${date}`);
```

## 🎮 Leaderboards

```javascript
// Update score
await redis.zadd('leaderboard', score, playerId);

// Get top players
const topPlayers = await redis.zrevrange('leaderboard', 0, 9, 'WITHSCORES');

// Get player rank
const rank = await redis.zrevrank('leaderboard', playerId);
```

## 📨 Message Queue

```javascript
// Producer
await redis.lpush('queue', JSON.stringify(message));

// Consumer
const message = await redis.brpop('queue', 10);
```

## 🔔 Rate Limiting

```javascript
// Rate limiting
const key = `rate_limit:${userId}`;
const current = await redis.incr(key);
if (current === 1) {
    await redis.expire(key, 60);
}
if (current > 100) {
    throw new Error('Rate limit exceeded');
}
```

## 🎯 Best Practices

1. **Choose appropriate use case** for Redis
2. **Set expiration** for temporary data
3. **Handle cache misses** gracefully
4. **Monitor memory usage**
5. **Use appropriate data structures**

---

**Redis section complete!** Next: Learn about [Elasticsearch](./../03-Elasticsearch/documentation/ELASTICSEARCH-FUNDAMENTALS.md)

