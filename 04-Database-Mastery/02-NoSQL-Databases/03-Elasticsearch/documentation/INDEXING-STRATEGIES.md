# Elasticsearch Indexing Strategies

## 📚 Overview

Effective indexing strategies are crucial for Elasticsearch performance. This guide covers index design, mapping, and optimization techniques.

## 🎯 Index Design

### Index Settings

```bash
# Create index with settings
curl -X PUT "localhost:9200/employees?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 1,
    "refresh_interval": "1s"
  }
}
'
```

### Shard Configuration

```bash
# Shard count considerations
# - More shards = better parallelism
# - Too many shards = overhead
# - Recommended: 1 shard per 10-50GB data
```

## 📊 Mapping Design

### Field Mappings

```bash
# Define field mappings
curl -X PUT "localhost:9200/employees?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "first_name": {
        "type": "text",
        "analyzer": "standard",
        "fields": {
          "keyword": {
            "type": "keyword"
          }
        }
      },
      "email": {
        "type": "keyword"
      },
      "salary": {
        "type": "integer"
      },
      "hire_date": {
        "type": "date",
        "format": "yyyy-MM-dd"
      }
    }
  }
}
'
```

### Multi-Field Mapping

```bash
# Text field with keyword sub-field
{
  "first_name": {
    "type": "text",
    "fields": {
      "raw": {
        "type": "keyword"
      }
    }
  }
}
```

## 🔍 Index Patterns

### Index Aliases

```bash
# Create alias
curl -X POST "localhost:9200/_aliases" -H 'Content-Type: application/json' -d'
{
  "actions": [
    {
      "add": {
        "index": "employees",
        "alias": "employees_current"
      }
    }
  ]
}
'

# Query through alias
curl -X GET "localhost:9200/employees_current/_search?pretty"
```

### Index Templates

```bash
# Create index template
curl -X PUT "localhost:9200/_index_template/logs_template?pretty" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["logs-*"],
  "template": {
    "settings": {
      "number_of_shards": 1
    },
    "mappings": {
      "properties": {
        "timestamp": { "type": "date" },
        "message": { "type": "text" }
      }
    }
  }
}
'
```

## 🎯 Best Practices

1. **Design mappings** before indexing
2. **Use appropriate field types**
3. **Create aliases** for index management
4. **Use templates** for consistent indices
5. **Monitor index size** and shard count
6. **Optimize refresh interval** based on needs

---

**Next**: Learn about [Search Queries](./SEARCH-QUERIES.md)

