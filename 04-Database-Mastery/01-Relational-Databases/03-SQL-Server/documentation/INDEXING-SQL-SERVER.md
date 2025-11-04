# SQL Server Indexing

## 📚 Overview

Indexes are crucial for query performance in SQL Server. This guide covers different index types, creation strategies, and optimization techniques.

## 🎯 Index Types

### Clustered Index

```sql
-- Clustered index (one per table)
CREATE CLUSTERED INDEX idx_employees_id ON employees(id);

-- Primary key creates clustered index by default
ALTER TABLE employees ADD CONSTRAINT PK_employees PRIMARY KEY (id);
```

### Non-Clustered Index

```sql
-- Non-clustered index
CREATE NONCLUSTERED INDEX idx_employees_email ON employees(email);

-- Non-clustered index with multiple columns
CREATE NONCLUSTERED INDEX idx_emp_dept_salary 
ON employees(department_id, salary DESC);
```

### Covering Index

```sql
-- Covering index (includes all columns needed)
CREATE NONCLUSTERED INDEX idx_emp_covering 
ON employees(department_id) 
INCLUDE (first_name, last_name, email);
```

### Filtered Index

```sql
-- Filtered index (only index subset)
CREATE NONCLUSTERED INDEX idx_active_employees 
ON employees(department_id) 
WHERE active = 1;
```

## 📊 Index Maintenance

```sql
-- Rebuild index
ALTER INDEX idx_employees_email ON employees REBUILD;

-- Reorganize index
ALTER INDEX idx_employees_email ON employees REORGANIZE;

-- Update statistics
UPDATE STATISTICS employees;

-- View index fragmentation
SELECT 
    OBJECT_NAME(object_id) AS table_name,
    name AS index_name,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(
    DB_ID(), NULL, NULL, NULL, NULL
) AS ps
INNER JOIN sys.indexes AS i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE avg_fragmentation_in_percent > 30;
```

## 🎯 Best Practices

1. **Create indexes** on frequently queried columns
2. **Monitor fragmentation** regularly
3. **Rebuild/reorganize** indexes as needed
4. **Use covering indexes** for index-only scans
5. **Consider filtered indexes** for selective queries

---

**Next**: Learn about [Maintenance Plans](./MAINTENANCE-PLANS.md)

