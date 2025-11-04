# Elasticsearch Fundamentals

## 📚 Overview

Elasticsearch is a distributed, RESTful search and analytics engine built on Apache Lucene. It's designed for horizontal scalability and real-time search capabilities.

## 🎯 What is Elasticsearch?

Elasticsearch is a search engine that stores, searches, and analyzes data in near real-time. It's commonly used for log analytics, full-text search, and business intelligence.

### Key Features

- **Distributed**: Automatically distributes data across nodes
- **RESTful API**: Simple HTTP API for operations
- **Real-time**: Near real-time search and indexing
- **Full-Text Search**: Advanced search capabilities
- **Scalable**: Horizontal scaling
- **Analytics**: Aggregation framework

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Import Elasticsearch GPG key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add repository
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Install Elasticsearch
sudo apt update
sudo apt install elasticsearch

# Start Elasticsearch
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
```

### macOS

```bash
# Using Homebrew
brew install elasticsearch

# Start Elasticsearch
brew services start elasticsearch
```

### Docker

```bash
# Run Elasticsearch in Docker
docker run -d \
  --name elasticsearch \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  elasticsearch:8.0.0
```

## 🔧 Basic Operations

### Check Cluster Health

```bash
# Health check
curl -X GET "localhost:9200/_cat/health?v"

# Cluster info
curl -X GET "localhost:9200/_cluster/health?pretty"
```

### Create Index

```bash
# Create index
curl -X PUT "localhost:9200/employees?pretty"

# Create index with settings
curl -X PUT "localhost:9200/employees?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 1
  }
}
'
```

### Index Document

```bash
# Index document
curl -X POST "localhost:9200/employees/_doc?pretty" -H 'Content-Type: application/json' -d'
{
  "first_name": "John",
  "last_name": "Doe",
  "email": "john@example.com",
  "salary": 75000,
  "department": "IT"
}
'

# Index with specific ID
curl -X PUT "localhost:9200/employees/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "first_name": "John",
  "last_name": "Doe",
  "email": "john@example.com"
}
'
```

### Get Document

```bash
# Get document by ID
curl -X GET "localhost:9200/employees/_doc/1?pretty"

# Get all documents
curl -X GET "localhost:9200/employees/_search?pretty"
```

### Search

```bash
# Simple search
curl -X GET "localhost:9200/employees/_search?q=John&pretty"

# Search with query DSL
curl -X GET "localhost:9200/employees/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "first_name": "John"
    }
  }
}
'
```

### Update Document

```bash
# Update document
curl -X POST "localhost:9200/employees/_update/1?pretty" -H 'Content-Type: application/json' -d'
{
  "doc": {
    "salary": 80000
  }
}
'
```

### Delete Document

```bash
# Delete document
curl -X DELETE "localhost:9200/employees/_doc/1?pretty"

# Delete index
curl -X DELETE "localhost:9200/employees?pretty"
```

## 📊 Index Structure

### Mapping

```bash
# Create mapping
curl -X PUT "localhost:9200/employees?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "first_name": { "type": "text" },
      "last_name": { "type": "text" },
      "email": { "type": "keyword" },
      "salary": { "type": "integer" },
      "department": { "type": "keyword" },
      "hire_date": { "type": "date" }
    }
  }
}
'
```

### Field Types

- **text**: Full-text search
- **keyword**: Exact match
- **long, integer, short, byte**: Numeric types
- **double, float**: Floating-point
- **date**: Date/time
- **boolean**: Boolean
- **object**: Nested object
- **nested**: Array of objects

## 🔍 Query DSL

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
        { "match": { "salary": { "gt": 80000 } } }
      ]
    }
  }
}
```

## 🎯 Best Practices

1. **Design mappings** before indexing
2. **Use appropriate field types**
3. **Create indexes** for frequently queried fields
4. **Monitor cluster health**
5. **Use aliases** for index management
6. **Regular backups** are essential
7. **Optimize queries** for performance

---

**Next**: Learn about [Indexing Strategies](./INDEXING-STRATEGIES.md)

