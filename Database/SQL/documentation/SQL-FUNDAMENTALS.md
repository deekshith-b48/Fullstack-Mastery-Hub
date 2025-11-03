# SQL Fundamentals

## 📚 Overview

SQL (Structured Query Language) is the standard language for managing relational databases.

## 🎯 Basic Operations

### SELECT

```sql
-- Select all columns
SELECT * FROM users;

-- Select specific columns
SELECT id, name, email FROM users;

-- Select with condition
SELECT * FROM users WHERE age > 18;

-- Select with multiple conditions
SELECT * FROM users 
WHERE age > 18 AND status = 'active';

-- Select with LIKE
SELECT * FROM users WHERE email LIKE '%@gmail.com';

-- Select distinct
SELECT DISTINCT country FROM users;

-- Limit results
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 20; -- Pagination
```

### INSERT

```sql
-- Insert single row
INSERT INTO users (name, email, age)
VALUES ('John Doe', 'john@example.com', 30);

-- Insert multiple rows
INSERT INTO users (name, email, age)
VALUES 
  ('Jane Doe', 'jane@example.com', 25),
  ('Bob Smith', 'bob@example.com', 35);

-- Insert from SELECT
INSERT INTO users_backup (name, email, age)
SELECT name, email, age FROM users WHERE age > 30;
```

### UPDATE

```sql
-- Update single row
UPDATE users 
SET email = 'newemail@example.com'
WHERE id = 1;

-- Update multiple columns
UPDATE users 
SET name = 'John Smith', age = 31
WHERE id = 1;

-- Update with condition
UPDATE products 
SET price = price * 0.9  -- 10% discount
WHERE category = 'electronics';
```

### DELETE

```sql
-- Delete with condition
DELETE FROM users WHERE id = 1;

-- Delete all (be careful!)
DELETE FROM users;

-- Safe delete with condition
DELETE FROM users 
WHERE last_login < NOW() - INTERVAL '1 year';
```

## 🔗 Joins

### INNER JOIN

```sql
-- Get users with their orders
SELECT users.name, orders.total
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- With aliases
SELECT u.name, o.total
FROM users u
INNER JOIN orders o ON u.id = o.user_id;
```

### LEFT JOIN

```sql
-- Get all users, even without orders
SELECT u.name, o.total
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;

-- Find users without orders
SELECT u.name
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;
```

### RIGHT JOIN

```sql
-- Get all orders, even without users
SELECT u.name, o.total
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id;
```

### FULL OUTER JOIN

```sql
-- Get all records from both tables
SELECT u.name, o.total
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id;
```

### Multiple Joins

```sql
SELECT 
  u.name,
  o.order_date,
  p.name AS product_name,
  oi.quantity
FROM users u
INNER JOIN orders o ON u.id = o.user_id
INNER JOIN order_items oi ON o.id = oi.order_id
INNER JOIN products p ON oi.product_id = p.id;
```

## 📊 Aggregations

### GROUP BY

```sql
-- Count orders per user
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id;

-- Total sales by category
SELECT category, SUM(price) AS total_sales
FROM products
GROUP BY category;

-- Average age by country
SELECT country, AVG(age) AS avg_age
FROM users
GROUP BY country;

-- Having clause (filter groups)
SELECT category, SUM(price) AS total_sales
FROM products
GROUP BY category
HAVING SUM(price) > 1000;
```

### Aggregate Functions

```sql
SELECT 
  COUNT(*) AS total_users,
  AVG(age) AS avg_age,
  MIN(age) AS min_age,
  MAX(age) AS max_age,
  SUM(age) AS sum_age
FROM users;
```

## 🔍 Subqueries

```sql
-- Subquery in WHERE
SELECT name, email
FROM users
WHERE id IN (
  SELECT user_id FROM orders WHERE total > 1000
);

-- Correlated subquery
SELECT 
  name,
  (SELECT COUNT(*) FROM orders WHERE user_id = users.id) AS order_count
FROM users;

-- EXISTS
SELECT name
FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);
```

## 📝 Common Table Expressions (CTEs)

```sql
-- Simple CTE
WITH active_users AS (
  SELECT * FROM users WHERE status = 'active'
)
SELECT * FROM active_users;

-- Recursive CTE
WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;
```

## 🔐 Indexes

```sql
-- Create index
CREATE INDEX idx_users_email ON users(email);

-- Composite index
CREATE INDEX idx_users_name_email ON users(name, email);

-- Unique index
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);

-- Drop index
DROP INDEX idx_users_email;
```

---

**Next**: Learn about [Advanced SQL](./ADVANCED-SQL.md)

