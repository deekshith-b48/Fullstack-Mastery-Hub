# Elasticsearch Performance Tuning

## 📚 Overview

Performance tuning in Elasticsearch involves optimizing queries, indexes, configuration, and cluster settings.

## ⚙️ Configuration Tuning

### JVM Settings

```bash
# jvm.options
-Xms2g
-Xmx2g
```

### Cluster Settings

```bash
# Number of shards
# Recommended: 1 shard per 10-50GB data

# Refresh interval
PUT /employees/_settings
{
  "index": {
    "refresh_interval": "30s"
  }
}
```

## 🔍 Query Optimization

### Use Filters

```json
{
  "query": {
    "bool": {
      "filter": [
        { "term": { "department": "IT" } }
      ]
    }
  }
}
```

### Limit Fields

```json
{
  "_source": ["first_name", "last_name", "email"],
  "query": { "match_all": {} }
}
```

### Pagination

```json
{
  "from": 0,
  "size": 10,
  "query": { "match_all": {} }
}
```

## 📊 Index Optimization

### Refresh Settings

```bash
# Increase refresh interval for bulk indexing
PUT /employees/_settings
{
  "index": {
    "refresh_interval": "60s"
  }
}
```

### Force Merge

```bash
# Merge segments
POST /employees/_forcemerge?max_num_segments=1
```

## 🎯 Best Practices

1. **Optimize refresh interval** based on use case
2. **Use filters** instead of queries when possible
3. **Limit returned fields**
4. **Monitor query performance**
5. **Tune JVM settings**
6. **Optimize shard count**

---

**Next**: Learn about [Cluster Management](./CLUSTER-MANAGEMENT.md)

