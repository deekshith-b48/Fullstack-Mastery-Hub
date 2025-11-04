# Database Scalability Fundamentals

## 📚 Overview

Scalability is the ability of a database to handle increased load. This guide covers vertical and horizontal scaling strategies.

## ⬆️ Vertical Scaling (Scale Up)

### Characteristics

- **Add resources** to single server
- **CPU, RAM, Storage** upgrades
- **Simpler** implementation
- **Limited** by hardware

### Use Cases

- Small to medium applications
- When single server is sufficient
- Cost-effective for moderate growth

## ➡️ Horizontal Scaling (Scale Out)

### Characteristics

- **Add more servers**
- **Distribute load** across servers
- **Unlimited** scalability potential
- **More complex** architecture

### Strategies

#### Sharding

```sql
-- Partition data across multiple databases
-- Shard by user_id
database_shard_1: users 1-1000000
database_shard_2: users 1000001-2000000
database_shard_3: users 2000001-3000000
```

#### Read Replicas

```sql
-- Primary database for writes
-- Replicas for reads
PRIMARY → REPLICA 1 → REPLICA 2 → REPLICA 3
```

#### Partitioning

```sql
-- Partition tables by range
CREATE TABLE orders (
    id INT,
    order_date DATE,
    ...
) PARTITION BY RANGE (order_date);

-- Partitions
orders_2024_q1
orders_2024_q2
orders_2024_q3
orders_2024_q4
```

## 🎯 Best Practices

1. **Plan for growth** early
2. **Monitor performance** metrics
3. **Choose appropriate** scaling strategy
4. **Balance** cost and performance
5. **Test scaling** strategies

---

**Next**: Learn about [Sharding Strategies](./SHARDING-STRATEGIES.md)

