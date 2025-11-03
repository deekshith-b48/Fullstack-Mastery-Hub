# PostgreSQL Advanced Features

## 📚 Overview

PostgreSQL is a powerful, open-source relational database with advanced features.

## 🚀 Installation

```bash
# macOS
brew install postgresql@15
brew services start postgresql@15

# Ubuntu
sudo apt-get install postgresql postgresql-contrib

# Connect
psql -U postgres
```

## 🎯 Key Features

### JSON Support

```sql
-- JSON column
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  details JSONB
);

-- Insert JSON
INSERT INTO products (name, details)
VALUES (
  'Product 1',
  '{"color": "red", "size": "large", "price": 29.99}'::JSONB
);

-- Query JSON
SELECT * FROM products WHERE details->>'color' = 'red';
SELECT * FROM products WHERE details @> '{"size": "large"}'::JSONB;

-- JSON functions
SELECT 
  name,
  details->>'color' AS color,
  (details->>'price')::numeric AS price
FROM products;
```

### Arrays

```sql
-- Array column
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  tags TEXT[]
);

-- Insert arrays
INSERT INTO tags (name, tags)
VALUES ('Article 1', ARRAY['javascript', 'nodejs', 'backend']);

-- Query arrays
SELECT * FROM tags WHERE 'javascript' = ANY(tags);
SELECT * FROM tags WHERE tags @> ARRAY['javascript'];
```

### Full-Text Search

```sql
-- Create full-text search column
ALTER TABLE articles ADD COLUMN search_vector tsvector;
CREATE INDEX idx_search ON articles USING GIN(search_vector);

-- Update search vector
UPDATE articles 
SET search_vector = 
  setweight(to_tsvector('english', title), 'A') ||
  setweight(to_tsvector('english', content), 'B');

-- Search
SELECT * FROM articles 
WHERE search_vector @@ to_tsquery('english', 'javascript & nodejs');
```

### Window Functions

```sql
-- Advanced window functions
SELECT 
  name,
  department,
  salary,
  SUM(salary) OVER (
    PARTITION BY department 
    ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
FROM employees;
```

### Common Table Expressions

```sql
-- WITH clause
WITH sales_by_month AS (
  SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total) AS monthly_total
  FROM orders
  GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
  month,
  monthly_total,
  LAG(monthly_total) OVER (ORDER BY month) AS prev_month
FROM sales_by_month;
```

## 🔧 Advanced Types

### Enums

```sql
CREATE TYPE status_type AS ENUM ('active', 'inactive', 'pending');

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  status status_type DEFAULT 'pending'
);
```

### Custom Types

```sql
CREATE TYPE address AS (
  street VARCHAR(255),
  city VARCHAR(255),
  zip_code VARCHAR(10)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  address address
);

-- Query
SELECT name, (address).city FROM customers;
```

## 📊 Performance

### Indexes

```sql
-- B-tree index (default)
CREATE INDEX idx_users_email ON users(email);

-- GIN index (arrays, JSONB, full-text)
CREATE INDEX idx_products_details ON products USING GIN(details);

-- GiST index (geometric data)
CREATE INDEX idx_locations_coords ON locations USING GIST(coordinates);

-- Partial index
CREATE INDEX idx_active_users_email ON users(email) WHERE status = 'active';
```

### Partitioning

```sql
-- Range partitioning
CREATE TABLE orders_2024 PARTITION OF orders
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- List partitioning
CREATE TABLE orders_us PARTITION OF orders
FOR VALUES IN ('US');
```

## 🔐 Security

### Row-Level Security

```sql
-- Enable RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY user_orders ON orders
FOR ALL
USING (user_id = current_user_id());

-- Users can only see their own orders
```

---

**Next**: Learn about [MySQL](./MYSQL-FUNDAMENTALS.md)

