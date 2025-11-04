# Cassandra Maintenance Operations

## 📚 Overview

Maintenance operations in Cassandra include repair, compaction, cleanup, and node management tasks.

## 🔧 Repair

### Full Repair

```bash
# Run repair on all keyspaces
nodetool repair

# Repair specific keyspace
nodetool repair myapp

# Repair specific table
nodetool repair myapp employees
```

### Incremental Repair

```bash
# Enable incremental repair
nodetool repair -pr

# Full repair with incremental
nodetool repair -full
```

## 📊 Compaction

### Compaction Types

```sql
-- SizeTieredCompactionStrategy
ALTER TABLE employees WITH compaction = {
    'class': 'SizeTieredCompactionStrategy'
};

-- LeveledCompactionStrategy
ALTER TABLE employees WITH compaction = {
    'class': 'LeveledCompactionStrategy'
};

-- TimeWindowCompactionStrategy
ALTER TABLE employees WITH compaction = {
    'class': 'TimeWindowCompactionStrategy',
    'compaction_window_unit': 'DAYS',
    'compaction_window_size': 1
};
```

### Manual Compaction

```bash
# Force compaction
nodetool compact myapp employees
```

## 🧹 Cleanup

```bash
# Cleanup (remove deleted data)
nodetool cleanup

# Cleanup specific keyspace
nodetool cleanup myapp
```

## 📈 Node Management

### Decommission Node

```bash
# Decommission node
nodetool decommission
```

### Remove Node

```bash
# Remove dead node
nodetool removenode <node-id>
```

### Rebuild Node

```bash
# Rebuild from other nodes
nodetool rebuild
```

## 🎯 Best Practices

1. **Run repair regularly**
2. **Monitor compaction**
3. **Cleanup after deletions**
4. **Plan maintenance windows**
5. **Backup before major operations**

---

**Next**: Learn about [Use Cases](./USE-CASES.md)

