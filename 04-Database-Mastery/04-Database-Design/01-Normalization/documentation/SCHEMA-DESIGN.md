# Database Schema Design

## 📚 Overview

Effective schema design is crucial for database performance and maintainability. This guide covers schema design principles and best practices.

## 🎯 Design Principles

### Entity Identification

```sql
-- Identify core entities
-- Users, Products, Orders, Payments

CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Relationship Design

```sql
-- One-to-Many: User to Orders
CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Many-to-Many: Products to Orders
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

## 📊 Naming Conventions

### Tables

```sql
-- Use plural nouns
CREATE TABLE users (...);
CREATE TABLE orders (...);
CREATE TABLE products (...);

-- Use descriptive names
CREATE TABLE user_profiles (...);
CREATE TABLE order_histories (...);
```

### Columns

```sql
-- Use singular nouns
CREATE TABLE users (
    id INT,
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Use consistent naming
-- ✅ Good: created_at, updated_at
-- ❌ Bad: create_date, modification_time
```

## 🔍 Data Types

### Choose Appropriate Types

```sql
-- Use smallest appropriate type
CREATE TABLE users (
    id INT PRIMARY KEY,  -- Not BIGINT if not needed
    age TINYINT,  -- Not INT for age
    email VARCHAR(255),  -- Not TEXT
    description TEXT  -- Use TEXT for large content
);

-- Use appropriate numeric types
CREATE TABLE products (
    price DECIMAL(10, 2),  -- For currency
    quantity INT,  -- For counts
    rating FLOAT  -- For averages
);
```

## 🎯 Best Practices

1. **Normalize** to 3NF
2. **Use consistent** naming
3. **Choose appropriate** data types
4. **Define relationships** clearly
5. **Document** schema decisions
6. **Plan for growth**
7. **Consider performance** implications

---

**Next**: Continue learning about schema design.

