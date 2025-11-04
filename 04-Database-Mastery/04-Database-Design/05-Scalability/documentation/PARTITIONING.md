# Database Partitioning

## 📚 Overview

Partitioning divides large tables into smaller, manageable pieces. This guide covers partitioning strategies and implementation.

## 🔀 Partitioning Types

### Range Partitioning

```sql
-- PostgreSQL: Range partitioning
CREATE TABLE orders (
    id INT,
    order_date DATE,
    total DECIMAL(10, 2)
) PARTITION BY RANGE (order_date);

-- Create partitions
CREATE TABLE orders_2024_q1 PARTITION OF orders
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE orders_2024_q2 PARTITION OF orders
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE orders_2024_q3 PARTITION OF orders
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE orders_2024_q4 PARTITION OF orders
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');
```

### Hash Partitioning

```sql
-- PostgreSQL: Hash partitioning
CREATE TABLE users (
    id INT,
    email VARCHAR(255),
    name VARCHAR(100)
) PARTITION BY HASH (id);

-- Create partitions
CREATE TABLE users_0 PARTITION OF users
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE users_1 PARTITION OF users
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE users_2 PARTITION OF users
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE users_3 PARTITION OF users
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);
```

### List Partitioning

```sql
-- PostgreSQL: List partitioning
CREATE TABLE sales (
    id INT,
    region VARCHAR(50),
    amount DECIMAL(10, 2)
) PARTITION BY LIST (region);

-- Create partitions
CREATE TABLE sales_north PARTITION OF sales
    FOR VALUES IN ('north', 'northeast');

CREATE TABLE sales_south PARTITION OF sales
    FOR VALUES IN ('south', 'southeast');

CREATE TABLE sales_west PARTITION OF sales
    FOR VALUES IN ('west', 'northwest');
```

## 📊 Partition Management

### Adding Partitions

```sql
-- Add new partition
CREATE TABLE orders_2025_q1 PARTITION OF orders
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');
```

### Dropping Partitions

```sql
-- Drop old partition
DROP TABLE orders_2023_q1;
```

### Partition Pruning

```sql
-- Query automatically uses only relevant partitions
SELECT * FROM orders 
WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31';
-- Only scans orders_2024_q1 partition
```

## 🎯 Best Practices

1. **Choose appropriate** partitioning key
2. **Plan partition sizes**
3. **Automate partition** creation
4. **Monitor partition** performance
5. **Test queries** on partitioned tables

---

**Next**: Continue learning about scalability.

