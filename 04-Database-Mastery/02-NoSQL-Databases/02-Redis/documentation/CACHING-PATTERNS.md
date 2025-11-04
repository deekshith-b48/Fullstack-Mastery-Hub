# Redis Caching Patterns

## 📚 Overview

Caching is one of Redis's primary use cases. This guide covers common caching patterns and strategies for effective cache implementation.

## 🎯 Cache-Aside Pattern

### Implementation

```javascript
// Cache-aside pattern
async function getUser(userId) {
    // Check cache first
    let user = await redis.get(`user:${userId}`);
    
    if (user) {
        return JSON.parse(user);
    }
    
    // Cache miss - fetch from database
    user = await database.getUser(userId);
    
    // Store in cache
    await redis.setex(`user:${userId}`, 3600, JSON.stringify(user));
    
    return user;
}
```

### Update Pattern

```javascript
// Update cache on write
async function updateUser(userId, data) {
    // Update database
    await database.updateUser(userId, data);
    
    // Update cache
    await redis.setex(`user:${userId}`, 3600, JSON.stringify(data));
    
    // Or invalidate cache
    await redis.del(`user:${userId}`);
}
```

## 🔄 Write-Through Pattern

```javascript
// Write-through pattern
async function createUser(user) {
    // Write to database
    const newUser = await database.createUser(user);
    
    // Write to cache
    await redis.setex(`user:${newUser.id}`, 3600, JSON.stringify(newUser));
    
    return newUser;
}
```

## 📝 Write-Behind Pattern

```javascript
// Write-behind pattern (async writes)
async function updateUser(userId, data) {
    // Update cache immediately
    await redis.setex(`user:${userId}`, 3600, JSON.stringify(data));
    
    // Queue for database write
    await queue.enqueue('update_user', { userId, data });
}
```

## 🔑 Key Naming Conventions

```bash
# Use consistent naming
user:123
product:456
session:abc123
cache:user:123:profile

# Use namespaces
app:user:123
app:product:456
```

## ⏰ Expiration Strategies

```bash
# Set expiration
SETEX key 3600 "value"
EXPIRE key 3600

# TTL-based expiration
TTL key

# Refresh expiration
EXPIRE key 3600

# Remove expiration
PERSIST key
```

## 🎯 Best Practices

1. **Set appropriate TTL** for cache entries
2. **Handle cache misses** gracefully
3. **Invalidate stale data** properly
4. **Use consistent key naming**
5. **Monitor cache hit rates**
6. **Handle cache failures** (fallback to database)
7. **Use compression** for large values

---

**Next**: Learn about [Pub/Sub Messaging](./PUB-SUB-MESSAGING.md)

