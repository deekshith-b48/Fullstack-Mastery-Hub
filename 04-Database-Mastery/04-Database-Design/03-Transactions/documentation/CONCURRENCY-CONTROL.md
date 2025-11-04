# Concurrency Control

## 📚 Overview

Concurrency control manages simultaneous access to data to prevent conflicts and ensure data consistency.

## 🔒 Locking Mechanisms

### Pessimistic Locking

```sql
-- Lock row for update
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;

-- Exclusive lock
LOCK TABLE accounts IN EXCLUSIVE MODE;
```

### Optimistic Locking

```sql
-- Use version column
UPDATE accounts 
SET balance = 1000, version = version + 1 
WHERE id = 1 AND version = 5;
```

## 🔄 Deadlock Prevention

### Strategies

1. **Lock ordering**: Always acquire locks in same order
2. **Timeout**: Set lock timeouts
3. **Deadlock detection**: Automatic detection and rollback

## 📊 Isolation Levels

### Read Uncommitted

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Allows dirty reads
```

### Read Committed

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Prevents dirty reads
```

### Repeatable Read

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Prevents non-repeatable reads
```

### Serializable

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Highest isolation, prevents phantom reads
```

## 🎯 Best Practices

1. **Choose appropriate isolation level**
2. **Minimize lock duration**
3. **Avoid deadlocks**
4. **Monitor lock contention**
5. **Use optimistic locking** when appropriate

---

**Next**: Learn about [Backup Strategies](./../04-Backup-Recovery/documentation/BACKUP-STRATEGIES.md)

