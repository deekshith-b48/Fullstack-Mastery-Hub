# MongoDB Performance Optimization

## 📚 Overview

Performance optimization in MongoDB involves query tuning, index optimization, schema design, and configuration tuning.

## 🔍 Query Optimization

### Explain Plans

```javascript
// Explain query execution
db.employees.find({ email: "john@example.com" }).explain("executionStats")

// Analyze execution stats
// - executionTimeMillis: Query execution time
// - totalDocsExamined: Documents examined
// - totalKeysExamined: Index keys examined
```

### Query Patterns

```javascript
// ✅ Good: Use indexed fields
db.employees.find({ email: "john@example.com" })  // Uses index

// ❌ Bad: Full collection scan
db.employees.find({ first_name: /^John/ })  // No index

// ✅ Good: Limit results
db.employees.find().limit(10)

// ✅ Good: Use projection
db.employees.find({}, { first_name: 1, email: 1 })
```

## 📊 Index Optimization

### Index Selection

```javascript
// Create indexes for query patterns
db.employees.createIndex({ email: 1 })
db.employees.createIndex({ department: 1, salary: -1 })

// Monitor index usage
db.employees.aggregate([{ $indexStats: {} }])
```

### Index Maintenance

```javascript
// Rebuild indexes
db.employees.reIndex()

// Drop unused indexes
db.employees.dropIndex({ unused_field: 1 })
```

## 🏗️ Schema Design

### Embedding vs Referencing

```javascript
// Embed when: Frequently accessed together, small documents
{
    _id: 1,
    name: "John",
    address: {
        street: "123 Main St",
        city: "New York"
    }
}

// Reference when: Large documents, infrequent access
{
    _id: 1,
    name: "John",
    address_id: ObjectId("...")
}
```

## ⚙️ Configuration

```javascript
// Connection pool settings
const client = new MongoClient(uri, {
    maxPoolSize: 10,
    minPoolSize: 5
})

// Write concern
db.employees.insertOne(
    { name: "John" },
    { writeConcern: { w: 1, j: false } }
)
```

## 🎯 Best Practices

1. **Create appropriate indexes**
2. **Optimize query patterns**
3. **Design efficient schemas**
4. **Monitor performance metrics**
5. **Use connection pooling**
6. **Tune write concerns**
7. **Regular index maintenance**

---

**Next**: Learn about [Security Best Practices](./SECURITY-BEST-PRACTICES.md)

