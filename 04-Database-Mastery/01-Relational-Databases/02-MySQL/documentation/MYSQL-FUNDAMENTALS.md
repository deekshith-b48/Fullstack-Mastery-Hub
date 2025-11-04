# MySQL Fundamentals

## 📚 Overview

MySQL is one of the world's most popular open-source relational database management systems. It's known for its reliability, performance, and ease of use. This guide covers MySQL fundamentals, installation, configuration, and basic operations.

## 🎯 What is MySQL?

MySQL is a relational database management system (RDBMS) that uses SQL (Structured Query Language) for database operations. It's widely used in web applications and is the database component of the popular LAMP (Linux, Apache, MySQL, PHP) stack.

### Key Features

- **ACID Compliance**: Ensures data integrity
- **High Performance**: Optimized for speed
- **Scalability**: Handles large datasets
- **Replication**: Built-in replication support
- **Multiple Storage Engines**: InnoDB, MyISAM, Memory, etc.
- **Full-Text Search**: Built-in full-text indexing
- **JSON Support**: Native JSON data type
- **Security**: Comprehensive security features

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install MySQL server
sudo apt install mysql-server

# Start MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure installation
sudo mysql_secure_installation
```

### macOS

```bash
# Using Homebrew
brew install mysql

# Start service
brew services start mysql
```

### Windows

Download MySQL Installer from: https://dev.mysql.com/downloads/installer/

## 🔧 Initial Setup

### Access MySQL

```bash
# Access as root
sudo mysql -u root -p

# Or
mysql -u root -p
```

### Create Database and User

```sql
-- Create database
CREATE DATABASE myapp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON myapp.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;

-- Use database
USE myapp;
```

## 📊 Data Types

### Numeric Types

```sql
-- Integer types
TINYINT       -- 1 byte, -128 to 127 (signed) or 0 to 255 (unsigned)
SMALLINT      -- 2 bytes, -32,768 to 32,767
MEDIUMINT     -- 3 bytes, -8,388,608 to 8,388,607
INT           -- 4 bytes, -2,147,483,648 to 2,147,483,647
BIGINT        -- 8 bytes, large range integers

-- Auto-increment
INT AUTO_INCREMENT PRIMARY KEY

-- Decimal types
DECIMAL(10, 2)  -- Exact numeric, 10 digits total, 2 decimal places
NUMERIC(10, 2)   -- Same as DECIMAL
FLOAT            -- Single-precision floating-point
DOUBLE           -- Double-precision floating-point

-- Example
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    price DECIMAL(10, 2),
    quantity INT UNSIGNED
);
```

### Character Types

```sql
-- Character types
CHAR(n)       -- Fixed-length, 0-255 characters
VARCHAR(n)    -- Variable-length, 0-65,535 characters
TEXT          -- Variable-length, up to 65,535 characters
TINYTEXT      -- Up to 255 characters
MEDIUMTEXT    -- Up to 16,777,215 characters
LONGTEXT      -- Up to 4,294,967,295 characters

-- Example
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
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
DATETIME      -- Date and time
TIMESTAMP     -- Date and time with timezone
YEAR          -- Year value (1901-2155)

-- Example
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    start_time DATETIME,
    end_time DATETIME
);

-- Insert with current timestamp
INSERT INTO events (event_name, start_time)
VALUES ('Meeting', NOW());
```

### Boolean Type

```sql
-- BOOLEAN is alias for TINYINT(1)
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_name VARCHAR(100),
    completed BOOLEAN DEFAULT FALSE
);

-- Usage
INSERT INTO tasks (task_name, completed)
VALUES ('Learn MySQL', TRUE);
```

### JSON Type

```sql
-- JSON data type (MySQL 5.7+)
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    attributes JSON
);

-- Insert JSON data
INSERT INTO products (name, attributes)
VALUES ('Laptop', '{"brand": "Dell", "ram": "16GB", "storage": "512GB"}');

-- Query JSON
SELECT name, JSON_EXTRACT(attributes, '$.brand') AS brand
FROM products
WHERE JSON_EXTRACT(attributes, '$.ram') = '16GB';

-- Or using -> operator
SELECT name, attributes->>'$.brand' AS brand
FROM products
WHERE attributes->>'$.ram' = '16GB';
```

## 🏗️ Basic Operations

### Creating Tables

```sql
-- Create table with constraints
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    department_id INT,
    hire_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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

-- Insert with ON DUPLICATE KEY UPDATE
INSERT INTO employees (email, first_name, last_name)
VALUES ('john.doe@example.com', 'John', 'Doe')
ON DUPLICATE KEY UPDATE 
    first_name = VALUES(first_name),
    last_name = VALUES(last_name);

-- Insert with IGNORE (skip duplicates)
INSERT IGNORE INTO employees (email, first_name, last_name)
VALUES ('john.doe@example.com', 'John', 'Doe');
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

-- Update with LIMIT
UPDATE employees
SET salary = 85000
WHERE department_id = 5
LIMIT 10;
```

### Deleting Data

```sql
-- Delete specific row
DELETE FROM employees WHERE id = 1;

-- Delete with conditions
DELETE FROM employees WHERE salary < 50000;

-- Delete with LIMIT
DELETE FROM employees WHERE department_id = 5 LIMIT 10;

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
SELECT * FROM employees WHERE salary <> 75000;

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

-- REGEXP operator
SELECT * FROM employees 
WHERE email REGEXP '^[a-z]+@example\\.com$';
```

### Aggregation Functions

```sql
-- Count
SELECT COUNT(*) FROM employees;
SELECT COUNT(DISTINCT department_id) FROM employees;

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

-- Cross Join
SELECT * FROM employees CROSS JOIN departments;

-- Self Join
SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

## 🔐 Security Basics

### User Management

```sql
-- Create user
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';

-- Create user with specific host
CREATE USER 'app_user'@'%' IDENTIFIED BY 'secure_password';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON myapp.* TO 'app_user'@'localhost';

-- Revoke privileges
REVOKE DELETE ON myapp.* FROM 'app_user'@'localhost';

-- Show grants
SHOW GRANTS FOR 'app_user'@'localhost';

-- Drop user
DROP USER 'app_user'@'localhost';
```

## 📝 Best Practices

1. **Always use parameterized queries** to prevent SQL injection
2. **Use transactions** for multiple related operations
3. **Create indexes** on frequently queried columns
4. **Use appropriate data types** for each column
5. **Normalize your database** design
6. **Regular backups** are essential
7. **Monitor performance** using performance schema
8. **Use connection pooling** for applications
9. **Choose appropriate storage engine** (InnoDB for most cases)
10. **Use utf8mb4** character set for full Unicode support

---

**Next**: Learn about [MySQL Optimization](./MYSQL-OPTIMIZATION.md)

