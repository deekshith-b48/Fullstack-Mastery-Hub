# Cassandra CQL Mastery

## 📚 Overview

CQL (Cassandra Query Language) is the SQL-like language for interacting with Cassandra. This guide covers advanced CQL features and techniques.

## 🔍 Advanced Queries

### WHERE Clause

```sql
-- Must include partition key
SELECT * FROM employees WHERE department = 'IT';

-- Can filter on clustering columns
SELECT * FROM employees 
WHERE department = 'IT' AND hire_date >= '2020-01-01';

-- IN clause with partition key
SELECT * FROM employees 
WHERE department IN ('IT', 'Sales');
```

### Aggregation

```sql
-- Count
SELECT COUNT(*) FROM employees WHERE department = 'IT';

-- Average
SELECT AVG(salary) FROM employees WHERE department = 'IT';

-- Min/Max
SELECT MIN(salary), MAX(salary) FROM employees WHERE department = 'IT';
```

### Collections

```sql
-- Insert with list
INSERT INTO users (id, hobbies) 
VALUES (uuid(), ['reading', 'coding', 'traveling']);

-- Update list
UPDATE users SET hobbies = hobbies + ['swimming'] WHERE id = uuid();

-- Query list
SELECT * FROM users WHERE id = uuid() AND hobbies CONTAINS 'coding';
```

## 🎯 Best Practices

1. **Always include partition key** in WHERE clause
2. **Use appropriate data types**
3. **Handle collections** efficiently
4. **Use batches** for multiple operations
5. **Monitor query performance**

---

**Next**: Learn about [Clustering Architecture](./CLUSTERING-ARCHITECTURE.md)

