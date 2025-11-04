# Database Caching Strategies

## 📚 Overview

Caching reduces database load by storing frequently accessed data in fast storage. This guide covers caching strategies and patterns.

## 💾 Caching Layers

### Application-Level Caching

```python
# In-memory cache
from functools import lru_cache

@lru_cache(maxsize=1000)
def get_user(user_id):
    return db.query(User).get(user_id)
```

### Database Query Cache

```sql
-- MySQL query cache
SET query_cache_type = ON;
SET query_cache_size = 64M;

-- Query results cached automatically
```

### Distributed Caching

```python
# Redis cache
import redis

cache = redis.Redis(host='localhost', port=6379)

def get_user(user_id):
    # Check cache first
    user = cache.get(f'user:{user_id}')
    if user:
        return json.loads(user)
    
    # Cache miss - fetch from database
    user = db.query(User).get(user_id)
    cache.setex(f'user:{user_id}', 3600, json.dumps(user))
    return user
```

## 🔄 Cache Patterns

### Cache-Aside

```python
# Application manages cache
def get_data(key):
    # Check cache
    data = cache.get(key)
    if data:
        return data
    
    # Fetch from database
    data = db.query(...)
    
    # Store in cache
    cache.set(key, data, ttl=3600)
    return data
```

### Write-Through

```python
# Write to cache and database
def update_data(key, value):
    # Update database
    db.update(key, value)
    
    # Update cache
    cache.set(key, value)
```

### Write-Behind

```python
# Write to cache immediately, database asynchronously
def update_data(key, value):
    # Update cache
    cache.set(key, value)
    
    # Queue for database write
    queue.enqueue('write_to_db', key, value)
```

## 🎯 Best Practices

1. **Cache frequently accessed data**
2. **Set appropriate TTL**
3. **Handle cache invalidation**
4. **Monitor cache hit rates**
5. **Use appropriate cache size**

---

**Next**: Continue learning about scalability.

