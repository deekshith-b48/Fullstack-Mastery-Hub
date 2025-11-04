# Deadlock Handling

## 📚 Overview

Deadlocks occur when two or more transactions wait indefinitely for each other to release locks. This guide covers deadlock detection and prevention.

## 🔒 Deadlock Example

```sql
-- Transaction 1
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
-- Waits for lock on account 2

-- Transaction 2
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 2;
-- Waits for lock on account 1

-- DEADLOCK: Both transactions waiting for each other
```

## 🔍 Deadlock Detection

### Automatic Detection

```sql
-- Most databases detect and resolve automatically
-- One transaction is rolled back
-- Error returned to application
```

### Manual Detection

```sql
-- Monitor for deadlocks
-- PostgreSQL
SELECT * FROM pg_locks WHERE NOT granted;

-- SQL Server
SELECT * FROM sys.dm_tran_locks;
```

## 🛡️ Prevention Strategies

### Lock Ordering

```sql
-- Always acquire locks in same order
-- Transaction 1
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;

-- Transaction 2 (Same order)
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

### Lock Timeout

```sql
-- Set lock timeout
SET lock_timeout = 5000;  -- 5 seconds

-- Transaction will fail if lock not acquired
```

### Short Transactions

```sql
-- Keep transactions short
-- Reduce lock duration
-- Lower deadlock probability
```

## 🔄 Handling Deadlocks

### Retry Logic

```python
# Application-level retry
max_retries = 3
for attempt in range(max_retries):
    try:
        # Database operation
        execute_transaction()
        break
    except DeadlockError:
        if attempt < max_retries - 1:
            sleep(random.uniform(0.1, 0.5))
            continue
        else:
            raise
```

## 🎯 Best Practices

1. **Acquire locks in consistent order**
2. **Keep transactions short**
3. **Use lock timeouts**
4. **Implement retry logic**
5. **Monitor deadlock frequency**

---

**Next**: Continue learning about transactions.

