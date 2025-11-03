# Redis Basics

## 📚 Overview

Redis is an in-memory data structure store used as a database, cache, and message broker.

## 🚀 Installation

```bash
# macOS
brew install redis
brew services start redis

# Ubuntu
sudo apt-get install redis-server
sudo systemctl start redis

# Connect
redis-cli
```

## 🎯 Data Structures

### Strings

```javascript
// Node.js with ioredis
const Redis = require('ioredis');
const redis = new Redis();

// Set/Get
await redis.set('key', 'value');
const value = await redis.get('key');

// Set with expiration
await redis.set('key', 'value', 'EX', 3600); // 1 hour
await redis.setex('key', 3600, 'value');

// Increment/Decrement
await redis.incr('counter');
await redis.decr('counter');
await redis.incrby('counter', 5);
```

### Lists

```javascript
// Push/Pop
await redis.lpush('list', 'item1', 'item2');
await redis.rpush('list', 'item3');
const item = await redis.lpop('list');
const item2 = await redis.rpop('list');

// Get range
const items = await redis.lrange('list', 0, -1); // All items
const first10 = await redis.lrange('list', 0, 9);

// Get length
const length = await redis.llen('list');
```

### Sets

```javascript
// Add/Remove
await redis.sadd('tags', 'javascript', 'nodejs', 'backend');
await redis.srem('tags', 'javascript');

// Members
const members = await redis.smembers('tags');

// Operations
const intersection = await redis.sinter('set1', 'set2');
const union = await redis.sunion('set1', 'set2');
const difference = await redis.sdiff('set1', 'set2');

// Check membership
const exists = await redis.sismember('tags', 'javascript');
```

### Hashes

```javascript
// Set/Get
await redis.hset('user:1', 'name', 'John', 'email', 'john@example.com');
const name = await redis.hget('user:1', 'name');

// Get all
const user = await redis.hgetall('user:1');

// Increment
await redis.hincrby('user:1', 'score', 10);
```

### Sorted Sets

```javascript
// Add with score
await redis.zadd('leaderboard', 100, 'player1', 200, 'player2');

// Get by rank
const topPlayers = await redis.zrange('leaderboard', 0, 9, 'WITHSCORES');

// Get by score range
const players = await redis.zrangebyscore('leaderboard', 100, 200);

// Get rank
const rank = await redis.zrank('leaderboard', 'player1');
```

## 🎯 Use Cases

### Caching

```javascript
async function getUser(id) {
  const cacheKey = `user:${id}`;
  let user = await redis.get(cacheKey);
  
  if (user) {
    return JSON.parse(user);
  }
  
  user = await db.getUser(id);
  await redis.setex(cacheKey, 3600, JSON.stringify(user));
  return user;
}
```

### Session Storage

```javascript
// Store session
await redis.setex(`session:${sessionId}`, 3600, JSON.stringify(sessionData));

// Get session
const session = await redis.get(`session:${sessionId}`);
```

### Rate Limiting

```javascript
async function rateLimit(userId, limit = 100) {
  const key = `rate_limit:${userId}`;
  const count = await redis.incr(key);
  
  if (count === 1) {
    await redis.expire(key, 3600);
  }
  
  return count <= limit;
}
```

### Pub/Sub

```javascript
// Publisher
const publisher = new Redis();
await publisher.publish('channel', 'message');

// Subscriber
const subscriber = new Redis();
subscriber.subscribe('channel');
subscriber.on('message', (channel, message) => {
  console.log(`Received: ${message}`);
});
```

---

**Next**: Learn about [Cassandra](./CASSANDRA-BASICS.md)

