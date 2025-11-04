# Redis Data Structures

## 📚 Overview

Redis supports various data structures, each optimized for specific use cases. This guide covers all Redis data types and their operations.

## 📝 Strings

### Basic Operations

```bash
# Set and get
SET name "John"
GET name

# Set multiple
MSET key1 "value1" key2 "value2"
MGET key1 key2

# Set if not exists
SETNX key "value"

# Set with expiration
SETEX key 3600 "value"
SET key "value" EX 3600

# Get and set
GETSET key "new_value"
```

### Numeric Operations

```bash
# Increment
INCR counter
INCRBY counter 10

# Decrement
DECR counter
DECRBY counter 5

# Float operations
INCRBYFLOAT price 0.5
```

### String Operations

```bash
# Append
APPEND key " text"

# Get substring
GETRANGE key 0 4

# Set substring
SETRANGE key 6 "new"

# Get string length
STRLEN key
```

## 🗂️ Hashes

### Hash Operations

```bash
# Set field
HSET user:1 name "John"

# Get field
HGET user:1 name

# Set multiple fields
HMSET user:1 name "John" email "john@example.com" age 30

# Get multiple fields
HMGET user:1 name email

# Get all fields and values
HGETALL user:1

# Get all keys
HKEYS user:1

# Get all values
HVALS user:1

# Check existence
HEXISTS user:1 name

# Delete field
HDEL user:1 email

# Get field count
HLEN user:1

# Increment numeric field
HINCRBY user:1 age 1
HINCRBYFLOAT user:1 score 0.5
```

## 📋 Lists

### List Operations

```bash
# Push operations
LPUSH mylist "item1"
RPUSH mylist "item2"

# Pop operations
LPOP mylist
RPOP mylist

# Blocking pop
BLPOP mylist 10
BRPOP mylist 10

# Get by index
LINDEX mylist 0

# Set by index
LSET mylist 0 "new_item"

# Get range
LRANGE mylist 0 -1
LRANGE mylist 0 9

# Get length
LLEN mylist

# Remove elements
LREM mylist 2 "item"  # Remove 2 occurrences

# Trim list
LTRIM mylist 0 9

# Insert before/after
LINSERT mylist BEFORE "item" "new_item"
LINSERT mylist AFTER "item" "new_item"
```

## 🎯 Sets

### Set Operations

```bash
# Add members
SADD myset "member1" "member2"

# Remove members
SREM myset "member1"

# Get all members
SMEMBERS myset

# Check membership
SISMEMBER myset "member1"

# Get random member
SRANDMEMBER myset
SRANDMEMBER myset 3  # Get 3 random members

# Remove and return random
SPOP myset

# Get size
SCARD myset

# Move member
SMOVE source dest "member"

# Set operations
SUNION set1 set2
SINTER set1 set2
SDIFF set1 set2

# Store operations
SUNIONSTORE dest set1 set2
SINTERSTORE dest set1 set2
SDIFFSTORE dest set1 set2
```

## 📊 Sorted Sets

### Sorted Set Operations

```bash
# Add with score
ZADD leaderboard 100 "player1" 200 "player2"

# Get score
ZSCORE leaderboard "player1"

# Get rank
ZRANK leaderboard "player1"
ZREVRANK leaderboard "player1"

# Get range by rank
ZRANGE leaderboard 0 -1
ZREVRANGE leaderboard 0 -1

# Get range by score
ZRANGEBYSCORE leaderboard 50 100
ZREVRANGEBYSCORE leaderboard 100 50

# Get count by score
ZCOUNT leaderboard 50 100

# Increment score
ZINCRBY leaderboard 10 "player1"

# Remove member
ZREM leaderboard "player1"

# Remove by rank
ZREMRANGEBYRANK leaderboard 0 9

# Remove by score
ZREMRANGEBYSCORE leaderboard 50 100

# Get size
ZCARD leaderboard

# Set operations
ZUNIONSTORE dest 2 set1 set2
ZINTERSTORE dest 2 set1 set2
```

## 🔤 Bitmaps

```bash
# Set bit
SETBIT mykey 7 1

# Get bit
GETBIT mykey 7

# Count set bits
BITCOUNT mykey

# Bit operations
BITOP AND dest key1 key2
BITOP OR dest key1 key2
BITOP XOR dest key1 key2
BITOP NOT dest key
```

## 📍 HyperLogLog

```bash
# Add elements
PFADD visitors user1 user2 user3

# Count unique elements
PFCOUNT visitors

# Merge HyperLogLogs
PFMERGE dest hll1 hll2
```

## 🎯 Best Practices

1. **Choose appropriate data type** for each use case
2. **Use hashes** for objects
3. **Use lists** for queues
4. **Use sets** for unique collections
5. **Use sorted sets** for rankings
6. **Use bitmaps** for boolean arrays
7. **Use HyperLogLog** for approximate counting

---

**Next**: Learn about [Caching Patterns](./CACHING-PATTERNS.md)

