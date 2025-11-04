# Cassandra Data Modeling

## 📚 Overview

Cassandra data modeling differs from relational databases. This guide covers modeling strategies, partition keys, and clustering columns.

## 🎯 Modeling Principles

### Denormalization

```sql
-- Denormalize for query patterns
-- Instead of JOINs, duplicate data across tables

-- Table 1: Employees by department
CREATE TABLE employees_by_department (
    department TEXT,
    id UUID,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    PRIMARY KEY (department, id)
);

-- Table 2: Employees by email
CREATE TABLE employees_by_email (
    email TEXT PRIMARY KEY,
    id UUID,
    first_name TEXT,
    last_name TEXT,
    department TEXT
);
```

### Partition Key

```sql
-- Partition key determines data distribution
CREATE TABLE employees (
    department TEXT,      -- Partition key
    id UUID,             -- Clustering column
    first_name TEXT,
    last_name TEXT,
    PRIMARY KEY (department, id)
);

-- Good partition key: High cardinality, even distribution
-- Bad partition key: Low cardinality, uneven distribution
```

### Clustering Columns

```sql
-- Clustering columns determine sort order within partition
CREATE TABLE employees (
    department TEXT,
    hire_date DATE,
    id UUID,
    first_name TEXT,
    PRIMARY KEY (department, hire_date, id)
) WITH CLUSTERING ORDER BY (hire_date DESC, id ASC);
```

## 📊 Query-Driven Design

### Design for Access Patterns

```sql
-- If you need to query by department and date
CREATE TABLE employees_by_dept_date (
    department TEXT,
    hire_date DATE,
    id UUID,
    first_name TEXT,
    last_name TEXT,
    PRIMARY KEY (department, hire_date, id)
) WITH CLUSTERING ORDER BY (hire_date DESC);

-- Query example
SELECT * FROM employees_by_dept_date
WHERE department = 'IT' AND hire_date >= '2020-01-01';
```

## 🎯 Best Practices

1. **Design tables for queries**, not normalization
2. **Choose partition keys** carefully
3. **Use clustering columns** for sorting
4. **Denormalize** when needed
5. **Create multiple tables** for different query patterns
6. **Consider data distribution**

---

**Next**: Learn about [CQL Mastery](./CQL-MASTERY.md)

