# PostgreSQL Performance Tuning

## 📚 Overview

Performance tuning in PostgreSQL involves optimizing queries, indexes, configuration settings, and database design to achieve maximum efficiency and throughput. This guide covers comprehensive performance optimization techniques.

## 🔍 Query Analysis

### EXPLAIN and EXPLAIN ANALYZE

```sql
-- Basic EXPLAIN
EXPLAIN SELECT * FROM employees WHERE department_id = 5;

-- EXPLAIN with ANALYZE (actually executes query)
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 5;

-- EXPLAIN with detailed output
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT * FROM employees WHERE department_id = 5;

-- EXPLAIN with format options
EXPLAIN (FORMAT JSON) 
SELECT * FROM employees WHERE department_id = 5;

EXPLAIN (FORMAT XML) 
SELECT * FROM employees WHERE department_id = 5;
```

### Understanding Query Plans

```sql
-- Sequential scan (bad for large tables)
EXPLAIN SELECT * FROM employees WHERE salary > 50000;
-- Seq Scan on employees

-- Index scan (good)
EXPLAIN SELECT * FROM employees WHERE id = 100;
-- Index Scan using employees_pkey

-- Bitmap index scan
EXPLAIN SELECT * FROM employees WHERE department_id IN (1, 2, 3);
-- Bitmap Index Scan

-- Nested loop join
EXPLAIN SELECT e.*, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;
-- Nested Loop

-- Hash join
EXPLAIN SELECT e.*, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;
-- Hash Join (for larger datasets)
```

## 📊 Statistics and Monitoring

### pg_stat_statements

```sql
-- Enable pg_stat_statements extension
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- View top queries by execution time
SELECT 
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    max_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

-- View queries by number of calls
SELECT 
    query,
    calls,
    total_exec_time,
    mean_exec_time
FROM pg_stat_statements
ORDER BY calls DESC
LIMIT 10;

-- Reset statistics
SELECT pg_stat_statements_reset();
```

### Table Statistics

```sql
-- View table statistics
SELECT 
    schemaname,
    tablename,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

-- View index statistics
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;
```

### Database Size Monitoring

```sql
-- Database sizes
SELECT 
    datname,
    pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database
ORDER BY pg_database_size(datname) DESC;

-- Table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - 
                   pg_relation_size(schemaname||'.'||tablename)) AS indexes_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

## ⚙️ Configuration Tuning

### Memory Settings

```sql
-- View current settings
SHOW shared_buffers;
SHOW work_mem;
SHOW maintenance_work_mem;
SHOW effective_cache_size;

-- Recommended settings (in postgresql.conf)
-- shared_buffers = 25% of RAM (but not more than 8GB)
-- work_mem = (RAM - shared_buffers) / (max_connections * 3)
-- maintenance_work_mem = 1GB to 2GB
-- effective_cache_size = 50-75% of RAM
```

### Connection Settings

```sql
-- View connection settings
SHOW max_connections;
SHOW superuser_reserved_connections;

-- Connection pooling recommendations
-- Use connection pooler (pgBouncer) for high connection counts
-- max_connections should be reasonable (typically 100-200)
```

### Query Planner Settings

```sql
-- Random page cost (for SSD)
-- Default: 4.0, SSD: 1.1-1.5
ALTER SYSTEM SET random_page_cost = 1.1;

-- Effective IO concurrency (for SSD)
-- Default: 1, SSD: 200
ALTER SYSTEM SET effective_io_concurrency = 200;

-- Join cost settings
ALTER SYSTEM SET join_collapse_limit = 8;
ALTER SYSTEM SET from_collapse_limit = 8;
```

## 🔄 Vacuum and Maintenance

### VACUUM Operations

```sql
-- Regular VACUUM
VACUUM employees;

-- VACUUM with ANALYZE
VACUUM ANALYZE employees;

-- VACUUM FULL (locks table, reclaims space)
VACUUM FULL employees;

-- VACUUM VERBOSE (shows progress)
VACUUM VERBOSE employees;

-- Auto-vacuum settings
ALTER TABLE employees SET (
    autovacuum_vacuum_scale_factor = 0.1,
    autovacuum_analyze_scale_factor = 0.05
);
```

### REINDEX

```sql
-- Reindex specific index
REINDEX INDEX idx_employees_department;

-- Reindex table
REINDEX TABLE employees;

-- Reindex database
REINDEX DATABASE myapp;

-- Reindex concurrently (PostgreSQL 12+)
REINDEX INDEX CONCURRENTLY idx_employees_department;
```

## 📈 Index Optimization

### Partial Indexes

```sql
-- Index only active employees
CREATE INDEX idx_active_employees 
ON employees (department_id) 
WHERE active = true;

-- Index only high-salary employees
CREATE INDEX idx_high_salary 
ON employees (department_id, salary) 
WHERE salary > 100000;
```

### Expression Indexes

```sql
-- Index on expression
CREATE INDEX idx_lower_email 
ON employees (LOWER(email));

-- Use in queries
SELECT * FROM employees WHERE LOWER(email) = 'john@example.com';
```

### Composite Indexes

```sql
-- Order matters in composite indexes
CREATE INDEX idx_emp_dept_salary 
ON employees (department_id, salary DESC);

-- Query can use index if starts with first column
SELECT * FROM employees 
WHERE department_id = 5 AND salary > 70000;  -- Uses index

SELECT * FROM employees 
WHERE salary > 70000;  -- May not use index efficiently
```

## 🎯 Query Optimization Techniques

### Avoid SELECT *

```sql
-- ❌ Bad: Fetches all columns
SELECT * FROM employees;

-- ✅ Good: Only fetch needed columns
SELECT id, first_name, email FROM employees;
```

### Use LIMIT Appropriately

```sql
-- Limit result sets
SELECT * FROM employees 
ORDER BY salary DESC 
LIMIT 10;

-- Use LIMIT in subqueries
SELECT * FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.id 
    LIMIT 1
);
```

### Optimize JOINs

```sql
-- ❌ Bad: Cartesian product risk
SELECT * FROM employees, departments;

-- ✅ Good: Explicit JOINs
SELECT * FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Use appropriate JOIN type
SELECT * FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;  -- Find employees without departments
```

### Subquery vs JOIN

```sql
-- Sometimes JOIN is faster
-- ❌ Subquery
SELECT * FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE location = 'NYC'
);

-- ✅ JOIN
SELECT DISTINCT e.* FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE d.location = 'NYC';
```

## 💾 Connection Pooling

### pgBouncer Configuration

```ini
# pgbouncer.ini
[databases]
myapp = host=localhost port=5432 dbname=myapp

[pgbouncer]
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 25
reserve_pool_size = 5
```

## 🔍 Materialized Views

```sql
-- Create materialized view
CREATE MATERIALIZED VIEW mv_employee_stats AS
SELECT 
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- Create index on materialized view
CREATE INDEX idx_mv_dept ON mv_employee_stats(department_id);

-- Refresh materialized view
REFRESH MATERIALIZED VIEW mv_employee_stats;

-- Refresh concurrently (PostgreSQL 9.4+)
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_employee_stats;
```

## 📊 Partitioning

### Table Partitioning

```sql
-- Create partitioned table
CREATE TABLE sales (
    id SERIAL,
    sale_date DATE NOT NULL,
    amount DECIMAL(10, 2)
) PARTITION BY RANGE (sale_date);

-- Create partitions
CREATE TABLE sales_2024_q1 PARTITION OF sales
FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE sales_2024_q2 PARTITION OF sales
FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

-- Query automatically uses partition pruning
SELECT * FROM sales WHERE sale_date >= '2024-01-01' AND sale_date < '2024-04-01';
```

## 🎯 Best Practices

1. **Monitor query performance** regularly with pg_stat_statements
2. **Use EXPLAIN ANALYZE** to understand query execution
3. **Create appropriate indexes** but avoid over-indexing
4. **Keep statistics up to date** with regular ANALYZE
5. **Tune configuration parameters** based on workload
6. **Use connection pooling** for high connection counts
7. **Partition large tables** for better performance
8. **Regular maintenance** with VACUUM and REINDEX
9. **Use materialized views** for expensive aggregations
10. **Monitor table and index bloat** regularly

---

**Next**: Learn about [Indexing Strategies](./INDEXING-STRATEGIES.md)

