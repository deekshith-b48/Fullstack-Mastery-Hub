# Advanced PostgreSQL Queries

## 📚 Overview

Advanced query techniques in PostgreSQL enable complex data retrieval, transformation, and analysis. This guide covers window functions, recursive queries, array operations, JSON queries, and other advanced features.

## 🪟 Window Functions

Window functions perform calculations across a set of table rows related to the current row, without grouping rows into a single output row.

### Basic Window Functions

```sql
-- ROW_NUMBER: Assigns sequential numbers
SELECT 
    first_name,
    last_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- RANK: Assigns rank with gaps for ties
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- DENSE_RANK: Assigns rank without gaps
SELECT 
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- PERCENT_RANK: Relative rank (0 to 1)
SELECT 
    first_name,
    salary,
    PERCENT_RANK() OVER (ORDER BY salary DESC) AS percentile
FROM employees;
```

### Partitioning Windows

```sql
-- Window function with PARTITION BY
SELECT 
    department_id,
    first_name,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;

-- Multiple window functions
SELECT 
    first_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept,
    SUM(salary) OVER (PARTITION BY department_id) AS dept_total,
    COUNT(*) OVER (PARTITION BY department_id) AS dept_size
FROM employees;
```

### Frame Specification

```sql
-- ROWS BETWEEN: Physical rows
SELECT 
    date,
    sales,
    SUM(sales) OVER (
        ORDER BY date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_day_sum
FROM sales_data;

-- RANGE BETWEEN: Logical range
SELECT 
    date,
    sales,
    SUM(sales) OVER (
        ORDER BY date 
        RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
    ) AS seven_day_sum
FROM sales_data;

-- Running totals
SELECT 
    date,
    sales,
    SUM(sales) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales_data;
```

### LAG and LEAD

```sql
-- LAG: Access previous row
SELECT 
    date,
    sales,
    LAG(sales, 1) OVER (ORDER BY date) AS previous_sales,
    sales - LAG(sales, 1) OVER (ORDER BY date) AS change
FROM sales_data;

-- LEAD: Access next row
SELECT 
    date,
    sales,
    LEAD(sales, 1) OVER (ORDER BY date) AS next_sales
FROM sales_data;

-- With default value
SELECT 
    date,
    sales,
    LAG(sales, 1, 0) OVER (ORDER BY date) AS previous_sales
FROM sales_data;
```

### FIRST_VALUE and LAST_VALUE

```sql
-- FIRST_VALUE: First value in window
SELECT 
    department_id,
    first_name,
    salary,
    FIRST_VALUE(first_name) OVER (
        PARTITION BY department_id 
        ORDER BY salary DESC
    ) AS highest_paid
FROM employees;

-- LAST_VALUE: Last value in window
SELECT 
    department_id,
    first_name,
    salary,
    LAST_VALUE(first_name) OVER (
        PARTITION BY department_id 
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_paid
FROM employees;
```

## 🔄 Recursive Queries

Recursive queries allow you to query hierarchical data structures.

### Basic Recursive CTE

```sql
-- Employee hierarchy
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Top-level managers
    SELECT 
        id,
        first_name,
        manager_id,
        1 AS level,
        ARRAY[id] AS path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: Employees reporting to managers
    SELECT 
        e.id,
        e.first_name,
        e.manager_id,
        eh.level + 1,
        eh.path || e.id
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
    WHERE NOT e.id = ANY(eh.path)  -- Prevent cycles
)
SELECT * FROM employee_hierarchy ORDER BY level, id;
```

### Hierarchical Queries

```sql
-- Organizational chart
WITH RECURSIVE org_chart AS (
    SELECT 
        id,
        first_name,
        manager_id,
        first_name AS path
    FROM employees
    WHERE id = 1  -- CEO
    
    UNION ALL
    
    SELECT 
        e.id,
        e.first_name,
        e.manager_id,
        oc.path || ' -> ' || e.first_name
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT * FROM org_chart;
```

### Number Generation

```sql
-- Generate sequence of numbers
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT n FROM numbers;

-- Generate date series
WITH RECURSIVE date_series AS (
    SELECT '2024-01-01'::date AS date
    UNION ALL
    SELECT date + 1 FROM date_series WHERE date < '2024-12-31'
)
SELECT date FROM date_series;
```

## 📦 Array Operations

PostgreSQL has powerful array support.

### Array Functions

```sql
-- Create array
SELECT ARRAY[1, 2, 3, 4, 5] AS numbers;

-- Array length
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3], 1);

-- Array elements
SELECT ARRAY[1, 2, 3][1] AS first_element;
SELECT ARRAY[1, 2, 3][2:3] AS slice;

-- Array concatenation
SELECT ARRAY[1, 2] || ARRAY[3, 4] AS concatenated;

-- Array contains
SELECT * FROM users 
WHERE 'developer' = ANY(tags);

-- Array overlap
SELECT * FROM users 
WHERE tags && ARRAY['developer', 'designer'];

-- Array contains
SELECT * FROM products 
WHERE ARRAY['electronics', 'laptop'] <@ categories;

-- Unnest array
SELECT 
    id,
    name,
    UNNEST(tags) AS tag
FROM users;
```

### Array Aggregation

```sql
-- Aggregate to array
SELECT 
    department_id,
    ARRAY_AGG(first_name ORDER BY salary DESC) AS employees
FROM employees
GROUP BY department_id;

-- Array aggregate with DISTINCT
SELECT 
    department_id,
    ARRAY_AGG(DISTINCT manager_id) AS managers
FROM employees
GROUP BY department_id;

-- String to array
SELECT STRING_TO_ARRAY('apple,banana,cherry', ',') AS fruits;

-- Array to string
SELECT ARRAY_TO_STRING(ARRAY['apple', 'banana', 'cherry'], ', ') AS fruits;
```

## 📄 JSON Operations

PostgreSQL has excellent JSON support with JSONB for efficient storage and indexing.

### JSON Queries

```sql
-- Access JSON fields
SELECT 
    name,
    attributes->>'brand' AS brand,
    attributes->'specs'->>'ram' AS ram
FROM products;

-- JSON path queries
SELECT 
    name,
    attributes->'specs'->>'ram' AS ram
FROM products
WHERE (attributes->'specs'->>'ram')::int > 8;

-- JSON functions
SELECT 
    jsonb_pretty(attributes) AS formatted_json
FROM products
WHERE id = 1;

-- Check if key exists
SELECT * FROM products 
WHERE attributes ? 'brand';

-- Check if any key exists
SELECT * FROM products 
WHERE attributes ?| ARRAY['brand', 'model'];

-- Check if all keys exist
SELECT * FROM products 
WHERE attributes ?& ARRAY['brand', 'model'];
```

### JSON Aggregation

```sql
-- Aggregate to JSON
SELECT 
    department_id,
    jsonb_agg(
        jsonb_build_object(
            'id', id,
            'name', first_name || ' ' || last_name,
            'salary', salary
        )
    ) AS employees_json
FROM employees
GROUP BY department_id;

-- Build JSON object
SELECT 
    jsonb_build_object(
        'id', id,
        'name', first_name || ' ' || last_name,
        'email', email
    ) AS employee_json
FROM employees;
```

### JSON Updates

```sql
-- Update JSON field
UPDATE products
SET attributes = jsonb_set(
    attributes,
    '{specs,ram}',
    '"16GB"'
)
WHERE id = 1;

-- Delete JSON key
UPDATE products
SET attributes = attributes - 'old_field'
WHERE id = 1;

-- Merge JSON objects
UPDATE products
SET attributes = attributes || '{"new_field": "value"}'::jsonb
WHERE id = 1;
```

## 🔍 Full-Text Search

PostgreSQL provides powerful full-text search capabilities.

### Basic Full-Text Search

```sql
-- Create GIN index for full-text search
CREATE INDEX idx_products_description_gin 
ON products USING GIN(to_tsvector('english', description));

-- Simple search
SELECT * FROM products
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'laptop');

-- Multiple words
SELECT * FROM products
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'laptop & fast');

-- Search with ranking
SELECT 
    name,
    description,
    ts_rank(to_tsvector('english', description), to_tsquery('english', 'laptop')) AS rank
FROM products
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'laptop')
ORDER BY rank DESC;
```

### Advanced Full-Text Search

```sql
-- Phrase search
SELECT * FROM products
WHERE to_tsvector('english', description) @@ phraseto_tsquery('english', 'fast laptop');

-- Search with highlighting
SELECT 
    name,
    ts_headline('english', description, to_tsquery('english', 'laptop'))
FROM products
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'laptop');

-- Multiple columns search
SELECT * FROM products
WHERE to_tsvector('english', name || ' ' || description) 
      @@ to_tsquery('english', 'laptop');
```

## 🔗 Lateral Joins

LATERAL joins allow subqueries in the FROM clause to reference columns from previous tables.

```sql
-- Lateral join example
SELECT 
    d.department_name,
    e.first_name,
    e.salary
FROM departments d
CROSS JOIN LATERAL (
    SELECT first_name, salary
    FROM employees
    WHERE department_id = d.id
    ORDER BY salary DESC
    LIMIT 3
) e;

-- Lateral join with function
SELECT 
    d.department_name,
    recent_employee.first_name,
    recent_employee.hire_date
FROM departments d
CROSS JOIN LATERAL (
    SELECT first_name, hire_date
    FROM employees
    WHERE department_id = d.id
    ORDER BY hire_date DESC
    LIMIT 1
) recent_employee;
```

## 📊 Advanced Aggregations

### FILTER Clause

```sql
-- Conditional aggregation
SELECT 
    department_id,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE salary > 70000) AS high_salary_count,
    AVG(salary) FILTER (WHERE salary > 70000) AS high_salary_avg
FROM employees
GROUP BY department_id;
```

### GROUPING SETS

```sql
-- Multiple grouping levels
SELECT 
    department_id,
    manager_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY GROUPING SETS (
    (department_id, manager_id),
    (department_id),
    ()
);
```

### CUBE and ROLLUP

```sql
-- CUBE: All combinations
SELECT 
    department_id,
    manager_id,
    COUNT(*) AS emp_count
FROM employees
GROUP BY CUBE(department_id, manager_id);

-- ROLLUP: Hierarchical grouping
SELECT 
    department_id,
    manager_id,
    COUNT(*) AS emp_count
FROM employees
GROUP BY ROLLUP(department_id, manager_id);
```

## 🎯 Best Practices

1. **Use window functions** instead of self-joins when possible
2. **Index JSONB columns** with GIN indexes for performance
3. **Use recursive CTEs** for hierarchical data
4. **Leverage array functions** for efficient data manipulation
5. **Use FILTER clause** for conditional aggregations
6. **Optimize full-text search** with proper indexes
7. **Use EXPLAIN ANALYZE** to understand query performance
8. **Consider materialized views** for complex queries

---

**Next**: Learn about [Performance Tuning](./PERFORMANCE-TUNING.md)

