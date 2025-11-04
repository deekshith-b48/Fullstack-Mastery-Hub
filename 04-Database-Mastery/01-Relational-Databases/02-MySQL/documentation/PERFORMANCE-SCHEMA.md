# MySQL Performance Schema

## 📚 Overview

Performance Schema is a feature for monitoring MySQL server execution at a low level. It provides detailed information about server performance and resource usage.

## 🔧 Enable Performance Schema

```sql
-- Check if enabled
SHOW VARIABLES LIKE 'performance_schema';

-- Enable in my.cnf
[mysqld]
performance_schema = ON
```

## 📊 View Instruments

```sql
-- View available instruments
SELECT * FROM performance_schema.setup_instruments
WHERE name LIKE 'statement/%';

-- Enable specific instruments
UPDATE performance_schema.setup_instruments
SET enabled = 'YES'
WHERE name LIKE 'statement/sql/%';
```

## 🔍 Query Performance

### Statement Events

```sql
-- View statement statistics
SELECT 
    sql_text,
    count_star AS executions,
    sum_timer_wait / 1000000000000 AS total_time_sec,
    avg_timer_wait / 1000000000000 AS avg_time_sec,
    max_timer_wait / 1000000000000 AS max_time_sec
FROM performance_schema.events_statements_summary_by_digest
ORDER BY sum_timer_wait DESC
LIMIT 10;
```

### Table I/O

```sql
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

## 🔍 Index Usage

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
ORDER BY sum_timer_read DESC;

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

## 🔒 Connection Statistics

```sql
-- View connection statistics
SELECT 
    user,
    host,
    current_connections,
    total_connections
FROM performance_schema.accounts;

-- View connection events
SELECT 
    thread_id,
    processlist_user,
    processlist_host,
    processlist_db,
    processlist_command,
    processlist_time
FROM performance_schema.threads
WHERE processlist_id IS NOT NULL;
```

## 🎯 Best Practices

1. **Enable Performance Schema** for monitoring
2. **Focus on specific instruments** to reduce overhead
3. **Regularly review statistics** for optimization
4. **Use for troubleshooting** slow queries
5. **Monitor index usage** to identify unused indexes

---

**MySQL section complete!** Next: Learn about [SQL Server](./../03-SQL-Server/documentation/SQL-SERVER-FUNDAMENTALS.md)

