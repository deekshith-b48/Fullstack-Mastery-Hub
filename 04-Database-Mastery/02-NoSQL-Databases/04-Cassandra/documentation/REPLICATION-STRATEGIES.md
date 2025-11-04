# Cassandra Replication Strategies

## 📚 Overview

Cassandra replication ensures data availability and durability across multiple nodes and datacenters.

## 🔄 SimpleStrategy

### Configuration

```sql
-- SimpleStrategy (single datacenter)
CREATE KEYSPACE myapp
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};
```

### Use Cases

- Development and testing
- Single datacenter deployments
- Simple setups

## 🌐 NetworkTopologyStrategy

### Configuration

```sql
-- NetworkTopologyStrategy (multiple datacenters)
CREATE KEYSPACE myapp
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy',
  'datacenter1': 3,
  'datacenter2': 2,
  'datacenter3': 1
};
```

### Use Cases

- Production environments
- Multiple datacenters
- Geographic distribution

## 📊 Consistency Levels

### Read Consistency

- **ONE**: Read from one replica
- **QUORUM**: Read from majority of replicas
- **ALL**: Read from all replicas

### Write Consistency

- **ONE**: Write to one replica
- **QUORUM**: Write to majority of replicas
- **ALL**: Write to all replicas

### Usage

```sql
-- Set consistency level
CONSISTENCY QUORUM;

-- Query with consistency
SELECT * FROM employees WHERE department = 'IT';
```

## 🎯 Best Practices

1. **Use NetworkTopologyStrategy** in production
2. **Set replication factor** appropriately
3. **Choose consistency level** based on needs
4. **Balance consistency and availability**
5. **Monitor replication lag**

---

**Next**: Learn about [Security](./SECURITY-CASSANDRA.md)

