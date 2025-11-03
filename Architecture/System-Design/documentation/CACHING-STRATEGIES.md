# Caching Strategies

## 📚 Overview

Caching stores frequently accessed data in fast storage to improve performance and reduce load on primary data sources.

## 🎯 Cache Patterns

### Cache-Aside (Lazy Loading)

Application checks cache first, then database.

```javascript
async function getUser(id) {
  // 1. Check cache
  let user = await cache.get(`user:${id}`);
  
  if (user) {
    return user; // Cache hit
  }
  
  // 2. Cache miss - fetch from database
  user = await db.getUser(id);
  
  // 3. Store in cache
  await cache.set(`user:${id}`, user, 3600); // TTL: 1 hour
  
  return user;
}
```

**Pros**: Simple, handles cache failures gracefully
**Cons**: Cache miss adds latency

### Write-Through

Write to both cache and database simultaneously.

```javascript
async function updateUser(id, data) {
  // 1. Update database
  const user = await db.updateUser(id, data);
  
  // 2. Update cache
  await cache.set(`user:${id}`, user, 3600);
  
  return user;
}
```

**Pros**: Cache always consistent
**Cons**: Higher write latency

### Write-Behind (Write-Back)

Write to cache immediately, database asynchronously.

```javascript
async function updateUser(id, data) {
  // 1. Update cache immediately
  await cache.set(`user:${id}`, data);
  
  // 2. Queue database write
  await writeQueue.add({ id, data });
  
  return data;
}

// Background processor
setInterval(async () => {
  const writes = await writeQueue.getBatch(100);
  await db.batchUpdate(writes);
}, 5000); // Every 5 seconds
```

**Pros**: Very fast writes
**Cons**: Risk of data loss on cache failure

### Refresh-Ahead

Proactively refresh cache before expiration.

```javascript
async function getUser(id) {
  let user = await cache.get(`user:${id}`);
  
  if (user) {
    // Check if near expiration
    const ttl = await cache.ttl(`user:${id}`);
    if (ttl < 60) { // Less than 1 minute left
      // Refresh in background
      refreshUserCache(id); // Don't await
    }
    return user;
  }
  
  // Cache miss
  user = await db.getUser(id);
  await cache.set(`user:${id}`, user, 3600);
  return user;
}
```

## 🔧 Cache Invalidation

### Time-Based Expiration (TTL)

```javascript
// Set expiration time
await cache.set('key', 'value', 3600); // Expires in 1 hour

// Automatic cleanup
const ttl = 3600; // seconds
await redis.setex('key', ttl, 'value');
```

### Event-Based Invalidation

```javascript
// Invalidate on update
async function updateUser(id, data) {
  await db.updateUser(id, data);
  await cache.del(`user:${id}`); // Invalidate cache
}

// Invalidate related caches
async function deletePost(postId, userId) {
  await db.deletePost(postId);
  await cache.del(`post:${postId}`);
  await cache.del(`user:${userId}:posts`); // User's post list
}
```

### Version-Based Invalidation

```javascript
async function getUser(id) {
  const version = await cache.get(`user:${id}:version`) || 0;
  const user = await cache.get(`user:${id}:v${version}`);
  
  if (!user) {
    const dbUser = await db.getUser(id);
    const newVersion = version + 1;
    await cache.set(`user:${id}:version`, newVersion);
    await cache.set(`user:${id}:v${newVersion}`, dbUser);
    return dbUser;
  }
  
  return user;
}
```

## 📊 Cache Levels

### Browser Cache

```javascript
// Cache-Control headers
app.get('/api/data', (req, res) => {
  res.setHeader('Cache-Control', 'public, max-age=3600'); // 1 hour
  res.json(data);
});

// ETag for validation
app.get('/api/data', (req, res) => {
  const etag = generateETag(data);
  if (req.headers['if-none-match'] === etag) {
    return res.status(304).end(); // Not Modified
  }
  res.setHeader('ETag', etag);
  res.json(data);
});
```

### CDN Cache

```javascript
// Static assets with long cache
app.use('/static', express.static('public', {
  maxAge: '1y', // 1 year
  etag: true
}));

// API responses with short cache
app.get('/api/posts', (req, res) => {
  res.setHeader('Cache-Control', 'public, max-age=300'); // 5 minutes
  res.json(posts);
});
```

### Application Cache (Redis)

```javascript
const Redis = require('ioredis');
const redis = new Redis();

async function getCachedData(key) {
  const cached = await redis.get(key);
  if (cached) {
    return JSON.parse(cached);
  }
  return null;
}

async function setCachedData(key, data, ttl = 3600) {
  await redis.setex(key, ttl, JSON.stringify(data));
}
```

### Database Query Cache

```javascript
// Cache query results
async function getPopularPosts() {
  const cacheKey = 'popular-posts';
  let posts = await cache.get(cacheKey);
  
  if (!posts) {
    posts = await db.query(`
      SELECT * FROM posts 
      WHERE views > 1000 
      ORDER BY views DESC 
      LIMIT 10
    `);
    await cache.set(cacheKey, posts, 1800); // 30 minutes
  }
  
  return posts;
}
```

## 🎯 Cache Key Design

```javascript
// Good key design
const keys = {
  user: (id) => `user:${id}`,
  userPosts: (userId) => `user:${userId}:posts`,
  post: (id) => `post:${id}`,
  popularPosts: (limit) => `posts:popular:${limit}`,
  search: (query, page) => `search:${query}:page:${page}`
};

// Namespace keys
const namespace = 'myapp';
const key = `${namespace}:user:${id}`;
```

## ⚡ Cache Performance Tips

1. **Use appropriate TTL**: Balance freshness vs performance
2. **Batch operations**: Use MGET, MSET for multiple keys
3. **Compress large values**: Use compression for large data
4. **Monitor cache hit ratio**: Aim for >80% hit rate
5. **Use appropriate eviction policy**: LRU for most cases

---

**Next**: Learn about [Database Design](./DATABASE-SCALING.md)

