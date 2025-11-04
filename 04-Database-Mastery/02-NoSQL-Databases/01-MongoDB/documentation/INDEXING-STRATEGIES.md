# MongoDB Indexing Strategies

## 📚 Overview

Indexes improve query performance in MongoDB by allowing efficient data retrieval. This guide covers index types, creation strategies, and optimization techniques.

## 🎯 Index Types

### Single Field Index

```javascript
// Create single field index
db.employees.createIndex({ email: 1 })

// Ascending (1) or descending (-1)
db.employees.createIndex({ salary: -1 })
```

### Compound Index

```javascript
// Create compound index
db.employees.createIndex({ department: 1, salary: -1 })

// Order matters - supports queries on:
// - department
// - department + salary
// But NOT salary alone
```

### Multikey Index

```javascript
// Index on array fields
db.employees.createIndex({ hobbies: 1 })

// Supports queries like:
db.employees.find({ hobbies: "coding" })
```

### Text Index

```javascript
// Create text index
db.products.createIndex({ description: "text" })

// Text search
db.products.find({ $text: { $search: "laptop" } })
```

### Geospatial Index

```javascript
// 2dsphere index
db.locations.createIndex({ coordinates: "2dsphere" })

// Geospatial queries
db.locations.find({
    coordinates: {
        $near: {
            $geometry: { type: "Point", coordinates: [-73.97, 40.77] },
            $maxDistance: 5000
        }
    }
})
```

### Hashed Index

```javascript
// Hashed index for sharding
db.employees.createIndex({ email: "hashed" })
```

## 📊 Index Options

### Unique Index

```javascript
// Create unique index
db.employees.createIndex({ email: 1 }, { unique: true })
```

### Partial Index

```javascript
// Index only subset of documents
db.employees.createIndex(
    { email: 1 },
    { partialFilterExpression: { salary: { $gt: 70000 } } }
)
```

### Sparse Index

```javascript
// Index only documents with field
db.employees.createIndex({ phone: 1 }, { sparse: true })
```

### TTL Index

```javascript
// Auto-delete documents after expiration
db.sessions.createIndex(
    { created_at: 1 },
    { expireAfterSeconds: 3600 }
)
```

## 🔍 Index Usage

```javascript
// Explain query execution
db.employees.find({ email: "john@example.com" }).explain("executionStats")

// Check index usage
db.employees.aggregate([
    { $indexStats: {} }
])
```

## 🎯 Best Practices

1. **Index frequently queried fields**
2. **Use compound indexes** for multiple field queries
3. **Index fields in sort operations**
4. **Monitor index usage** and remove unused indexes
5. **Consider index selectivity**
6. **Use partial indexes** for filtered queries
7. **Balance read and write performance**

---

**Next**: Learn about [Replication & Sharding](./REPLICATION-SHARDING.md)

