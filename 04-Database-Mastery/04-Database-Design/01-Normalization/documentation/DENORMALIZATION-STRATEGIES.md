# Denormalization Strategies

## 📚 Overview

Denormalization is the process of intentionally introducing redundancy into a database to improve read performance. This guide covers when and how to denormalize.

## 🎯 When to Denormalize

### Use Cases

- **Read-heavy applications**: Frequent reads, few writes
- **Performance critical queries**: Complex joins affecting performance
- **Reporting systems**: Analytics and data warehousing
- **Cache-like data**: Frequently accessed derived data

### Trade-offs

**Advantages:**
- Faster read queries
- Reduced join operations
- Simplified queries

**Disadvantages:**
- Increased storage space
- Data redundancy
- Update complexity
- Potential data inconsistency

## 📊 Denormalization Techniques

### Flattening Tables

```sql
-- Normalized
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

CREATE TABLE addresses (
    id INT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100),
    zip VARCHAR(10)
);

-- Denormalized (for read performance)
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(100),
    zip VARCHAR(10)
);
```

### Pre-computed Columns

```sql
-- Store calculated values
CREATE TABLE orders (
    id INT PRIMARY KEY,
    subtotal DECIMAL(10, 2),
    tax DECIMAL(10, 2),
    total DECIMAL(10, 2)  -- Pre-computed: subtotal + tax
);
```

### Duplicate Data

```sql
-- Store frequently accessed related data
CREATE TABLE posts (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    author_name VARCHAR(100),  -- Denormalized from users table
    FOREIGN KEY (author_id) REFERENCES users(id)
);
```

## 🎯 Best Practices

1. **Measure performance** before and after
2. **Document denormalization** decisions
3. **Maintain consistency** through application logic or triggers
4. **Use materialized views** when possible
5. **Monitor** for data inconsistencies

---

**Next**: Learn about [Indexing Strategies](./../02-Indexing-Strategies/documentation/INDEX-TYPES.md)

