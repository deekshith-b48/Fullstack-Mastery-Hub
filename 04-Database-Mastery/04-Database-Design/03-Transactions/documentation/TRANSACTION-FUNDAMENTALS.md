# Transaction Fundamentals

## 📚 Overview

Transactions ensure database operations are executed reliably and maintain data integrity. This guide covers ACID properties and transaction management.

## 🔄 ACID Properties

### Atomicity

All operations in a transaction succeed or all fail.

```sql
BEGIN TRANSACTION;
INSERT INTO accounts (id, balance) VALUES (1, 1000);
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
-- If any operation fails, all are rolled back
```

### Consistency

Database remains in a valid state before and after transaction.

### Isolation

Concurrent transactions don't interfere with each other.

```sql
-- Transaction isolation levels
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

### Durability

Committed transactions persist even after system failure.

## 🔍 Transaction States

1. **Active**: Transaction is executing
2. **Partially Committed**: Final statement executed
3. **Committed**: Changes saved permanently
4. **Failed**: Execution aborted
5. **Aborted**: Rolled back to previous state

## 🎯 Best Practices

1. **Keep transactions short**
2. **Use appropriate isolation levels**
3. **Handle errors** and rollback properly
4. **Avoid long-running transactions**
5. **Test concurrent scenarios**

---

**Next**: Learn about [Concurrency Control](./CONCURRENCY-CONTROL.md)

