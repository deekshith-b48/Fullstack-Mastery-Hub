# Elasticsearch Search Queries

## 📚 Overview

Elasticsearch provides a powerful Query DSL for complex search operations. This guide covers various query types and search strategies.

## 🔍 Query Types

### Match Query

```json
{
  "query": {
    "match": {
      "first_name": "John"
    }
  }
}
```

### Match Phrase Query

```json
{
  "query": {
    "match_phrase": {
      "description": "full text search"
    }
  }
}
```

### Term Query

```json
{
  "query": {
    "term": {
      "email": "john@example.com"
    }
  }
}
```

### Terms Query

```json
{
  "query": {
    "terms": {
      "department": ["IT", "Sales", "Marketing"]
    }
  }
}
```

### Range Query

```json
{
  "query": {
    "range": {
      "salary": {
        "gte": 70000,
        "lte": 90000
      }
    }
  }
}
```

### Bool Query

```json
{
  "query": {
    "bool": {
      "must": [
        { "match": { "department": "IT" } }
      ],
      "must_not": [
        { "match": { "status": "inactive" } }
      ],
      "should": [
        { "range": { "salary": { "gt": 80000 } } }
      ],
      "filter": [
        { "term": { "active": true } }
      ]
    }
  }
}
```

### Wildcard Query

```json
{
  "query": {
    "wildcard": {
      "email": "*@example.com"
    }
  }
}
```

### Fuzzy Query

```json
{
  "query": {
    "fuzzy": {
      "first_name": {
        "value": "Jon",
        "fuzziness": "AUTO"
      }
    }
  }
}
```

## 📊 Sorting and Pagination

```json
{
  "query": { "match_all": {} },
  "sort": [
    { "salary": { "order": "desc" } },
    { "_score": { "order": "desc" } }
  ],
  "from": 0,
  "size": 10
}
```

## 🎯 Best Practices

1. **Use appropriate query types**
2. **Combine queries** with bool query
3. **Use filters** for exact matches
4. **Sort efficiently**
5. **Limit result size**

---

**Next**: Learn about [Aggregations](./AGGREGATIONS.md)

