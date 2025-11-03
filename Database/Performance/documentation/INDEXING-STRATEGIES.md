# Indexing Strategies

## 📚 Overview

Indexes improve query performance by allowing faster data retrieval without scanning entire tables.

## 🎯 Types of Indexes

### B-Tree Index (Most Common)

```sql
-- Default index type
CREATE INDEX idx_users_email ON users(email);

-- Composite index
CREATE INDEX idx_users_name_email ON users(name, email);

-- Partial index (PostgreSQL)
CREATE INDEX idx_active_users ON users(email) WHERE status = 'active';
```

**Use Cases**: Equality, range queries, sorting

### Hash Index

```sql
-- Hash index (PostgreSQL)
CREATE INDEX idx_users_email_hash ON users USING HASH(email);
```

**Use Cases**: Exact match lookups only

### Full-Text Index

```sql
-- MySQL
CREATE FULLTEXT INDEX idx_articles_content ON articles(content);

-- PostgreSQL
CREATE INDEX idx_articles_search ON articles 
USING GIN(to_tsvector('english', content));
```

**Use Cases**: Text search

### Composite Index

```sql
-- Order matters!
CREATE INDEX idx_users_name_email ON users(name, email);

-- Can use for:
-- WHERE name = 'John' ✅
-- WHERE name = 'John' AND email = 'john@example.com' ✅
-- WHERE email = 'john@example.com' ❌ (can't use index efficiently)
```

### Covering Index

```sql
-- Include columns in index (PostgreSQL)
CREATE INDEX idx_users_covering ON users(email) INCLUDE (name, age);

-- All data in index, no table lookup needed
SELECT email, name, age FROM users WHERE email = 'test@example.com';
```

## 📊 Index Selection Strategy

### Columns to Index

1. **Primary Keys**: Automatically indexed
2. **Foreign Keys**: Usually should be indexed
3. **WHERE Clause Columns**: Frequently filtered columns
4. **JOIN Columns**: Columns used in joins
5. **ORDER BY Columns**: Columns used for sorting

```sql
-- Frequently filtered
CREATE INDEX idx_users_status ON users(status);

-- Frequently joined
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Frequently sorted
CREATE INDEX idx_orders_date ON orders(order_date);
```

### When NOT to Index

- Small tables (< 1000 rows)
- Columns with low selectivity
- Frequently updated columns (overhead)
- Columns rarely used in queries

## 🔍 Query Optimization with Indexes

### Index Usage

```sql
-- Check if index is used
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- PostgreSQL output
-- Index Scan using idx_users_email on users

-- Force index usage (PostgreSQL)
SET enable_seqscan = OFF;
SELECT * FROM users WHERE email = 'test@example.com';
SET enable_seqscan = ON;
```

### Index Maintenance

```sql
-- Update statistics (PostgreSQL)
ANALYZE users;

-- Rebuild index (PostgreSQL)
REINDEX INDEX idx_users_email;

-- Check index size
SELECT 
  schemaname,
  tablename,
  indexname,
  pg_size_pretty(pg_relation_size(indexrelid)) AS size
FROM pg_stat_user_indexes
ORDER BY pg_relation_size(indexrelid) DESC;
```

## ⚡ Best Practices

1. **Index Selectivity**: Index columns with high selectivity
2. **Composite Order**: Order columns by selectivity
3. **Monitor Usage**: Remove unused indexes
4. **Avoid Over-Indexing**: Too many indexes slow writes
5. **Partial Indexes**: Index subset of data when possible

```sql
-- High selectivity (good)
CREATE INDEX idx_users_email ON users(email); -- Most emails unique

-- Low selectivity (may not help much)
CREATE INDEX idx_users_gender ON users(gender); -- Only 2-3 values
```

---

**Next**: Learn about [Query Optimization](./QUERY-OPTIMIZATION.md)

