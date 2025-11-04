# Cassandra Performance Optimization

## 📚 Overview

Performance optimization in Cassandra involves tuning queries, indexes, configuration, and cluster settings.

## 🔍 Query Optimization

### Use Appropriate WHERE Clauses

```sql
-- ✅ Good: Includes partition key
SELECT * FROM employees WHERE department = 'IT';

-- ❌ Bad: Missing partition key (requires full scan)
SELECT * FROM employees WHERE first_name = 'John';
```

### Limit Results

```sql
-- Limit results
SELECT * FROM employees WHERE department = 'IT' LIMIT 100;
```

## 📊 Indexing

### Secondary Index

```sql
-- Create secondary index (use sparingly)
CREATE INDEX ON employees (email);

-- Query with index
SELECT * FROM employees WHERE email = 'john@example.com';
```

### SASI Index

```sql
-- Create SASI index
CREATE CUSTOM INDEX ON employees (first_name) 
USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = {
    'mode': 'CONTAINS',
    'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer'
};
```

## ⚙️ Configuration Tuning

### JVM Settings

```bash
# cassandra-env.sh
JVM_OPTS="$JVM_OPTS -Xms4G"
JVM_OPTS="$JVM_OPTS -Xmx4G"
```

### Compaction

```sql
-- Configure compaction strategy
ALTER TABLE employees WITH compaction = {
    'class': 'SizeTieredCompactionStrategy'
};
```

## 🎯 Best Practices

1. **Optimize partition keys**
2. **Use appropriate consistency levels**
3. **Monitor query performance**
4. **Tune JVM settings**
5. **Configure compaction** appropriately
6. **Use batches** efficiently

---

**Next**: Learn about [Replication Strategies](./REPLICATION-STRATEGIES.md)

