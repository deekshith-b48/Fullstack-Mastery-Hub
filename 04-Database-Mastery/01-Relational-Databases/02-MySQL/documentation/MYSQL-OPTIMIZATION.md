# MySQL Optimization

## 📚 Overview

MySQL optimization involves tuning queries, indexes, configuration settings, and database design to achieve maximum performance. This guide covers comprehensive optimization techniques for MySQL databases.

## 🔍 Query Analysis

### EXPLAIN

```sql
-- Basic EXPLAIN
EXPLAIN SELECT * FROM employees WHERE department_id = 5;

-- EXPLAIN with format options
EXPLAIN FORMAT=JSON SELECT * FROM employees WHERE department_id = 5;
EXPLAIN FORMAT=TREE SELECT * FROM employees WHERE department_id = 5;

-- EXPLAIN ANALYZE (MySQL 8.0.18+)
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 5;
```

### Understanding Query Plans

```sql
-- Full table scan (bad for large tables)
EXPLAIN SELECT * FROM employees WHERE salary > 50000;
-- type: ALL, rows: large number

-- Index scan (good)
EXPLAIN SELECT * FROM employees WHERE id = 100;
-- type: const or ref, key: PRIMARY

-- Range scan
EXPLAIN SELECT * FROM employees WHERE department_id BETWEEN 1 AND 5;
-- type: range

-- Index merge
EXPLAIN SELECT * FROM employees 
WHERE department_id = 5 AND salary > 70000;
-- type: index_merge
```

## 📊 Performance Schema

### Enable Performance Schema

```sql
-- Check if enabled
SHOW VARIABLES LIKE 'performance_schema';

-- View enabled instruments
SELECT * FROM performance_schema.setup_instruments
WHERE enabled = 'YES';

-- View enabled consumers
SELECT * FROM performance_schema.setup_consumers
WHERE enabled = 'YES';
```

### Query Performance Analysis

```sql
-- View top queries by execution time
SELECT 
    sql_text,
    count_star,
    sum_timer_wait / 1000000000000 AS total_time_sec,
    avg_timer_wait / 1000000000000 AS avg_time_sec,
    max_timer_wait / 1000000000000 AS max_time_sec
FROM performance_schema.events_statements_summary_by_digest
ORDER BY sum_timer_wait DESC
LIMIT 10;

-- View table I/O statistics
SELECT 
    object_schema,
    object_name,
    count_read,
    sum_timer_read / 1000000000000 AS read_time_sec,
    count_write,
    sum_timer_write / 1000000000000 AS write_time_sec
FROM performance_schema.table_io_waits_summary_by_table
ORDER BY sum_timer_read + sum_timer_write DESC
LIMIT 10;
```

### Index Statistics

```sql
-- View index usage
SELECT 
    object_schema,
    object_name,
    index_name,
    count_read,
    sum_timer_read / 1000000000000 AS read_time_sec
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE index_name IS NOT NULL
ORDER BY sum_timer_read DESC
LIMIT 10;

-- Find unused indexes
SELECT 
    object_schema,
    object_name,
    index_name
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE index_name IS NOT NULL
AND count_read = 0
AND object_schema NOT IN ('mysql', 'performance_schema', 'information_schema');
```

## ⚙️ Configuration Tuning

### Memory Settings

```ini
# my.cnf or my.ini

# Buffer pool size (most important)
innodb_buffer_pool_size = 4G  # 70-80% of RAM for dedicated server

# Query cache (MySQL 5.7 and earlier)
query_cache_type = 1
query_cache_size = 256M

# Sort buffer
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 2M

# Join buffer
join_buffer_size = 2M

# Temporary tables
tmp_table_size = 64M
max_heap_table_size = 64M

# Table cache
table_open_cache = 4000
table_definition_cache = 2000
```

### Connection Settings

```ini
# Connection settings
max_connections = 200
max_connect_errors = 10
connect_timeout = 10
wait_timeout = 600
interactive_timeout = 600
```

### InnoDB Settings

```ini
# InnoDB settings
innodb_log_file_size = 512M
innodb_log_buffer_size = 64M
innodb_flush_log_at_trx_commit = 1  # For ACID compliance
innodb_flush_log_at_trx_commit = 2  # For better performance (less safe)
innodb_file_per_table = 1
innodb_flush_method = O_DIRECT
innodb_read_io_threads = 4
innodb_write_io_threads = 4
```

## 🔄 Query Optimization

### Use Indexes Properly

```sql
-- Create indexes on frequently queried columns
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_salary ON employees(salary);

-- Composite indexes (order matters)
CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);

-- Use index for WHERE clause
SELECT * FROM employees WHERE department_id = 5;  -- Uses index

-- Use index for ORDER BY
SELECT * FROM employees ORDER BY salary DESC;  -- Uses index if available

-- Covering index (index-only scan)
CREATE INDEX idx_emp_covering ON employees(department_id, first_name, last_name);
SELECT department_id, first_name, last_name 
FROM employees 
WHERE department_id = 5;  -- May use covering index
```

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

-- Join order matters
-- Smaller table first, filtered tables first
SELECT * FROM small_table s
INNER JOIN large_table l ON s.id = l.small_id
WHERE s.active = 1;
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

## 📈 Index Optimization

### Analyze Index Usage

```sql
-- View index usage
SHOW INDEX FROM employees;

-- Check index cardinality
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    CARDINALITY
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'myapp'
AND TABLE_NAME = 'employees';

-- Find duplicate indexes
SELECT 
    s1.TABLE_NAME,
    s1.INDEX_NAME AS idx1,
    s2.INDEX_NAME AS idx2,
    s1.COLUMN_NAME
FROM information_schema.STATISTICS s1
INNER JOIN information_schema.STATISTICS s2
    ON s1.TABLE_SCHEMA = s2.TABLE_SCHEMA
    AND s1.TABLE_NAME = s2.TABLE_NAME
    AND s1.COLUMN_NAME = s2.COLUMN_NAME
WHERE s1.INDEX_NAME < s2.INDEX_NAME
AND s1.TABLE_SCHEMA = 'myapp';
```

### Index Maintenance

```sql
-- Analyze table (update statistics)
ANALYZE TABLE employees;

-- Optimize table (rebuilds indexes)
OPTIMIZE TABLE employees;

-- Check table
CHECK TABLE employees;

-- Repair table
REPAIR TABLE employees;
```

## 💾 Storage Engine Optimization

### InnoDB Optimization

```sql
-- Use InnoDB for most tables
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- columns
) ENGINE=InnoDB;

-- Configure InnoDB settings
SET GLOBAL innodb_buffer_pool_size = 4294967296;  -- 4GB

-- Monitor InnoDB status
SHOW ENGINE INNODB STATUS\G
```

### MyISAM Optimization

```sql
-- Use MyISAM for read-heavy, rarely updated tables
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- columns
) ENGINE=MyISAM;

-- Optimize MyISAM tables
OPTIMIZE TABLE logs;

-- Check table
CHECK TABLE logs;
```

## 🔍 Slow Query Log

### Enable Slow Query Log

```ini
# my.cnf
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow-query.log
long_query_time = 2  # Log queries taking more than 2 seconds
log_queries_not_using_indexes = 1
```

### Analyze Slow Queries

```bash
# Use mysqldumpslow
mysqldumpslow /var/log/mysql/slow-query.log

# Or pt-query-digest (Percona Toolkit)
pt-query-digest /var/log/mysql/slow-query.log

# View slow queries in MySQL
SELECT * FROM mysql.slow_log
ORDER BY query_time DESC
LIMIT 10;
```

## 📊 Table Optimization

### Partitioning

```sql
-- Create partitioned table
CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    sale_date DATE,
    amount DECIMAL(10, 2),
    PRIMARY KEY (id, sale_date)
) PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Query uses partition pruning
SELECT * FROM sales WHERE sale_date >= '2024-01-01';
```

### Normalization

```sql
-- Normalize tables to reduce redundancy
-- Separate related data into different tables
-- Use foreign keys to maintain relationships
```

## 🎯 Best Practices

1. **Monitor query performance** regularly
2. **Use EXPLAIN** to understand query execution
3. **Create appropriate indexes** but avoid over-indexing
4. **Keep statistics updated** with ANALYZE TABLE
5. **Tune configuration parameters** based on workload
6. **Use connection pooling** for high connection counts
7. **Partition large tables** for better performance
8. **Regular maintenance** with OPTIMIZE TABLE
9. **Monitor slow query log** regularly
10. **Use appropriate storage engine** (InnoDB for most cases)

---

**Next**: Learn about [Storage Engines](./STORAGE-ENGINES.md)

