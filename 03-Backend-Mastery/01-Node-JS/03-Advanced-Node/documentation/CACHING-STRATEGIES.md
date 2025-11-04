# Node.js Caching Strategies

## 📚 Overview

Caching improves performance by storing frequently accessed data.

## 🎯 Caching Strategies

### 1. In-Memory Caching

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 });

async function getData(key) {
  let data = cache.get(key);
  if (!data) {
    data = await fetchFromDatabase(key);
    cache.set(key, data);
  }
  return data;
}
```

### 2. Redis Caching

```javascript
const redis = require('redis');
const client = redis.createClient();

async function getData(key) {
  let data = await client.get(key);
  if (!data) {
    data = await fetchFromDatabase(key);
    await client.setex(key, 600, JSON.stringify(data));
  } else {
    data = JSON.parse(data);
  }
  return data;
}
```

### 3. Cache-Aside Pattern

```javascript
async function getData(key) {
  // Check cache
  let data = await cache.get(key);
  
  if (!data) {
    // Cache miss - fetch from database
    data = await database.get(key);
    
    // Store in cache
    await cache.set(key, data, 600);
  }
  
  return data;
}
```

### 4. Write-Through Cache

```javascript
async function setData(key, value) {
  // Write to database
  await database.set(key, value);
  
  // Update cache
  await cache.set(key, value, 600);
}
```

### 5. Cache Invalidation

```javascript
async function updateData(key, value) {
  // Update database
  await database.set(key, value);
  
  // Invalidate cache
  await cache.del(key);
}
```

---

**Next**: Learn about [Load Balancing](./LOAD-BALANCING.md)

