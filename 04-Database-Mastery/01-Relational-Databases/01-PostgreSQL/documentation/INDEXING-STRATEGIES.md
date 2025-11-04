# PostgreSQL Indexing Strategies

## 📚 Overview

Indexes are crucial for query performance in PostgreSQL. This guide covers different index types, when to use them, and best practices for creating and maintaining indexes.

## 🎯 What are Indexes?

Indexes are data structures that improve the speed of data retrieval operations on database tables. They work like a book's index, allowing the database to quickly locate rows without scanning the entire table.

### How Indexes Work

```sql
-- Without index: Sequential scan (slow for large tables)
EXPLAIN SELECT * FROM employees WHERE email = 'john@example.com';
-- Seq Scan on employees

-- With index: Index scan (fast)
CREATE INDEX idx_employees_email ON employees(email);
EXPLAIN SELECT * FROM employees WHERE email = 'john@example.com';
-- Index Scan using idx_employees_email
```

## 📊 Index Types

### B-tree Indexes (Default)

B-tree indexes are the default and most common index type in PostgreSQL. They work well for equality and range queries.

```sql
-- Create B-tree index
CREATE INDEX idx_employees_salary ON employees(salary);

-- B-tree for multiple columns
CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);

-- Unique B-tree index
CREATE UNIQUE INDEX idx_employees_email ON employees(email);

-- B-tree with DESC order
CREATE INDEX idx_employees_salary_desc ON employees(salary DESC);
```

### Hash Indexes

Hash indexes are useful for equality comparisons but not for range queries or sorting.

```sql
-- Create hash index
CREATE INDEX idx_employees_email_hash ON employees USING HASH(email);

-- Hash indexes only support equality operations
SELECT * FROM employees WHERE email = 'john@example.com';  -- Uses hash index
SELECT * FROM employees WHERE email > 'john@example.com';  -- Cannot use hash index
```

### GiST (Generalized Search Tree)

GiST indexes support various data types and search strategies.

```sql
-- GiST for geometric data
CREATE INDEX idx_locations_coords ON locations USING GIST(coordinates);

-- GiST for full-text search
CREATE INDEX idx_products_description_gist 
ON products USING GIST(to_tsvector('english', description));

-- GiST for array operations
CREATE INDEX idx_users_tags_gist ON users USING GIST(tags);
```

### GIN (Generalized Inverted Index)

GIN indexes are excellent for full-text search and array operations.

```sql
-- GIN for full-text search (preferred over GiST)
CREATE INDEX idx_products_description_gin 
ON products USING GIN(to_tsvector('english', description));

-- GIN for JSONB
CREATE INDEX idx_products_attributes_gin ON products USING GIN(attributes);

-- GIN for arrays
CREATE INDEX idx_users_tags_gin ON users USING GIN(tags);

-- GIN with JSONB path queries
SELECT * FROM products 
WHERE attributes @> '{"brand": "Dell"}'::jsonb;
```

### SP-GiST (Space-Partitioned GiST)

SP-GiST is useful for non-balanced data structures.

```sql
-- SP-GiST for text search
CREATE INDEX idx_products_name_spgist 
ON products USING SPGIST(name);

-- SP-GiST for geometric data
CREATE INDEX idx_points_coords_spgist 
ON points USING SPGIST(coordinates);
```

### BRIN (Block Range Index)

BRIN indexes are space-efficient for very large tables with naturally sorted data.

```sql
-- BRIN for timestamp columns
CREATE INDEX idx_sales_date_brin ON sales USING BRIN(sale_date);

-- BRIN with pages_per_range
CREATE INDEX idx_sales_date_brin 
ON sales USING BRIN(sale_date) WITH (pages_per_range = 128);

-- BRIN is efficient for large, sorted tables
SELECT * FROM sales 
WHERE sale_date BETWEEN '2024-01-01' AND '2024-01-31';
```

## 🔍 Index Strategies

### Single Column Indexes

```sql
-- Index on frequently queried column
CREATE INDEX idx_employees_department ON employees(department_id);

-- Index on frequently sorted column
CREATE INDEX idx_employees_salary ON employees(salary);

-- Index on WHERE clause column
CREATE INDEX idx_employees_active ON employees(active) WHERE active = true;
```

### Composite Indexes

Composite indexes include multiple columns. Column order matters!

```sql
-- Composite index
CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);

-- Can use for queries on first column
SELECT * FROM employees WHERE department_id = 5;  -- Uses index

-- Can use for queries on both columns
SELECT * FROM employees 
WHERE department_id = 5 AND salary > 70000;  -- Uses index

-- May not efficiently use for second column only
SELECT * FROM employees WHERE salary > 70000;  -- May not use index efficiently
```

### Partial Indexes

Partial indexes only index a subset of rows, saving space and improving performance.

```sql
-- Index only active employees
CREATE INDEX idx_active_employees 
ON employees(department_id) 
WHERE active = true;

-- Index only high-salary employees
CREATE INDEX idx_high_salary_employees 
ON employees(department_id, salary) 
WHERE salary > 100000;

-- Index only recent employees
CREATE INDEX idx_recent_employees 
ON employees(department_id) 
WHERE hire_date > '2020-01-01';
```

### Expression Indexes

Expression indexes index computed values.

```sql
-- Index on expression
CREATE INDEX idx_lower_email ON employees(LOWER(email));

-- Use in queries
SELECT * FROM employees WHERE LOWER(email) = 'john@example.com';

-- Index on function result
CREATE INDEX idx_employees_year ON employees(EXTRACT(YEAR FROM hire_date));

-- Index on concatenation
CREATE INDEX idx_full_name ON employees((first_name || ' ' || last_name));
```

### Covering Indexes (INCLUDE)

PostgreSQL 11+ supports covering indexes with INCLUDE columns.

```sql
-- Covering index (index-only scan)
CREATE INDEX idx_emp_dept_covering 
ON employees(department_id) 
INCLUDE (first_name, last_name, email);

-- Query can use index-only scan
SELECT department_id, first_name, last_name, email 
FROM employees 
WHERE department_id = 5;  -- May not need to access table
```

## 📈 Index Maintenance

### Checking Index Usage

```sql
-- View index usage statistics
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan;

-- Find unused indexes
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;
```

### Index Size

```sql
-- View index sizes
SELECT 
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
ORDER BY pg_relation_size(indexrelid) DESC;
```

### Rebuilding Indexes

```sql
-- Reindex specific index
REINDEX INDEX idx_employees_email;

-- Reindex table (all indexes)
REINDEX TABLE employees;

-- Reindex concurrently (doesn't lock table)
REINDEX INDEX CONCURRENTLY idx_employees_email;

-- Reindex database
REINDEX DATABASE myapp;
```

### Index Bloat

```sql
-- Check for index bloat
SELECT 
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
    idx_scan,
    idx_tup_read
FROM pg_stat_user_indexes
WHERE idx_scan = 0
AND pg_relation_size(indexrelid) > 1048576;  -- Larger than 1MB
```

## 🎯 Best Practices

### When to Create Indexes

```sql
-- ✅ Good candidates for indexes:
-- 1. Foreign keys
CREATE INDEX idx_employees_department ON employees(department_id);

-- 2. Frequently queried columns
CREATE INDEX idx_employees_email ON employees(email);

-- 3. Columns in WHERE clauses
CREATE INDEX idx_employees_active ON employees(active);

-- 4. Columns in ORDER BY
CREATE INDEX idx_employees_salary ON employees(salary);

-- 5. Columns in JOIN conditions
CREATE INDEX idx_employees_dept ON employees(department_id);
```

### When NOT to Create Indexes

```sql
-- ❌ Avoid indexes on:
-- 1. Small tables (< 1000 rows)
-- 2. Columns with few distinct values
-- 3. Frequently updated columns (balance needed)
-- 4. Columns never used in queries
-- 5. Too many indexes on same table
```

### Index Design Guidelines

1. **Start with foreign keys** - Index all foreign key columns
2. **Index frequently queried columns** - Analyze query patterns
3. **Use composite indexes wisely** - Order matters
4. **Consider partial indexes** - For filtered queries
5. **Monitor index usage** - Remove unused indexes
6. **Balance reads and writes** - More indexes = slower writes
7. **Use appropriate index types** - GIN for arrays/JSONB, BRIN for large sorted data
8. **Regular maintenance** - Reindex when needed

## 🔧 Advanced Indexing

### Concurrent Index Creation

```sql
-- Create index without locking table (PostgreSQL 8.2+)
CREATE INDEX CONCURRENTLY idx_employees_email 
ON employees(email);

-- Drop index concurrently
DROP INDEX CONCURRENTLY idx_employees_email;
```

### Index on Partitioned Tables

```sql
-- Create index on partitioned table
CREATE INDEX idx_sales_date ON sales(sale_date);

-- Automatically creates indexes on all partitions
-- Future partitions will also get the index
```

### Index Fill Factor

```sql
-- Set fill factor (space for updates)
CREATE INDEX idx_employees_email 
ON employees(email) 
WITH (fillfactor = 80);

-- Lower fill factor = more space for updates, larger index
-- Higher fill factor = less space for updates, smaller index
```

## 📊 Index Performance

### Analyzing Index Usage

```sql
-- Enable index usage tracking
SET track_io_timing = on;

-- Analyze query with index
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM employees WHERE email = 'john@example.com';

-- Check if index is used
-- Look for "Index Scan" or "Index Only Scan" in output
```

### Index Scans vs Sequential Scans

```sql
-- PostgreSQL uses sequential scan when:
-- 1. Table is small
-- 2. Most rows match query
-- 3. Index is not selective enough

-- Force index usage (if needed)
SET enable_seqscan = off;
EXPLAIN SELECT * FROM employees WHERE email = 'john@example.com';
SET enable_seqscan = on;
```

## 🎯 Common Patterns

### Indexing for Common Queries

```sql
-- Pattern: WHERE + ORDER BY
CREATE INDEX idx_emp_dept_salary 
ON employees(department_id, salary DESC);

SELECT * FROM employees 
WHERE department_id = 5 
ORDER BY salary DESC;

-- Pattern: WHERE + LIMIT
CREATE INDEX idx_emp_active_salary 
ON employees(active, salary DESC) 
WHERE active = true;

SELECT * FROM employees 
WHERE active = true 
ORDER BY salary DESC 
LIMIT 10;
```

---

**Next**: Learn about [Transactions & Concurrency](./TRANSACTIONS-CONCURRENCY.md)

