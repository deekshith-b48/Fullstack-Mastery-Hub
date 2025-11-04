# Elasticsearch Cluster Management

## 📚 Overview

Managing an Elasticsearch cluster involves monitoring health, managing nodes, and ensuring optimal performance.

## 🔍 Cluster Health

### Health Check

```bash
# Check cluster health
curl -X GET "localhost:9200/_cluster/health?pretty"

# Health status:
# green - All primary and replica shards active
# yellow - All primary shards active, some replicas not
# red - Some primary shards not active
```

### Cluster Stats

```bash
# Cluster statistics
curl -X GET "localhost:9200/_cluster/stats?pretty"

# Node stats
curl -X GET "localhost:9200/_nodes/stats?pretty"
```

## 🖥️ Node Management

### Add Node

```bash
# Start new node with same cluster name
# elasticsearch.yml
cluster.name: my-cluster
node.name: node-3
discovery.seed_hosts: ["node-1", "node-2"]
```

### Remove Node

```bash
# Exclude node from allocation
PUT /_cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.exclude._name": "node-3"
  }
}
```

## 🔄 Shard Management

### Rebalance

```bash
# Rebalance shards
PUT /_cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "all"
  }
}
```

### Shard Allocation

```bash
# Move shard
POST /_cluster/reroute
{
  "commands": [
    {
      "move": {
        "index": "employees",
        "shard": 0,
        "from_node": "node-1",
        "to_node": "node-2"
      }
    }
  ]
}
```

## 🎯 Best Practices

1. **Monitor cluster health** regularly
2. **Balance shard distribution**
3. **Plan for node failures**
4. **Monitor disk space**
5. **Optimize node configuration**

---

**Next**: Learn about [Security](./SECURITY-ELASTICSEARCH.md)

