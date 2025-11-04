# Comprehensive Index Strategy

## 📚 Overview

A comprehensive index strategy balances query performance with write performance. This guide covers strategic index planning.

## 📊 Index Planning Process

### Step 1: Identify Query Patterns

```sql
-- Analyze frequently executed queries
SELECT 
    query,
    calls,
    mean_exec_time
FROM pg_stat_statements
ORDER BY calls DESC, mean_exec_time DESC
LIMIT 20;
```

### Step 2: Analyze Filter Conditions

```sql
-- Identify columns used in WHERE clauses
-- Common patterns:
-- WHERE email = ?
-- WHERE status = ? AND created_at > ?
-- WHERE user_id = ? ORDER BY created_at DESC
```

### Step 3: Design Indexes

```sql
-- Create indexes based on query patterns
CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_status_created ON orders(status, created_at);
CREATE INDEX idx_user_created ON posts(user_id, created_at DESC);
```

## 🎯 Index Strategy Matrix

### High-Selectivity Columns

```sql
-- Index unique or high-cardinality columns
CREATE INDEX idx_email ON users(email);  -- Unique
CREATE INDEX idx_phone ON users(phone);  -- High selectivity
```

### Foreign Keys

```sql
-- Index foreign keys for joins
CREATE INDEX idx_order_user_id ON orders(user_id);
CREATE INDEX idx_post_author_id ON posts(author_id);
```

### Sort Columns

```sql
-- Index columns used in ORDER BY
CREATE INDEX idx_created_at ON posts(created_at DESC);
CREATE INDEX idx_price ON products(price ASC);
```

## 📈 Index Maintenance Strategy

### Regular Review

```sql
-- Monthly review of index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    pg_size_pretty(pg_relation_size(indexrelid)) as size
FROM pg_stat_user_indexes
WHERE idx_scan = 0
AND indexname NOT LIKE 'pg_%';
```

### Optimization

```sql
-- Rebuild fragmented indexes
REINDEX INDEX idx_email;

-- Update statistics
ANALYZE users;
```

## 🎯 Best Practices

1. **Index strategically**, not blindly
2. **Monitor index usage** regularly
3. **Remove unused indexes**
4. **Optimize index order**
5. **Balance read and write** performance

---

**Next**: Continue learning about indexing strategies.

