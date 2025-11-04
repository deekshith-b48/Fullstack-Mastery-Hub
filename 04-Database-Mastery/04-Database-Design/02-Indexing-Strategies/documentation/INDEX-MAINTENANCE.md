# Index Maintenance

## 📚 Overview

Regular index maintenance ensures optimal database performance. This guide covers index monitoring, rebuilding, and optimization.

## 🔍 Monitoring Indexes

### Index Usage Statistics

```sql
-- PostgreSQL: Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan as index_scans,
    idx_tup_read as tuples_read,
    idx_tup_fetch as tuples_fetched
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;

-- Find unused indexes
SELECT 
    schemaname,
    tablename,
    indexname
FROM pg_stat_user_indexes
WHERE idx_scan = 0
AND indexname NOT LIKE 'pg_%';
```

### Index Fragmentation

```sql
-- Check index fragmentation (SQL Server)
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

## 🔧 Rebuilding Indexes

### PostgreSQL

```sql
-- Rebuild index
REINDEX INDEX idx_email;

-- Rebuild all indexes on table
REINDEX TABLE users;

-- Rebuild all indexes in database
REINDEX DATABASE myapp;
```

### MySQL

```sql
-- Rebuild index
ALTER TABLE users DROP INDEX idx_email;
ALTER TABLE users ADD INDEX idx_email (email);

-- Optimize table (rebuilds indexes)
OPTIMIZE TABLE users;
```

### SQL Server

```sql
-- Rebuild index
ALTER INDEX idx_email ON users REBUILD;

-- Reorganize index (less aggressive)
ALTER INDEX idx_email ON users REORGANIZE;

-- Rebuild all indexes
ALTER INDEX ALL ON users REBUILD;
```

## 📊 Index Statistics

```sql
-- Update statistics (PostgreSQL)
ANALYZE users;

-- Update statistics (SQL Server)
UPDATE STATISTICS users;
```

## 🎯 Maintenance Schedule

### Recommended

1. **Daily**: Monitor index usage
2. **Weekly**: Update statistics
3. **Monthly**: Rebuild fragmented indexes
4. **Quarterly**: Review and remove unused indexes

## 🎯 Best Practices

1. **Monitor index usage** regularly
2. **Rebuild fragmented indexes**
3. **Update statistics** frequently
4. **Remove unused indexes**
5. **Document maintenance** procedures

---

**Next**: Continue learning about indexing strategies.

