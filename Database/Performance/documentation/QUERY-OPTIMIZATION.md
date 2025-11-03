# Query Optimization

## 📚 Overview

Query optimization improves database performance by writing efficient queries and understanding execution plans.

## 🔍 Analyzing Queries

### EXPLAIN Plan

```sql
-- Basic explain
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- With analysis
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- PostgreSQL output shows:
-- - Execution time
-- - Rows scanned
-- - Index usage
-- - Join algorithms
```

### Identifying Slow Queries

```sql
-- PostgreSQL - Enable query logging
SET log_min_duration_statement = 1000; -- Log queries > 1 second

-- MySQL - Slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1; -- Log queries > 1 second
```

## 🎯 Optimization Techniques

### 1. Use Indexes

```sql
-- ✅ Good - Uses index
SELECT * FROM users WHERE email = 'test@example.com';

-- ❌ Bad - Full table scan
SELECT * FROM users WHERE UPPER(email) = 'TEST@EXAMPLE.COM';

-- ✅ Better - Functional index
CREATE INDEX idx_users_email_upper ON users(UPPER(email));
SELECT * FROM users WHERE UPPER(email) = 'TEST@EXAMPLE.COM';
```

### 2. Limit Results

```sql
-- ✅ Good - Limit early
SELECT * FROM orders ORDER BY order_date DESC LIMIT 10;

-- ❌ Bad - Processes all rows
SELECT * FROM orders ORDER BY order_date DESC;
-- Then limit in application
```

### 3. Select Only Needed Columns

```sql
-- ✅ Good - Only needed columns
SELECT id, name, email FROM users;

-- ❌ Bad - All columns
SELECT * FROM users;
```

### 4. Use JOINs Instead of Subqueries

```sql
-- ✅ Good - JOIN
SELECT u.name, o.total
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- ❌ Slower - Subquery
SELECT 
  name,
  (SELECT total FROM orders WHERE user_id = users.id) AS total
FROM users;
```

### 5. Avoid Functions in WHERE Clause

```sql
-- ❌ Bad - Can't use index
SELECT * FROM users WHERE YEAR(created_at) = 2024;

-- ✅ Good - Can use index
SELECT * FROM users 
WHERE created_at >= '2024-01-01' AND created_at < '2025-01-01';
```

### 6. Use EXISTS Instead of COUNT

```sql
-- ✅ Good - Stops at first match
SELECT * FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);

-- ❌ Slower - Counts all matches
SELECT * FROM users u
WHERE (
  SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id
) > 0;
```

## 🔧 Query Rewriting

### Avoid SELECT DISTINCT When Possible

```sql
-- ❌ Unnecessary DISTINCT
SELECT DISTINCT user_id FROM orders WHERE status = 'completed';

-- ✅ Better
SELECT user_id FROM orders 
WHERE status = 'completed'
GROUP BY user_id;
```

### Use UNION ALL Instead of UNION

```sql
-- ✅ Faster if no duplicates
SELECT id FROM table1
UNION ALL
SELECT id FROM table2;

-- ❌ Slower (removes duplicates)
SELECT id FROM table1
UNION
SELECT id FROM table2;
```

### Pagination

```sql
-- ✅ Good - Offset pagination
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 20;

-- ✅ Better - Cursor pagination (for large datasets)
SELECT * FROM users 
WHERE id > last_seen_id 
ORDER BY id 
LIMIT 10;
```

## 📊 Monitoring

### Query Statistics

```sql
-- PostgreSQL
SELECT 
  query,
  calls,
  total_time,
  mean_time,
  max_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

### Index Usage

```sql
-- PostgreSQL
SELECT 
  schemaname,
  tablename,
  indexname,
  idx_scan,
  idx_tup_read,
  idx_tup_fetch
FROM pg_stat_user_indexes
WHERE idx_scan = 0; -- Unused indexes
```

---

**Next**: Learn about [ORM/ODM](./../ORM-ODM/documentation/SEQUELIZE-BASICS.md)

