# Database Sharding Strategies

## 📚 Overview

Sharding distributes data across multiple databases to improve performance and scalability.

## 🔀 Sharding Strategies

### Hash-Based Sharding

```python
# Shard by hash of user_id
shard_id = hash(user_id) % num_shards

# Route to appropriate shard
shard = shards[shard_id]
```

**Advantages:**
- Even data distribution
- Simple routing

**Disadvantages:**
- Difficult to reshard
- Range queries across shards

### Range-Based Sharding

```python
# Shard by user_id ranges
if user_id < 1000000:
    shard = shard_1
elif user_id < 2000000:
    shard = shard_2
else:
    shard = shard_3
```

**Advantages:**
- Easy to understand
- Range queries efficient within shard

**Disadvantages:**
- Uneven distribution possible
- Hot spots

### Directory-Based Sharding

```python
# Lookup table for shard mapping
shard_map = {
    'user_1': 'shard_1',
    'user_2': 'shard_2',
    ...
}
```

**Advantages:**
- Flexible routing
- Easy to reshard

**Disadvantages:**
- Lookup overhead
- Single point of failure

## 🎯 Best Practices

1. **Choose appropriate** sharding key
2. **Monitor shard** distribution
3. **Plan for resharding**
4. **Handle cross-shard** queries
5. **Test sharding** strategy

---

**Next**: Learn about [Replication Strategies](./REPLICATION-STRATEGIES.md)

