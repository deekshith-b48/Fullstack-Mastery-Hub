# Database Replication Strategies

## 📚 Overview

Replication creates copies of data across multiple servers for high availability and read scalability.

## 🔄 Replication Types

### Master-Slave Replication

```
MASTER (writes) → SLAVE 1 (reads)
               → SLAVE 2 (reads)
               → SLAVE 3 (reads)
```

**Characteristics:**
- Single master for writes
- Multiple slaves for reads
- Simple setup
- Single point of failure (master)

### Master-Master Replication

```
MASTER 1 ↔ MASTER 2
  ↓         ↓
SLAVE 1   SLAVE 2
```

**Characteristics:**
- Multiple masters
- Write to any master
- More complex
- Conflict resolution needed

### Multi-Master Replication

```
MASTER 1 ↔ MASTER 2 ↔ MASTER 3
```

**Characteristics:**
- All nodes can write
- Highest availability
- Complex conflict resolution
- Network overhead

## 📊 Replication Methods

### Synchronous Replication

```sql
-- Wait for all replicas to confirm
-- Strong consistency
-- Higher latency
```

### Asynchronous Replication

```sql
-- Don't wait for replicas
-- Eventual consistency
-- Lower latency
```

## 🎯 Best Practices

1. **Choose appropriate** replication type
2. **Monitor replication lag**
3. **Plan for failover**
4. **Test replication** regularly
5. **Handle conflicts** properly

---

**Database Design section files created!** All 135 files complete!

