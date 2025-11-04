# SQL Server Performance Tuning

## 📚 Overview

Performance tuning in SQL Server involves optimizing queries, indexes, configuration settings, and database design. This guide covers comprehensive optimization techniques.

## 🔍 Query Analysis

### Execution Plans

```sql
-- View estimated execution plan
SET SHOWPLAN_ALL ON;
SELECT * FROM employees WHERE department_id = 5;
SET SHOWPLAN_ALL OFF;

-- View actual execution plan
SET STATISTICS PROFILE ON;
SELECT * FROM employees WHERE department_id = 5;
SET STATISTICS PROFILE OFF;

-- Graphical execution plan
-- Use SQL Server Management Studio
```

### Dynamic Management Views

```sql
-- View top queries
SELECT TOP 10
    qs.execution_count,
    qs.total_elapsed_time / 1000000 AS total_seconds,
    qs.total_elapsed_time / qs.execution_count / 1000000 AS avg_seconds,
    SUBSTRING(qt.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(qt.text)
            ELSE qs.statement_end_offset
        END - qs.statement_start_offset)/2)+1) AS query_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY qs.total_elapsed_time DESC;
```

## ⚙️ Configuration Tuning

### Memory Settings

```sql
-- Configure max server memory
EXEC sp_configure 'max server memory (MB)', 4096;
RECONFIGURE;

-- Configure min server memory
EXEC sp_configure 'min server memory (MB)', 2048;
RECONFIGURE;
```

### Index Optimization

```sql
-- Update statistics
UPDATE STATISTICS employees;

-- Rebuild indexes
ALTER INDEX ALL ON employees REBUILD;

-- Reorganize indexes
ALTER INDEX ALL ON employees REORGANIZE;
```

## 🎯 Best Practices

1. **Monitor query performance** regularly
2. **Use appropriate indexes**
3. **Keep statistics updated**
4. **Tune memory settings**
5. **Use query hints** sparingly
6. **Monitor wait statistics**
7. **Regular maintenance** tasks

---

**SQL Server section complete!** Next: Learn about [MongoDB](./../../02-NoSQL-Databases/01-MongoDB/documentation/MONGODB-FUNDAMENTALS.md)

