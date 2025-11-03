# MySQL Fundamentals

## 📚 Overview

MySQL is a popular open-source relational database management system.

## 🚀 Installation

```bash
# macOS
brew install mysql
brew services start mysql

# Ubuntu
sudo apt-get install mysql-server

# Connect
mysql -u root -p
```

## 🎯 Basic Operations

### Database Management

```sql
-- Create database
CREATE DATABASE myapp;
USE myapp;

-- Show databases
SHOW DATABASES;

-- Drop database
DROP DATABASE IF EXISTS myapp;
```

### Table Creation

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  age INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Data Types

```sql
-- Numeric
INT, BIGINT, SMALLINT, TINYINT
DECIMAL(10, 2), FLOAT, DOUBLE

-- String
VARCHAR(255), CHAR(10), TEXT, LONGTEXT
BINARY, VARBINARY, BLOB

-- Date/Time
DATE, TIME, DATETIME, TIMESTAMP, YEAR

-- JSON (MySQL 5.7+)
JSON
```

### Indexes

```sql
-- Create index
CREATE INDEX idx_users_email ON users(email);

-- Unique index
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);

-- Composite index
CREATE INDEX idx_users_name_email ON users(name, email);

-- Full-text index
CREATE FULLTEXT INDEX idx_articles_content ON articles(content);
```

## 🔍 Advanced Queries

### JSON Operations (MySQL 5.7+)

```sql
-- JSON column
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  details JSON
);

-- Insert JSON
INSERT INTO products (name, details)
VALUES (
  'Product 1',
  '{"color": "red", "price": 29.99}'
);

-- Query JSON
SELECT * FROM products 
WHERE JSON_EXTRACT(details, '$.color') = 'red';

-- JSON functions
SELECT 
  name,
  details->>'$.color' AS color,
  JSON_UNQUOTE(details->>'$.price') AS price
FROM products;
```

### Window Functions (MySQL 8.0+)

```sql
SELECT 
  name,
  salary,
  ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank,
  LAG(salary, 1) OVER (ORDER BY salary DESC) AS prev_salary
FROM employees;
```

### Common Table Expressions (MySQL 8.0+)

```sql
WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT * FROM numbers;
```

## 🔧 Storage Engines

```sql
-- InnoDB (default, ACID compliant)
CREATE TABLE table1 (
  id INT PRIMARY KEY
) ENGINE=InnoDB;

-- MyISAM (faster reads, no transactions)
CREATE TABLE table2 (
  id INT PRIMARY KEY
) ENGINE=MyISAM;
```

## 📊 Performance Optimization

### Explain Query

```sql
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Extended explain
EXPLAIN EXTENDED SELECT * FROM users WHERE email = 'test@example.com';
SHOW WARNINGS;
```

### Query Cache (MySQL 5.7 and earlier)

```sql
-- Check cache status
SHOW VARIABLES LIKE 'query_cache%';

-- Enable query cache
SET GLOBAL query_cache_type = ON;
SET GLOBAL query_cache_size = 67108864; -- 64MB
```

---

**Next**: Learn about [Database Design](./../Database-Design/documentation/NORMALIZATION.md)

