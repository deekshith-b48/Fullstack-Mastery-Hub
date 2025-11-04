# PostgreSQL Transactions & Concurrency

## 📚 Overview

Transactions ensure data integrity and consistency in PostgreSQL. This guide covers transaction management, ACID properties, isolation levels, concurrency control, and handling concurrent access patterns.

## 🔄 What are Transactions?

A transaction is a sequence of database operations that are executed as a single unit. Transactions follow the ACID properties:

- **Atomicity**: All operations succeed or all fail
- **Consistency**: Database remains in valid state
- **Isolation**: Concurrent transactions don't interfere
- **Durability**: Committed changes are permanent

## 🎯 Basic Transaction Operations

### BEGIN, COMMIT, ROLLBACK

```sql
-- Start a transaction
BEGIN;

-- Perform operations
INSERT INTO employees (first_name, last_name, email) 
VALUES ('John', 'Doe', 'john@example.com');

UPDATE employees SET salary = 80000 WHERE id = 1;

-- Commit transaction
COMMIT;

-- Or rollback
BEGIN;
INSERT INTO employees (first_name, last_name, email) 
VALUES ('Jane', 'Smith', 'jane@example.com');
ROLLBACK;  -- Undoes all changes
```

### Transaction Blocks

```sql
-- Multi-statement transaction
BEGIN;
    INSERT INTO orders (customer_id, total) VALUES (1, 100.00);
    INSERT INTO order_items (order_id, product_id, quantity) 
    VALUES (currval('orders_id_seq'), 5, 2);
    UPDATE inventory SET quantity = quantity - 2 WHERE product_id = 5;
COMMIT;
```

### Savepoints

```sql
-- Create savepoint
BEGIN;
    INSERT INTO employees (first_name, last_name) VALUES ('Alice', 'Brown');
    SAVEPOINT sp1;
    
    UPDATE employees SET salary = 100000 WHERE id = 1;
    
    -- Rollback to savepoint
    ROLLBACK TO SAVEPOINT sp1;
    
    -- Continue transaction
    UPDATE employees SET salary = 90000 WHERE id = 1;
COMMIT;
```

## 🔒 ACID Properties

### Atomicity

```sql
-- All or nothing
BEGIN;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    -- If either fails, both are rolled back
COMMIT;
```

### Consistency

```sql
-- Database constraints ensure consistency
BEGIN;
    -- This will fail if constraint violation
    INSERT INTO employees (email) VALUES ('existing@example.com');
    -- Transaction rolled back automatically
COMMIT;
```

### Isolation

```sql
-- Transactions see consistent snapshot
BEGIN;
    -- See data as of transaction start
    SELECT * FROM employees;
    -- Other transactions' changes not visible yet
COMMIT;
```

### Durability

```sql
-- Once committed, changes are permanent
BEGIN;
    INSERT INTO employees (first_name) VALUES ('John');
COMMIT;  -- Changes written to disk, guaranteed to persist
```

## 📊 Isolation Levels

PostgreSQL supports various isolation levels to control transaction visibility.

### Read Uncommitted (Not Supported)

PostgreSQL doesn't support Read Uncommitted. It uses Read Committed as the minimum.

### Read Committed (Default)

Each statement sees only data committed before the statement began.

```sql
-- Set isolation level
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Each SELECT sees committed data at statement start
SELECT * FROM employees;  -- Sees committed data
-- Other transaction commits
SELECT * FROM employees;  -- May see different data
COMMIT;
```

### Repeatable Read

All statements in a transaction see the same snapshot of data.

```sql
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Both SELECTs see same data
SELECT * FROM employees;
-- Other transaction commits
SELECT * FROM employees;  -- Still sees same data
COMMIT;
```

### Serializable

Strictest level. Transactions are serialized as if executed sequentially.

```sql
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Prevents serialization anomalies
SELECT * FROM employees;
INSERT INTO employees (first_name) VALUES ('John');
COMMIT;
```

## 🔄 Concurrency Control

### MVCC (Multi-Version Concurrency Control)

PostgreSQL uses MVCC to handle concurrent access without locking.

```sql
-- Multiple transactions can read simultaneously
-- Writers don't block readers
-- Readers don't block writers
BEGIN;
    -- Transaction 1 reads
    SELECT * FROM employees;
    
    -- Transaction 2 can still read
    -- Transaction 2 can update (new version created)
COMMIT;
```

### Locking

```sql
-- Row-level locks
BEGIN;
    SELECT * FROM employees WHERE id = 1 FOR UPDATE;
    -- Locks row until transaction commits
    UPDATE employees SET salary = 90000 WHERE id = 1;
COMMIT;

-- Share lock
BEGIN;
    SELECT * FROM employees WHERE id = 1 FOR SHARE;
    -- Other transactions can also lock for share
COMMIT;
```

### Table Locks

```sql
-- Explicit table lock
BEGIN;
    LOCK TABLE employees IN EXCLUSIVE MODE;
    -- Perform operations requiring exclusive access
COMMIT;

-- Lock modes:
-- ACCESS SHARE: Allows SELECT
-- ROW SHARE: Allows SELECT, UPDATE, DELETE
-- ROW EXCLUSIVE: Allows INSERT, UPDATE, DELETE
-- SHARE UPDATE EXCLUSIVE: Allows SELECT, UPDATE
-- SHARE: Prevents DDL
-- SHARE ROW EXCLUSIVE: Prevents most writes
-- EXCLUSIVE: Allows only SELECT
-- ACCESS EXCLUSIVE: Full lock
```

## 🚫 Deadlocks

### Understanding Deadlocks

```sql
-- Transaction 1
BEGIN;
    UPDATE employees SET salary = 80000 WHERE id = 1;
    -- Waits for transaction 2
    
-- Transaction 2
BEGIN;
    UPDATE employees SET salary = 90000 WHERE id = 2;
    UPDATE employees SET salary = 85000 WHERE id = 1;  -- Deadlock!
    
-- PostgreSQL detects and rolls back one transaction
```

### Deadlock Prevention

```sql
-- 1. Always acquire locks in same order
BEGIN;
    UPDATE employees SET salary = 80000 WHERE id = 1;
    UPDATE employees SET salary = 90000 WHERE id = 2;
COMMIT;

-- 2. Use consistent ordering
-- Always lock by ID in ascending order

-- 3. Keep transactions short
-- Reduce lock hold time

-- 4. Use appropriate isolation level
-- Lower isolation = fewer deadlocks
```

### Deadlock Detection

```sql
-- PostgreSQL automatically detects deadlocks
-- One transaction is rolled back with error:
-- ERROR: deadlock detected
```

## 📈 Concurrent Access Patterns

### Read-Write Conflicts

```sql
-- Dirty read (not possible in PostgreSQL)
-- PostgreSQL prevents uncommitted reads

-- Non-repeatable read (Read Committed)
BEGIN;
    SELECT * FROM employees WHERE id = 1;  -- salary = 70000
    -- Other transaction updates
    SELECT * FROM employees WHERE id = 1;  -- salary = 80000 (different!)
COMMIT;

-- Prevent with Repeatable Read
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SELECT * FROM employees WHERE id = 1;  -- salary = 70000
    -- Other transaction updates
    SELECT * FROM employees WHERE id = 1;  -- salary = 70000 (same!)
COMMIT;
```

### Phantom Reads

```sql
-- Phantom read (Repeatable Read prevents)
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SELECT * FROM employees WHERE department_id = 5;  -- 10 rows
    -- Other transaction inserts
    SELECT * FROM employees WHERE department_id = 5;  -- Still 10 rows
COMMIT;

-- Serializable prevents phantom reads
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    SELECT * FROM employees WHERE department_id = 5;
    -- Other transaction inserts - may cause serialization error
COMMIT;
```

## 🔧 Transaction Best Practices

### Keep Transactions Short

```sql
-- ❌ Bad: Long transaction
BEGIN;
    -- Long-running operation
    PERFORM expensive_operation();
    -- Holds locks for long time
COMMIT;

-- ✅ Good: Short transaction
BEGIN;
    -- Quick operation
    UPDATE employees SET salary = 80000 WHERE id = 1;
COMMIT;
```

### Use Appropriate Isolation Level

```sql
-- Use lowest isolation level that meets requirements
-- Default (Read Committed) is usually sufficient
-- Only use Serializable if truly needed
```

### Handle Errors

```sql
-- Use exception handling
BEGIN;
    INSERT INTO employees (email) VALUES ('test@example.com');
EXCEPTION
    WHEN unique_violation THEN
        -- Handle duplicate
        RAISE NOTICE 'Email already exists';
        ROLLBACK;
END;
```

### Lock Ordering

```sql
-- Always lock in same order to prevent deadlocks
BEGIN;
    -- Lock by ID in ascending order
    UPDATE employees SET salary = 80000 WHERE id = 1;
    UPDATE employees SET salary = 90000 WHERE id = 2;
COMMIT;
```

## 🎯 Advanced Topics

### Two-Phase Commit

```sql
-- Prepare transaction
BEGIN;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    PREPARE TRANSACTION 'tx1';
    
-- Commit prepared transaction
COMMIT PREPARED 'tx1';

-- Or rollback
ROLLBACK PREPARED 'tx1';
```

### Advisory Locks

```sql
-- Application-level locks
SELECT pg_advisory_lock(123);
-- Perform operations
SELECT pg_advisory_unlock(123);

-- Try lock (non-blocking)
SELECT pg_try_advisory_lock(123);
```

---

**Next**: Learn about [PostgreSQL Administration](./POSTGRES-ADMINISTRATION.md)

