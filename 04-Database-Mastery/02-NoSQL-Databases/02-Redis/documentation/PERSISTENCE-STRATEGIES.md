# Redis Persistence Strategies

## 📚 Overview

Redis offers two persistence mechanisms: RDB (snapshots) and AOF (Append-Only File) to ensure data durability.

## 📸 RDB (Redis Database Backup)

### Configuration

```bash
# redis.conf
save 900 1      # Save after 900s if at least 1 key changed
save 300 10     # Save after 300s if at least 10 keys changed
save 60 10000   # Save after 60s if at least 10000 keys changed

# Manual save
BGSAVE

# Synchronous save
SAVE
```

### RDB Advantages

- Compact file size
- Fast recovery
- Minimal performance impact

## 📝 AOF (Append-Only File)

### Configuration

```bash
# redis.conf
appendonly yes
appendfilename "appendonly.aof"
appendfsync everysec  # always, everysec, no

# Rewrite AOF
BGREWRITEAOF
```

### AOF Advantages

- Better durability
- Easier to understand
- Can recover up to last second

## 🔄 Hybrid Approach

```bash
# Use both RDB and AOF
save 900 1
appendonly yes
appendfsync everysec
```

## 🎯 Best Practices

1. **Choose based on needs**: RDB for speed, AOF for durability
2. **Use AOF** for critical data
3. **Backup regularly** regardless of persistence
4. **Test recovery** procedures
5. **Monitor disk space**

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

