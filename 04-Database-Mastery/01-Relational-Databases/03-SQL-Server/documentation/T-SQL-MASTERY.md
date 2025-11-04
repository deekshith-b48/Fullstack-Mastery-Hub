# T-SQL Mastery

## 📚 Overview

T-SQL (Transact-SQL) is Microsoft's extension to SQL, adding procedural programming features, local variables, and control-of-flow statements. This guide covers advanced T-SQL features and techniques.

## 🎯 Variables and Declarations

### Variable Declaration

```sql
-- Declare single variable
DECLARE @name VARCHAR(50);

-- Declare and initialize
DECLARE @name VARCHAR(50) = 'John';
DECLARE @salary DECIMAL(10, 2) = 75000;
DECLARE @count INT = 0;

-- Declare multiple variables
DECLARE @firstName VARCHAR(50), @lastName VARCHAR(50), @age INT;

-- Use variables
SET @name = 'John Doe';
SELECT @name AS employee_name;

-- Assign from query
SELECT @name = first_name FROM employees WHERE id = 1;
```

## 🔄 Control Flow Statements

### IF...ELSE

```sql
-- Simple IF
IF @salary > 100000
    SELECT 'High salary';

-- IF...ELSE
IF @salary > 100000
    SELECT 'High salary'
ELSE
    SELECT 'Normal salary';

-- IF...ELSE IF
IF @salary > 100000
    SELECT 'High salary'
ELSE IF @salary > 50000
    SELECT 'Medium salary'
ELSE
    SELECT 'Low salary';

-- IF with BEGIN...END
IF @count > 0
BEGIN
    SELECT 'Records found';
    SELECT COUNT(*) FROM employees;
END
```

### WHILE Loop

```sql
-- Basic WHILE loop
DECLARE @counter INT = 1;
WHILE @counter <= 10
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END

-- WHILE with BREAK
DECLARE @counter INT = 1;
WHILE @counter <= 100
BEGIN
    IF @counter = 50
        BREAK;
    SET @counter = @counter + 1;
END

-- WHILE with CONTINUE
DECLARE @counter INT = 0;
WHILE @counter < 10
BEGIN
    SET @counter = @counter + 1;
    IF @counter % 2 = 0
        CONTINUE;
    PRINT @counter;
END
```

### CASE Statement

```sql
-- Simple CASE
SELECT 
    first_name,
    CASE department_id
        WHEN 1 THEN 'Sales'
        WHEN 2 THEN 'Marketing'
        WHEN 3 THEN 'IT'
        ELSE 'Other'
    END AS department
FROM employees;

-- Searched CASE
SELECT 
    first_name,
    salary,
    CASE
        WHEN salary > 100000 THEN 'High'
        WHEN salary > 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_range
FROM employees;
```

## 📊 Common Table Expressions (CTEs)

### Basic CTE

```sql
-- Simple CTE
WITH high_salary_employees AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT * FROM high_salary_employees;

-- Multiple CTEs
WITH 
    dept_stats AS (
        SELECT department_id, AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
    ),
    high_avg_depts AS (
        SELECT department_id 
        FROM dept_stats 
        WHERE avg_salary > 70000
    )
SELECT e.* 
FROM employees e
INNER JOIN high_avg_depts h ON e.department_id = h.department_id;
```

### Recursive CTE

```sql
-- Recursive CTE for hierarchy
WITH employee_hierarchy AS (
    -- Anchor member
    SELECT id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive member
    SELECT e.id, e.first_name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;
```

## 🔍 Window Functions

### ROW_NUMBER, RANK, DENSE_RANK

```sql
-- ROW_NUMBER
SELECT 
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- RANK (with gaps)
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- DENSE_RANK (without gaps)
SELECT 
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- With PARTITION BY
SELECT 
    department_id,
    first_name,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;
```

### LAG and LEAD

```sql
-- LAG (previous row)
SELECT 
    sale_date,
    sales,
    LAG(sales, 1) OVER (ORDER BY sale_date) AS previous_sales,
    sales - LAG(sales, 1) OVER (ORDER BY sale_date) AS change
FROM sales_data;

-- LEAD (next row)
SELECT 
    sale_date,
    sales,
    LEAD(sales, 1) OVER (ORDER BY sale_date) AS next_sales
FROM sales_data;
```

### Aggregate Window Functions

```sql
-- Running totals
SELECT 
    date,
    sales,
    SUM(sales) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales_data;

-- Window frame
SELECT 
    date,
    sales,
    AVG(sales) OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_day_avg
FROM sales_data;
```

## 📝 Dynamic SQL

### EXEC

```sql
-- Dynamic SQL with EXEC
DECLARE @sql NVARCHAR(MAX);
DECLARE @tableName NVARCHAR(100) = 'employees';

SET @sql = 'SELECT * FROM ' + @tableName;
EXEC sp_executesql @sql;

-- With parameters
DECLARE @sql NVARCHAR(MAX);
DECLARE @deptId INT = 5;

SET @sql = 'SELECT * FROM employees WHERE department_id = @deptId';
EXEC sp_executesql @sql, N'@deptId INT', @deptId = @deptId;
```

## 🎯 Best Practices

1. **Use parameterized queries** to prevent SQL injection
2. **Avoid dynamic SQL** when possible
3. **Use CTEs** for complex queries
4. **Leverage window functions** for analytical queries
5. **Test thoroughly** before deploying
6. **Document complex logic** in comments

---

**Next**: Learn about [Stored Procedures](./STORED-PROCEDURES.md)

