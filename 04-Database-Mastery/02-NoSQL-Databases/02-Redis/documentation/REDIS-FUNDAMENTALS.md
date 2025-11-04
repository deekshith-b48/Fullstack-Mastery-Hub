# Redis Fundamentals

## 📚 Overview

Redis (Remote Dictionary Server) is an in-memory data structure store used as a database, cache, and message broker. It's known for its exceptional performance.

## 🎯 What is Redis?

Redis is an open-source, in-memory data structure store that supports strings, hashes, lists, sets, sorted sets, and more. It's often used for caching, session storage, and real-time analytics.

### Key Features

- **In-Memory Storage**: Extremely fast data access
- **Data Structures**: Multiple data types supported
- **Persistence**: Optional disk persistence
- **Replication**: Master-slave replication
- **Pub/Sub**: Publish-subscribe messaging
- **Transactions**: Multi-command atomic operations

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Install Redis
sudo apt update
sudo apt install redis-server

# Start Redis
sudo systemctl start redis-server
sudo systemctl enable redis-server

# Test Redis
redis-cli ping  # Should return PONG
```

### macOS

```bash
# Using Homebrew
brew install redis

# Start Redis
brew services start redis
```

### Windows

Download from: https://github.com/microsoftarchive/redis/releases

## 🔧 Redis CLI

### Connect to Redis

```bash
# Connect to local Redis
redis-cli

# Connect to remote Redis
redis-cli -h hostname -p 6379

# Connect with password
redis-cli -a password
```

### Basic Commands

```bash
# Ping server
PING

# Get server info
INFO

# Get all keys
KEYS *

# Get database size
DBSIZE

# Clear current database
FLUSHDB

# Clear all databases
FLUSHALL
```

## 📊 Data Types

### Strings

```bash
# Set string
SET key "value"

# Get string
GET key

# Set with expiration
SET key "value" EX 3600

# Increment
INCR counter
INCRBY counter 10

# Decrement
DECR counter
DECRBY counter 5

# Append
APPEND key " additional text"
```

### Hashes

```bash
# Set hash field
HSET user:1 name "John" email "john@example.com"

# Get hash field
HGET user:1 name

# Get all hash fields
HGETALL user:1

# Get multiple fields
HMGET user:1 name email

# Set multiple fields
HMSET user:1 name "John" email "john@example.com" age 30

# Increment hash field
HINCRBY user:1 age 1

# Check if field exists
HEXISTS user:1 name

# Delete field
HDEL user:1 email
```

### Lists

```bash
# Push to left
LPUSH mylist "item1"

# Push to right
RPUSH mylist "item2"

# Pop from left
LPOP mylist

# Pop from right
RPOP mylist

# Get list length
LLEN mylist

# Get range
LRANGE mylist 0 -1

# Get element by index
LINDEX mylist 0

# Set element by index
LSET mylist 0 "new_item"
```

### Sets

```bash
# Add to set
SADD myset "member1" "member2"

# Remove from set
SREM myset "member1"

# Get all members
SMEMBERS myset

# Check membership
SISMEMBER myset "member1"

# Get set size
SCARD myset

# Union
SUNION set1 set2

# Intersection
SINTER set1 set2

# Difference
SDIFF set1 set2
```

### Sorted Sets

```bash
# Add with score
ZADD leaderboard 100 "player1"

# Get score
ZSCORE leaderboard "player1"

# Get rank
ZRANK leaderboard "player1"

# Get range by rank
ZRANGE leaderboard 0 -1

# Get range by score
ZRANGEBYSCORE leaderboard 50 100

# Increment score
ZINCRBY leaderboard 10 "player1"
```

## ⏰ Expiration

```bash
# Set expiration (seconds)
EXPIRE key 3600

# Set expiration (milliseconds)
PEXPIRE key 3600000

# Set expiration at timestamp
EXPIREAT key 1640995200

# Get time to live
TTL key

# Remove expiration
PERSIST key
```

## 🔄 Transactions

```bash
# Start transaction
MULTI

# Queue commands
SET key1 "value1"
SET key2 "value2"
INCR counter

# Execute transaction
EXEC

# Discard transaction
DISCARD
```

## 🎯 Best Practices

1. **Use appropriate data types** for each use case
2. **Set expiration** for cache keys
3. **Use pipelines** for multiple commands
4. **Monitor memory usage**
5. **Configure persistence** appropriately
6. **Use connection pooling**
7. **Handle errors** properly

---

**Next**: Learn about [Data Structures](./DATA-STRUCTURES.md)

