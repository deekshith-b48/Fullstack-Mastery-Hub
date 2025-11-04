# Elasticsearch Aggregations

## 📚 Overview

Aggregations provide analytics capabilities in Elasticsearch, allowing you to group, analyze, and summarize data.

## 📊 Bucket Aggregations

### Terms Aggregation

```json
{
  "aggs": {
    "departments": {
      "terms": {
        "field": "department",
        "size": 10
      }
    }
  }
}
```

### Range Aggregation

```json
{
  "aggs": {
    "salary_ranges": {
      "range": {
        "field": "salary",
        "ranges": [
          { "to": 50000 },
          { "from": 50000, "to": 100000 },
          { "from": 100000 }
        ]
      }
    }
  }
}
```

### Date Histogram

```json
{
  "aggs": {
    "hires_over_time": {
      "date_histogram": {
        "field": "hire_date",
        "calendar_interval": "month"
      }
    }
  }
}
```

## 📈 Metric Aggregations

### Stats Aggregation

```json
{
  "aggs": {
    "salary_stats": {
      "stats": {
        "field": "salary"
      }
    }
  }
}
```

### Cardinality

```json
{
  "aggs": {
    "unique_departments": {
      "cardinality": {
        "field": "department"
      }
    }
  }
}
```

## 🔄 Nested Aggregations

```json
{
  "aggs": {
    "departments": {
      "terms": {
        "field": "department"
      },
      "aggs": {
        "avg_salary": {
          "avg": {
            "field": "salary"
          }
        }
      }
    }
  }
}
```

## 🎯 Best Practices

1. **Use appropriate aggregation types**
2. **Combine aggregations** for complex analysis
3. **Monitor performance** of aggregations
4. **Use filters** to reduce data scope

---

**Next**: Learn about [Performance Tuning](./PERFORMANCE-TUNING.md)

