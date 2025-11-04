/# PostgreSQL Fundamentals

## 📚 Overview

PostgreSQL is a powerful, open-source object-relational database system known for its reliability, feature robustness, and performance. It has been actively developed for over 30 years and has earned a strong reputation for its proven architecture and data integrity.

## 🎯 What is PostgreSQL?

PostgreSQL, often simply called "Postgres," is an advanced open-source relational database management system (RDBMS) that uses and extends the SQL language. It's ACID-compliant and supports both SQL (relational) and JSON (non-relational) querying.

### Key Features

- **ACID Compliance**: Ensures data integrity and reliability
- **Extensibility**: Supports custom functions, data types, and operators
- **Advanced Indexing**: Multiple index types including B-tree, Hash, GiST, SP-GiST, GIN, and BRIN
- **Full-Text Search**: Built-in support for text search
- **JSON Support**: Native JSON and JSONB data types
- **Concurrency Control**: Multi-version concurrency control (MVCC)
- **Replication**: Built-in streaming replication and logical replication

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Start PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Check status
sudo systemctl status postgresql
```

### macOS

```bash
# Using Homebrew
brew install postgresql@14

# Start service
brew services start postgresql@14
```

### Windows

Download and install from the official PostgreSQL website: https://www.postgresql.org/download/windows/

## 🔧 Initial Setup

### Access PostgreSQL

```bash
# Switch to postgres user
sudo -i -u postgres

# Access PostgreSQL prompt
psql

# Or directly
sudo -u postgres psql
```

### Create Database and User

```sql
-- Create a new database
CREATE DATABASE myapp;

-- Create a new user
CREATE USER myuser WITH PASSWORD 'mypassword';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE myapp TO myuser;

-- Connect to the database
\c myapp
```

## 📊 Data Types

### Numeric Types

```sql
-- Integer types
SMALLINT      -- 2 bytes, -32,768 to 32,767
INTEGER       -- 4 bytes, -2,147,483,648 to 2,147,483,647
BIGINT        -- 8 bytes, large range integers
SERIAL        -- Auto-incrementing integer (32-bit)
BIGSERIAL     -- Auto-incrementing integer (64-bit)

-- Decimal types
DECIMAL(n, d)  -- Exact numeric, n digits total, d decimal places
NUMERIC(n, d)  -- Same as DECIMAL
REAL          -- 4 bytes, floating-point
DOUBLE PRECISION -- 8 bytes, floating-point

-- Example
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    price DECIMAL(10, 2),
    quantity INTEGER
);
```

### Character Types

```sql
-- Character types
CHAR(n)       -- Fixed-length, blank-padded
VARCHAR(n)    -- Variable-length with limit
TEXT          -- Variable unlimited length

-- Example
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    bio TEXT
);
```

### Date and Time Types

```sql
-- Date/time types
DATE          -- Date only (YYYY-MM-DD)
TIME          -- Time of day (HH:MM:SS)
TIMESTAMP     -- Date and time
TIMESTAMPTZ   -- Timestamp with time zone
INTERVAL      -- Time interval

-- Example
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    start_time TIMESTAMP,
    duration INTERVAL
);

-- Insert with timezone
INSERT INTO events (event_name, start_time)
VALUES ('Meeting', '2024-01-15 14:30:00+05:30');
```

### Boolean Type

```sql
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    task_name VARCHAR(100),
    completed BOOLEAN DEFAULT FALSE
);

-- Usage
INSERT INTO tasks (task_name, completed)
VALUES ('Learn PostgreSQL', TRUE);
```

### JSON Types

```sql
-- JSON and JSONB types
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    attributes JSONB  -- JSONB is preferred for indexing
);

-- Insert JSON data
INSERT INTO products (name, attributes)
VALUES ('Laptop', '{"brand": "Dell", "ram": "16GB", "storage": "512GB"}'::jsonb);

-- Query JSON
SELECT name, attributes->>'brand' as brand
FROM products
WHERE attributes->>'ram' = '16GB';
```

### Array Types

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255),
    tags TEXT[]  -- Array of text
);

-- Insert array
INSERT INTO users (name, email, tags)
VALUES ('John', 'john@example.com', ARRAY['developer', 'postgresql']);

-- Query arrays
SELECT * FROM users WHERE 'developer' = ANY(tags);
```

## 🏗️ Basic Operations

### Creating Tables

```sql
-- Create a table with constraints
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    department_id INTEGER,
    hire_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key constraint
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(id);
```

### Inserting Data

```sql
-- Single insert
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('John', 'Doe', 'john.doe@example.com', 75000);

-- Multiple inserts
INSERT INTO employees (first_name, last_name, email, salary)
VALUES 
    ('Jane', 'Smith', 'jane.smith@example.com', 80000),
    ('Bob', 'Johnson', 'bob.johnson@example.com', 70000);

-- Insert with returning clause
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('Alice', 'Williams', 'alice.williams@example.com', 85000)
RETURNING id, first_name, email;
```

### Querying Data

```sql
-- Basic SELECT
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, email FROM employees;

-- Filtering with WHERE
SELECT * FROM employees WHERE salary > 75000;

-- Sorting with ORDER BY
SELECT * FROM employees ORDER BY salary DESC;

-- Limiting results
SELECT * FROM employees ORDER BY salary DESC LIMIT 10;

-- Offset for pagination
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 20;
```

### Updating Data

```sql
-- Update single row
UPDATE employees
SET salary = 80000
WHERE id = 1;

-- Update multiple rows
UPDATE employees
SET salary = salary * 1.1  -- 10% raise
WHERE department_id = 5;

-- Update with returning
UPDATE employees
SET salary = 85000
WHERE id = 1
RETURNING id, first_name, salary;
```

### Deleting Data

```sql
-- Delete specific row
DELETE FROM employees WHERE id = 1;

-- Delete with conditions
DELETE FROM employees WHERE salary < 50000;

-- Delete all rows (be careful!)
DELETE FROM employees;

-- Truncate (faster, cannot rollback)
TRUNCATE TABLE employees;
```

## 🔍 Basic Queries

### Filtering

```sql
-- Comparison operators
SELECT * FROM employees WHERE salary > 75000;
SELECT * FROM employees WHERE salary >= 75000;
SELECT * FROM employees WHERE salary < 75000;
SELECT * FROM employees WHERE salary <= 75000;
SELECT * FROM employees WHERE salary = 75000;
SELECT * FROM employees WHERE salary != 75000;

-- Logical operators
SELECT * FROM employees 
WHERE salary > 70000 AND department_id = 5;

SELECT * FROM employees 
WHERE salary > 80000 OR department_id = 3;

SELECT * FROM employees 
WHERE NOT (salary < 50000);

-- IN operator
SELECT * FROM employees 
WHERE department_id IN (1, 2, 3);

-- BETWEEN operator
SELECT * FROM employees 
WHERE salary BETWEEN 60000 AND 80000;

-- LIKE operator (pattern matching)
SELECT * FROM employees 
WHERE email LIKE '%@example.com';

SELECT * FROM employees 
WHERE first_name LIKE 'J%';  -- Starts with J

SELECT * FROM employees 
WHERE first_name LIKE '_o%';  -- Second character is 'o'

-- ILIKE (case-insensitive LIKE)
SELECT * FROM employees 
WHERE first_name ILIKE 'john%';
```

### Aggregation Functions

```sql
-- Count
SELECT COUNT(*) FROM employees;

-- Sum
SELECT SUM(salary) FROM employees;

-- Average
SELECT AVG(salary) FROM employees;

-- Min and Max
SELECT MIN(salary), MAX(salary) FROM employees;

-- Group By
SELECT department_id, COUNT(*), AVG(salary)
FROM employees
GROUP BY department_id;

-- Having clause
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 70000;
```

### Joins

```sql
-- Inner Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Left Join
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Right Join
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- Full Outer Join
SELECT e.first_name, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;

-- Self Join
SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

## 🔐 Security Basics

### User Management

```sql
-- Create role (user)
CREATE ROLE app_user WITH LOGIN PASSWORD 'secure_password';

-- Create role with privileges
CREATE ROLE admin_user WITH 
    LOGIN 
    PASSWORD 'admin_password'
    CREATEDB
    CREATEROLE;

-- Alter role
ALTER ROLE app_user WITH PASSWORD 'new_password';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON employees TO app_user;

-- Revoke privileges
REVOKE DELETE ON employees FROM app_user;
```

## 📝 Best Practices

1. **Always use parameterized queries** to prevent SQL injection
2. **Use transactions** for multiple related operations
3. **Create indexes** on frequently queried columns
4. **Use appropriate data types** for each column
5. **Normalize your database** design
6. **Regular backups** are essential
7. **Monitor performance** using pg_stat_statements
8. **Use connection pooling** for applications

---

**Next**: Learn about [SQL Basics Mastery](./SQL-BASICS-MASTERY.md)

