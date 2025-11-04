# Database Normalization Fundamentals

## 📚 Overview

Database normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. This guide covers normalization forms and best practices.

## 🎯 What is Normalization?

Normalization is a systematic approach to decompose tables to eliminate data redundancy and dependency issues. It helps maintain data integrity and reduces storage space.

### Goals of Normalization

- **Eliminate Redundancy**: Remove duplicate data
- **Ensure Data Integrity**: Maintain consistency
- **Reduce Storage**: Optimize database size
- **Simplify Maintenance**: Easier updates and modifications

## 📊 Normal Forms

### First Normal Form (1NF)

**Rules:**
1. Each column must contain atomic values
2. Each row must be unique
3. No duplicate columns

**Example:**

```sql
-- ❌ Before 1NF (Non-atomic values)
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    products VARCHAR(255)  -- "Product1, Product2, Product3"
);

-- ✅ After 1NF (Atomic values)
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE order_items (
    order_id INT,
    product_name VARCHAR(100),
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
```

### Second Normal Form (2NF)

**Rules:**
1. Must be in 1NF
2. All non-key attributes must be fully functionally dependent on the primary key

**Example:**

```sql
-- ❌ Before 2NF (Partial dependency)
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    product_name VARCHAR(100),  -- Depends only on product_id
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id)
);

-- ✅ After 2NF (Full dependency)
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

### Third Normal Form (3NF)

**Rules:**
1. Must be in 2NF
2. No transitive dependencies (non-key attributes shouldn't depend on other non-key attributes)

**Example:**

```sql
-- ❌ Before 3NF (Transitive dependency)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    department_name VARCHAR(100),  -- Depends on department_id
    department_location VARCHAR(100)  -- Depends on department_id
);

-- ✅ After 3NF (No transitive dependencies)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);
```

### Boyce-Codd Normal Form (BCNF)

**Rules:**
1. Must be in 3NF
2. For every functional dependency X → Y, X must be a super key

## 🎯 Best Practices

1. **Normalize to 3NF** for most applications
2. **Consider denormalization** for performance
3. **Balance** between normalization and performance
4. **Document** normalization decisions
5. **Review** regularly for optimization

---

**Next**: Learn about [Denormalization Strategies](./DENORMALIZATION-STRATEGIES.md)

