# Index Analysis and Tuning

## 📚 Overview

Analyzing index performance helps optimize database queries. This guide covers index analysis techniques and optimization strategies.

## 🔍 Performance Analysis

### Query Execution Plans

```sql
-- PostgreSQL: Analyze query
EXPLAIN ANALYZE
SELECT * FROM users 
WHERE email = 'john@example.com' 
AND age > 25;

-- Look for:
-- - Index Scan (good)
-- - Seq Scan (may need index)
-- - Execution time
```

### Index Usage Statistics

```sql
-- PostgreSQL: Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
ORDER BY idx_scan DESC;
```

### Missing Indexes

```sql
-- Find tables with high sequential scans
SELECT 
    schemaname,
    tablename,
    seq_scan,
    seq_tup_read,
    idx_scan,
    CASE 
        WHEN seq_scan > 0 THEN seq_tup_read / seq_scan 
        ELSE 0 
    END AS avg_seq_read
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY seq_tup_read DESC;
```

## 📊 Index Efficiency

### Selectivity Analysis

```sql
-- High selectivity (good for index)
SELECT COUNT(DISTINCT email) / COUNT(*) as selectivity
FROM users;
-- Result close to 1.0 = high selectivity

-- Low selectivity (may not benefit from index)
SELECT COUNT(DISTINCT status) / COUNT(*) as selectivity
FROM orders;
-- Result close to 0.0 = low selectivity
```

### Index Size vs. Benefit

```sql
-- PostgreSQL: Check index size
SELECT 
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexrelid)) as index_size
FROM pg_stat_user_indexes
ORDER BY pg_relation_size(indexrelid) DESC;
```

## 🎯 Optimization Strategies

### Remove Unused Indexes

```sql
-- Find indexes never used
SELECT 
    schemaname,
    tablename,
    indexname
FROM pg_stat_user_indexes
WHERE idx_scan = 0
AND indexname NOT LIKE 'pg_%';
```

### Combine Indexes

```sql
-- Multiple separate indexes
CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_age ON users(age);

-- Combined index (if queries use both)
CREATE INDEX idx_email_age ON users(email, age);
```

## 🎯 Best Practices

1. **Analyze query patterns** regularly
2. **Monitor index usage**
3. **Remove unused indexes**
4. **Optimize index order**
5. **Test performance** after changes

---

**Next**: Continue learning about indexing.

