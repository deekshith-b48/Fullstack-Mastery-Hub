# Index Optimization

## 📚 Overview

Optimizing indexes improves query performance and reduces storage overhead. This guide covers index optimization techniques.

## 🔍 Query Analysis

### Explain Plans

```sql
-- PostgreSQL: Analyze query execution
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'john@example.com';

-- Check if index is used
-- Look for "Index Scan" or "Index Only Scan"
```

### Missing Indexes

```sql
-- PostgreSQL: Find missing indexes
SELECT 
    schemaname,
    tablename,
    seq_scan,
    seq_tup_read,
    idx_scan,
    seq_tup_read / seq_scan as avg_seq_read
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY seq_tup_read DESC;
```

## 📊 Index Design Optimization

### Covering Indexes

```sql
-- Include all columns needed for query
CREATE INDEX idx_user_covering 
ON users(email) 
INCLUDE (name, created_at);

-- Query can use index only
SELECT email, name, created_at 
FROM users 
WHERE email = 'john@example.com';
```

### Partial Indexes

```sql
-- Index only subset of rows
CREATE INDEX idx_active_users 
ON users(email) 
WHERE active = true;

-- More efficient than full index
```

### Expression Indexes

```sql
-- Index on expression
CREATE INDEX idx_lower_email 
ON users(LOWER(email));

-- Query uses index
SELECT * FROM users WHERE LOWER(email) = 'john@example.com';
```

## 🎯 Best Practices

1. **Analyze queries** before indexing
2. **Use covering indexes** for common queries
3. **Create partial indexes** for filtered queries
4. **Monitor index effectiveness**
5. **Balance** number of indexes

---

**Next**: Continue learning about indexing.

