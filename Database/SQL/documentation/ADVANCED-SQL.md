# Advanced SQL Techniques

## 📚 Overview

Advanced SQL covers complex queries, window functions, transactions, and performance optimization.

## 🪟 Window Functions

### ROW_NUMBER, RANK, DENSE_RANK

```sql
-- ROW_NUMBER - Unique sequential number
SELECT 
  name,
  salary,
  ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- RANK - Gaps in ranking for ties
SELECT 
  name,
  salary,
  RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- DENSE_RANK - No gaps in ranking
SELECT 
  name,
  salary,
  DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;
```

### Partition By

```sql
-- Rank within department
SELECT 
  name,
  department,
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;
```

### LAG and LEAD

```sql
-- Compare with previous row
SELECT 
  date,
  sales,
  LAG(sales, 1) OVER (ORDER BY date) AS prev_sales,
  sales - LAG(sales, 1) OVER (ORDER BY date) AS diff
FROM daily_sales;

-- Compare with next row
SELECT 
  date,
  sales,
  LEAD(sales, 1) OVER (ORDER BY date) AS next_sales
FROM daily_sales;
```

### Aggregate Window Functions

```sql
-- Running total
SELECT 
  date,
  sales,
  SUM(sales) OVER (ORDER BY date) AS running_total
FROM daily_sales;

-- Moving average
SELECT 
  date,
  sales,
  AVG(sales) OVER (
    ORDER BY date 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS moving_avg_7days
FROM daily_sales;
```

## 💾 Transactions

### ACID Properties

- **Atomicity**: All or nothing
- **Consistency**: Valid state transitions
- **Isolation**: Concurrent transactions don't interfere
- **Durability**: Committed changes persist

### Transaction Control

```sql
-- Begin transaction
BEGIN;

-- Multiple operations
INSERT INTO orders (user_id, total) VALUES (1, 100.00);
UPDATE users SET balance = balance - 100.00 WHERE id = 1;

-- Commit or rollback
COMMIT; -- Save changes
-- OR
ROLLBACK; -- Undo changes
```

### Savepoints

```sql
BEGIN;
INSERT INTO orders (user_id, total) VALUES (1, 100.00);
SAVEPOINT sp1;

UPDATE users SET balance = balance - 100.00 WHERE id = 1;
SAVEPOINT sp2;

-- Rollback to savepoint
ROLLBACK TO sp1;

-- Continue or commit
COMMIT;
```

## 🔒 Isolation Levels

```sql
-- Set isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Levels:
-- READ UNCOMMITTED - Can read uncommitted data
-- READ COMMITTED - Only committed data (default)
-- REPEATABLE READ - Same reads throughout transaction
-- SERIALIZABLE - Highest isolation, no phantom reads
```

## 🎯 Common Table Expressions (CTEs)

### Simple CTE

```sql
WITH high_salary_employees AS (
  SELECT * FROM employees WHERE salary > 100000
)
SELECT * FROM high_salary_employees;
```

### Recursive CTE

```sql
-- Generate numbers
WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT * FROM numbers;

-- Hierarchical data (employees and managers)
WITH RECURSIVE employee_hierarchy AS (
  -- Base case
  SELECT id, name, manager_id, 1 AS level
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
  
  -- Recursive case
  SELECT e.id, e.name, e.manager_id, eh.level + 1
  FROM employees e
  INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;
```

## 📊 Advanced Joins

### Self Join

```sql
-- Employees and their managers
SELECT 
  e.name AS employee,
  m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

### Multiple Joins

```sql
SELECT 
  u.name AS user_name,
  o.order_date,
  p.name AS product_name,
  oi.quantity,
  oi.price
FROM users u
INNER JOIN orders o ON u.id = o.user_id
INNER JOIN order_items oi ON o.id = oi.order_id
INNER JOIN products p ON oi.product_id = p.id;
```

## 🔍 Subqueries

### Scalar Subquery

```sql
SELECT 
  name,
  salary,
  (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;
```

### EXISTS Subquery

```sql
-- Users with orders
SELECT name
FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);
```

### Correlated Subquery

```sql
-- Employees earning more than department average
SELECT e1.name, e1.salary, e1.department
FROM employees e1
WHERE e1.salary > (
  SELECT AVG(e2.salary)
  FROM employees e2
  WHERE e2.department = e1.department
);
```

## 📈 Stored Procedures

```sql
-- Create stored procedure
CREATE OR REPLACE FUNCTION get_user_orders(user_id INT)
RETURNS TABLE (
  order_id INT,
  order_date DATE,
  total DECIMAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT o.id, o.order_date, o.total
  FROM orders o
  WHERE o.user_id = get_user_orders.user_id;
END;
$$ LANGUAGE plpgsql;

-- Call procedure
SELECT * FROM get_user_orders(1);
```

## 🔐 Views

```sql
-- Create view
CREATE VIEW user_order_summary AS
SELECT 
  u.id AS user_id,
  u.name,
  COUNT(o.id) AS order_count,
  SUM(o.total) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Use view
SELECT * FROM user_order_summary WHERE total_spent > 1000;
```

## 🚀 Performance Optimization

### Explain Plan

```sql
-- Analyze query execution
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';

-- Check index usage
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM orders WHERE user_id = 1;
```

### Index Hints

```sql
-- Force index usage (PostgreSQL)
SELECT * FROM users USE INDEX (idx_email) WHERE email = 'test@example.com';

-- Ignore index (testing)
SELECT * FROM users IGNORE INDEX (idx_email) WHERE email = 'test@example.com';
```

---

**Next**: Learn about [PostgreSQL Features](./POSTGRESQL-ADVANCED.md)

