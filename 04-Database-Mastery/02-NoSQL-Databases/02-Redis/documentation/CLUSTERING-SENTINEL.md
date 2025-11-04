# Redis Clustering & Sentinel

## 📚 Overview

Redis Sentinel provides high availability and automatic failover, while Redis Cluster enables horizontal scaling across multiple nodes.

## 🛡️ Redis Sentinel

### Setup Sentinel

```bash
# Sentinel configuration (sentinel.conf)
sentinel monitor mymaster 127.0.0.1 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 10000

# Start Sentinel
redis-sentinel sentinel.conf
```

### Sentinel Operations

```bash
# Get master info
SENTINEL masters

# Get master address
SENTINEL get-master-addr-by-name mymaster

# Check sentinel info
SENTINEL sentinels mymaster
```

## 🔄 Redis Cluster

### Setup Cluster

```bash
# Create cluster
redis-cli --cluster create \
  127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 \
  127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 \
  --cluster-replicas 1

# Connect to cluster
redis-cli -c -p 7000

# Cluster info
CLUSTER INFO

# Cluster nodes
CLUSTER NODES
```

### Cluster Operations

```bash
# Add node
CLUSTER MEET 127.0.0.1 7006

# Resharding
redis-cli --cluster reshard 127.0.0.1:7000

# Rebalance
redis-cli --cluster rebalance 127.0.0.1:7000
```

## 🎯 Best Practices

1. **Use Sentinel** for high availability
2. **Use Cluster** for horizontal scaling
3. **Monitor cluster health**
4. **Plan for node failures**
5. **Test failover scenarios**

---

**Next**: Learn about [Persistence Strategies](./PERSISTENCE-STRATEGIES.md)

