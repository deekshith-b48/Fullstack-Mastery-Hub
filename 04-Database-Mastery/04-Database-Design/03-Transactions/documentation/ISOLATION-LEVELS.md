# Transaction Isolation Levels

## 📚 Overview

Isolation levels control how transactions interact with each other. This guide covers different isolation levels and their trade-offs.

## 🔄 Isolation Levels

### Read Uncommitted

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Allows dirty reads
-- Lowest isolation level
-- Fastest performance
-- Risk of inconsistent data
```

**Characteristics:**
- Dirty reads allowed
- No locks for reads
- Fastest performance
- Lowest consistency

### Read Committed

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Prevents dirty reads
-- Default in most databases
-- Balanced approach
```

**Characteristics:**
- No dirty reads
- Locks held until end of statement
- Non-repeatable reads possible
- Good balance

### Repeatable Read

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Prevents non-repeatable reads
-- Locks held for transaction duration
```

**Characteristics:**
- No non-repeatable reads
- Locks held until commit
- Phantom reads possible
- Higher consistency

### Serializable

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Highest isolation level
-- Prevents all anomalies
-- Slowest performance
```

**Characteristics:**
- No anomalies
- Strictest locking
- Slowest performance
- Highest consistency

## 📊 Isolation Anomalies

### Dirty Read

```sql
-- Transaction 1
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;

-- Transaction 2 (Read Uncommitted)
BEGIN;
SELECT balance FROM accounts WHERE id = 1;  -- Sees uncommitted change

-- Transaction 1
ROLLBACK;  -- Change is rolled back, but Transaction 2 saw it
```

### Non-Repeatable Read

```sql
-- Transaction 1
BEGIN;
SELECT balance FROM accounts WHERE id = 1;  -- Returns 1000

-- Transaction 2
BEGIN;
UPDATE accounts SET balance = 2000 WHERE id = 1;
COMMIT;

-- Transaction 1
SELECT balance FROM accounts WHERE id = 1;  -- Returns 2000 (different!)
COMMIT;
```

### Phantom Read

```sql
-- Transaction 1
BEGIN;
SELECT COUNT(*) FROM accounts WHERE balance > 1000;  -- Returns 5

-- Transaction 2
BEGIN;
INSERT INTO accounts (balance) VALUES (2000);
COMMIT;

-- Transaction 1
SELECT COUNT(*) FROM accounts WHERE balance > 1000;  -- Returns 6 (phantom row!)
COMMIT;
```

## 🎯 Best Practices

1. **Use appropriate isolation level** for use case
2. **Balance** consistency and performance
3. **Understand** isolation anomalies
4. **Test** concurrent scenarios
5. **Monitor** lock contention

---

**Next**: Continue learning about transactions.

