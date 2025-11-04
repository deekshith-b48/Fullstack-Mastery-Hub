# Composite Indexes

## 📚 Overview

Composite indexes include multiple columns and can improve queries that filter or sort on multiple columns.

## 🔍 Composite Index Basics

### Creating Composite Indexes

```sql
-- Two-column index
CREATE INDEX idx_name_email ON users(last_name, first_name);

-- Three-column index
CREATE INDEX idx_dept_salary_date ON employees(department, salary, hire_date);
```

### Column Order Matters

```sql
-- Query: WHERE department = 'IT' AND salary > 50000
-- ✅ Good: Index matches query order
CREATE INDEX idx_dept_salary ON employees(department, salary);

-- ❌ Bad: Index doesn't match query order
CREATE INDEX idx_salary_dept ON employees(salary, department);
```

## 📊 Index Usage Rules

### Left-Prefix Rule

```sql
-- Index: (a, b, c)
-- Can use index for:
-- ✅ WHERE a = ?
-- ✅ WHERE a = ? AND b = ?
-- ✅ WHERE a = ? AND b = ? AND c = ?
-- ❌ WHERE b = ?
-- ❌ WHERE c = ?
-- ❌ WHERE b = ? AND c = ?
```

### Examples

```sql
-- Index on (department, salary, hire_date)
CREATE INDEX idx_emp_composite ON employees(department, salary, hire_date);

-- ✅ Uses index
SELECT * FROM employees 
WHERE department = 'IT' AND salary > 50000;

-- ✅ Uses index (partial)
SELECT * FROM employees 
WHERE department = 'IT';

-- ❌ May not use index efficiently
SELECT * FROM employees 
WHERE salary > 50000;
```

## 🎯 Best Practices

1. **Order columns** by selectivity
2. **Match query patterns** with index order
3. **Consider covering indexes** with INCLUDE
4. **Monitor index usage**
5. **Test index effectiveness**

---

**Next**: Continue learning about indexing.

