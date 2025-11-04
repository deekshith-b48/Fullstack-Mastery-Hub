# SQL Server Fundamentals

## 📚 Overview

Microsoft SQL Server is a relational database management system developed by Microsoft. It's widely used in enterprise environments for its robust features, security, and integration with Microsoft technologies.

## 🎯 What is SQL Server?

SQL Server is a comprehensive database platform that provides enterprise-level data management, business intelligence, and analytics capabilities. It supports both on-premises and cloud deployments.

### Key Features

- **ACID Compliance**: Full transaction support
- **High Availability**: Always On, clustering, mirroring
- **Security**: Row-level security, encryption, auditing
- **Business Intelligence**: SSIS, SSAS, SSRS
- **JSON Support**: Native JSON data type
- **In-Memory OLTP**: High-performance in-memory tables
- **Columnstore Indexes**: Optimized for analytics

## 🚀 Installation

### Windows Installation

1. Download SQL Server from Microsoft
2. Run installation wizard
3. Choose installation type (Developer, Express, Standard, Enterprise)
4. Configure instance settings
5. Set authentication mode (Windows or Mixed)

### SQL Server Configuration Manager

```bash
# Access SQL Server services
# Start/Stop SQL Server services
# Configure network protocols
# Manage SQL Server instances
```

## 🔧 Initial Setup

### Create Database

```sql
-- Create database
CREATE DATABASE myapp;

-- Create database with options
CREATE DATABASE myapp
ON PRIMARY (
    NAME = 'myapp_data',
    FILENAME = 'C:\Data\myapp_data.mdf',
    SIZE = 100MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = 'myapp_log',
    FILENAME = 'C:\Data\myapp_log.ldf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
);

-- Use database
USE myapp;
```

### Create User and Grant Permissions

```sql
-- Create login
CREATE LOGIN app_user WITH PASSWORD = 'secure_password';

-- Create user in database
USE myapp;
CREATE USER app_user FOR LOGIN app_user;

-- Grant permissions
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO app_user;

-- Grant database role
ALTER ROLE db_datareader ADD MEMBER app_user;
ALTER ROLE db_datawriter ADD MEMBER app_user;
```

## 📊 Data Types

### Numeric Types

```sql
-- Integer types
TINYINT       -- 0 to 255
SMALLINT      -- -32,768 to 32,767
INT           -- -2,147,483,648 to 2,147,483,647
BIGINT        -- Large range integers

-- Decimal types
DECIMAL(10, 2)  -- Exact numeric
NUMERIC(10, 2)   -- Same as DECIMAL
FLOAT           -- Floating-point
REAL            -- Single-precision floating-point
MONEY           -- Currency data
SMALLMONEY      -- Small currency data

-- Example
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    price DECIMAL(10, 2),
    quantity INT
);
```

### Character Types

```sql
-- Character types
CHAR(n)       -- Fixed-length
VARCHAR(n)    -- Variable-length
TEXT          -- Large text (deprecated, use VARCHAR(MAX))
NVARCHAR(n)   -- Unicode variable-length
NCHAR(n)      -- Unicode fixed-length
NTEXT         -- Unicode large text (deprecated)

-- Example
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    bio VARCHAR(MAX)
);
```

### Date and Time Types

```sql
-- Date/time types
DATE          -- Date only
TIME          -- Time only
DATETIME      -- Date and time
DATETIME2     -- Extended date/time
SMALLDATETIME -- Small date/time
DATETIMEOFFSET -- Date/time with timezone
TIMESTAMP     -- Row version (not for dates)

-- Example
CREATE TABLE events (
    id INT IDENTITY(1,1) PRIMARY KEY,
    event_name VARCHAR(100),
    start_time DATETIME2,
    end_time DATETIME2
);
```

## 🏗️ Basic Operations

### Creating Tables

```sql
-- Create table
CREATE TABLE employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    department_id INT,
    hire_date DATE DEFAULT GETDATE(),
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
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

-- Insert with OUTPUT
INSERT INTO employees (first_name, last_name, email)
OUTPUT INSERTED.id, INSERTED.first_name
VALUES ('Alice', 'Williams', 'alice.williams@example.com');
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

-- Limiting results (SQL Server 2012+)
SELECT TOP 10 * FROM employees ORDER BY salary DESC;

-- Offset for pagination
SELECT * FROM employees 
ORDER BY id 
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;
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

-- Update with OUTPUT
UPDATE employees
SET salary = 85000
OUTPUT INSERTED.id, INSERTED.first_name, INSERTED.salary
WHERE id = 1;
```

### Deleting Data

```sql
-- Delete specific row
DELETE FROM employees WHERE id = 1;

-- Delete with OUTPUT
DELETE FROM employees
OUTPUT DELETED.id, DELETED.first_name
WHERE id = 1;

-- Truncate (faster, cannot rollback)
TRUNCATE TABLE employees;
```

## 🔍 T-SQL Features

### Variables

```sql
-- Declare variables
DECLARE @name VARCHAR(50) = 'John';
DECLARE @salary DECIMAL(10, 2) = 75000;

-- Use variables
SELECT * FROM employees 
WHERE first_name = @name AND salary = @salary;
```

### Control Flow

```sql
-- IF statement
IF @salary > 100000
    SELECT 'High salary'
ELSE
    SELECT 'Normal salary'

-- WHILE loop
DECLARE @counter INT = 1;
WHILE @counter <= 10
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END
```

## 🎯 Best Practices

1. **Use appropriate data types** for each column
2. **Create indexes** on frequently queried columns
3. **Use transactions** for multiple related operations
4. **Regular backups** are essential
5. **Monitor performance** using SQL Server tools
6. **Use parameterized queries** to prevent SQL injection
7. **Normalize database** design
8. **Use connection pooling** for applications

---

**Next**: Learn about [T-SQL Mastery](./T-SQL-MASTERY.md)

