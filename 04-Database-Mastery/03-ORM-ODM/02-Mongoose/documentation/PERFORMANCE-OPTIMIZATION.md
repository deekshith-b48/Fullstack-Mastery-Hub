# Mongoose Performance Optimization

## 📚 Overview

Optimizing Mongoose performance involves efficient queries, proper indexing, connection management, and query optimization.

## 🔍 Query Optimization

### Use Select

```javascript
// ✅ Good: Select only needed fields
const users = await User.find().select('name email');

// ❌ Bad: Fetch all fields
const users = await User.find();
```

### Use Lean

```javascript
// Lean queries return plain JavaScript objects (faster)
const users = await User.find().lean();

// Use when you don't need Mongoose document features
```

### Limit Results

```javascript
// Limit and paginate
const users = await User.find()
    .limit(10)
    .skip(20);
```

## 📊 Indexing

### Create Indexes

```javascript
// Single field index
userSchema.index({ email: 1 });

// Compound index
userSchema.index({ department: 1, salary: -1 });

// Text index
userSchema.index({ description: 'text' });

// Unique index
userSchema.index({ email: 1 }, { unique: true });
```

## 🔗 Connection Management

```javascript
// Connection options
mongoose.connect(uri, {
    maxPoolSize: 10,
    minPoolSize: 5,
    serverSelectionTimeoutMS: 5000,
    socketTimeoutMS: 45000
});
```

## 🎯 Best Practices

1. **Create indexes** on frequently queried fields
2. **Use lean()** for read-only queries
3. **Select only needed fields**
4. **Use connection pooling**
5. **Monitor query performance**
6. **Avoid N+1 queries**
7. **Use aggregation** for complex operations

---

**Next**: Learn about [Transactions & Sessions](./TRANSACTIONS-SESSIONS.md)

