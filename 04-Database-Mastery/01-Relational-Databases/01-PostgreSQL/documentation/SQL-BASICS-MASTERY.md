# SQL Basics Mastery

## 📚 Overview

SQL (Structured Query Language) is the standard language for managing relational databases. This guide covers fundamental SQL concepts and operations in PostgreSQL.

## 🎯 SQL Fundamentals

SQL is a declarative language used to communicate with databases. It consists of several types of statements:

- **DDL (Data Definition Language)**: CREATE, ALTER, DROP
- **DML (Data Manipulation Language)**: SELECT, INSERT, UPDATE, DELETE
- **DCL (Data Control Language)**: GRANT, REVOKE
- **TCL (Transaction Control Language)**: COMMIT, ROLLBACK, SAVEPOINT

## 📊 SELECT Statement

### Basic SELECT

```sql
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, email FROM employees;

-- Select with expressions
SELECT 
    first_name,
    last_name,
    salary,
    salary * 1.1 AS new_salary
FROM employees;

-- Select with DISTINCT
SELECT DISTINCT department_id FROM employees;

-- Select with column aliases
SELECT 
    first_name AS "First Name",
    last_name AS "Last Name",
    salary AS "Annual Salary"
FROM employees;
```

### WHERE Clause

```sql
-- Comparison operators
SELECT * FROM employees WHERE salary > 75000;
SELECT * FROM employees WHERE salary >= 75000;
SELECT * FROM employees WHERE salary < 75000;
SELECT * FROM employees WHERE salary <= 75000;
SELECT * FROM employees WHERE salary = 75000;
SELECT * FROM employees WHERE salary <> 75000;  -- Not equal

-- Logical operators
SELECT * FROM employees 
WHERE salary > 70000 AND department_id = 5;

SELECT * FROM employees 
WHERE salary > 80000 OR department_id = 3;

SELECT * FROM employees 
WHERE NOT (salary < 50000);

-- IN operator
SELECT * FROM employees 
WHERE department_id IN (1, 2, 3, 5);

SELECT * FROM employees 
WHERE department_id NOT IN (1, 2, 3);

-- BETWEEN operator
SELECT * FROM employees 
WHERE salary BETWEEN 60000 AND 80000;

SELECT * FROM employees 
WHERE hire_date BETWEEN '2020-01-01' AND '2023-12-31';

-- LIKE and ILIKE (pattern matching)
SELECT * FROM employees 
WHERE email LIKE '%@example.com';

SELECT * FROM employees 
WHERE first_name LIKE 'J%';  -- Starts with J

SELECT * FROM employees 
WHERE first_name LIKE '_o%';  -- Second character is 'o'

SELECT * FROM employees 
WHERE first_name ILIKE 'john%';  -- Case-insensitive

-- IS NULL and IS NOT NULL
SELECT * FROM employees WHERE manager_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NOT NULL;
```

### ORDER BY Clause

```sql
-- Ascending order (default)
SELECT * FROM employees ORDER BY salary;

-- Descending order
SELECT * FROM employees ORDER BY salary DESC;

-- Multiple columns
SELECT * FROM employees 
ORDER BY department_id, salary DESC;

-- Using column position
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY 3 DESC;  -- Order by 3rd column (salary)

-- NULLS FIRST/LAST
SELECT * FROM employees 
ORDER BY manager_id NULLS LAST;
```

### LIMIT and OFFSET

```sql
-- Limit number of rows
SELECT * FROM employees ORDER BY salary DESC LIMIT 10;

-- Pagination with OFFSET
-- Page 1 (rows 1-10)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 0;

-- Page 2 (rows 11-20)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 10;

-- Page 3 (rows 21-30)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 20;

-- Using FETCH (SQL standard)
SELECT * FROM employees 
ORDER BY salary DESC 
FETCH FIRST 10 ROWS ONLY;
```

## 🔄 INSERT Statement

### Basic INSERT

```sql
-- Single row insert
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('John', 'Doe', 'john.doe@example.com', 75000);

-- Multiple rows insert
INSERT INTO employees (first_name, last_name, email, salary)
VALUES 
    ('Jane', 'Smith', 'jane.smith@example.com', 80000),
    ('Bob', 'Johnson', 'bob.johnson@example.com', 70000),
    ('Alice', 'Williams', 'alice.williams@example.com', 85000);

-- Insert with default values
INSERT INTO employees (first_name, last_name, email)
VALUES ('Charlie', 'Brown', 'charlie.brown@example.com');

-- Insert with RETURNING clause
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('David', 'Miller', 'david.miller@example.com', 90000)
RETURNING id, first_name, email;

-- Insert from SELECT
INSERT INTO employees_archive (first_name, last_name, email, salary)
SELECT first_name, last_name, email, salary
FROM employees
WHERE hire_date < '2020-01-01';
```

## ✏️ UPDATE Statement

### Basic UPDATE

```sql
-- Update single row
UPDATE employees
SET salary = 80000
WHERE id = 1;

-- Update multiple columns
UPDATE employees
SET 
    salary = 85000,
    department_id = 3,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Update multiple rows
UPDATE employees
SET salary = salary * 1.1  -- 10% raise
WHERE department_id = 5;

-- Update with subquery
UPDATE employees
SET salary = (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = 5
)
WHERE department_id = 5 AND salary < (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = 5
);

-- Update with RETURNING
UPDATE employees
SET salary = 90000
WHERE id = 1
RETURNING id, first_name, salary;
```

## 🗑️ DELETE Statement

```sql
-- Delete specific row
DELETE FROM employees WHERE id = 1;

-- Delete with conditions
DELETE FROM employees 
WHERE salary < 50000;

-- Delete with subquery
DELETE FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE name = 'Closed'
);

-- Delete all rows (be careful!)
DELETE FROM employees;

-- Delete with RETURNING
DELETE FROM employees
WHERE id = 1
RETURNING id, first_name, email;
```

## 📈 Aggregation Functions

### Basic Aggregation

```sql
-- COUNT
SELECT COUNT(*) FROM employees;
SELECT COUNT(DISTINCT department_id) FROM employees;
SELECT COUNT(*) FROM employees WHERE salary > 75000;

-- SUM
SELECT SUM(salary) FROM employees;
SELECT SUM(salary) FROM employees WHERE department_id = 5;

-- AVG
SELECT AVG(salary) FROM employees;
SELECT ROUND(AVG(salary), 2) AS average_salary FROM employees;

-- MIN and MAX
SELECT MIN(salary), MAX(salary) FROM employees;
SELECT MIN(hire_date), MAX(hire_date) FROM employees;

-- All aggregations
SELECT 
    COUNT(*) AS total_employees,
    SUM(salary) AS total_payroll,
    AVG(salary) AS average_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees;
```

### GROUP BY

```sql
-- Group by single column
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

-- Group by multiple columns
SELECT department_id, manager_id, COUNT(*)
FROM employees
GROUP BY department_id, manager_id;

-- Group by with aggregation
SELECT 
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- Group by with expressions
SELECT 
    DATE_TRUNC('month', hire_date) AS hire_month,
    COUNT(*) AS hires
FROM employees
GROUP BY DATE_TRUNC('month', hire_date)
ORDER BY hire_month;
```

### HAVING Clause

```sql
-- Having with aggregation
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 70000;

-- Having with COUNT
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;

-- Having with multiple conditions
SELECT department_id, AVG(salary)
FROM employees
WHERE hire_date > '2020-01-01'
GROUP BY department_id
HAVING AVG(salary) > 70000 AND COUNT(*) > 5;
```

## 🔗 JOIN Operations

### INNER JOIN

```sql
-- Basic inner join
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Inner join with WHERE
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE e.salary > 75000;

-- Multiple joins
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    m.first_name AS manager_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
LEFT JOIN employees m ON e.manager_id = m.id;
```

### LEFT JOIN

```sql
-- Left join (includes all left table rows)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Left join to find employees without departments
SELECT 
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;
```

### RIGHT JOIN

```sql
-- Right join (includes all right table rows)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- Right join to find departments without employees
SELECT 
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id
WHERE e.id IS NULL;
```

### FULL OUTER JOIN

```sql
-- Full outer join (includes all rows from both tables)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;
```

### SELF JOIN

```sql
-- Self join to find manager relationships
SELECT 
    e1.first_name AS employee,
    e1.last_name AS employee_last,
    e2.first_name AS manager,
    e2.last_name AS manager_last
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

## 🔍 Subqueries

### Scalar Subquery

```sql
-- Subquery in SELECT
SELECT 
    first_name,
    last_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;

-- Subquery in WHERE
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Subquery with comparison
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
```

### Subquery with IN

```sql
-- Subquery with IN
SELECT * FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE location = 'New York'
);

-- Subquery with NOT IN
SELECT * FROM employees
WHERE department_id NOT IN (
    SELECT id FROM departments WHERE location = 'Closed'
);
```

### EXISTS Subquery

```sql
-- EXISTS subquery
SELECT * FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments d 
    WHERE d.id = e.department_id 
    AND d.location = 'New York'
);

-- NOT EXISTS
SELECT * FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.id
);
```

## 📝 Common Table Expressions (CTEs)

```sql
-- Simple CTE
WITH high_salary_employees AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT * FROM high_salary_employees;

-- Multiple CTEs
WITH 
    dept_stats AS (
        SELECT 
            department_id,
            AVG(salary) AS avg_salary,
            COUNT(*) AS emp_count
        FROM employees
        GROUP BY department_id
    ),
    high_avg_depts AS (
        SELECT department_id 
        FROM dept_stats 
        WHERE avg_salary > 75000
    )
SELECT e.* 
FROM employees e
INNER JOIN high_avg_depts h ON e.department_id = h.department_id;

-- Recursive CTE
WITH RECURSIVE employee_hierarchy AS (
    -- Base case
    SELECT id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case
    SELECT e.id, e.first_name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;
```

## 🎯 Best Practices

1. **Always use WHERE clause** to filter data before joining
2. **Use appropriate indexes** for frequently queried columns
3. **Avoid SELECT *** in production code
4. **Use parameterized queries** to prevent SQL injection
5. **Use transactions** for multiple related operations
6. **Use EXPLAIN** to analyze query performance
7. **Limit result sets** with LIMIT when appropriate
8. **Use CTEs** for complex queries to improve readability

---

**Next**: Learn about [Advanced Queries](./ADVANCED-QUERIES.md)

