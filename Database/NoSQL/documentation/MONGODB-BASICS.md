# MongoDB Basics

## 📚 Overview

MongoDB is a NoSQL document database that stores data in flexible, JSON-like documents.

## 🚀 Installation

```bash
# Install MongoDB
brew install mongodb-community  # macOS
# Or download from mongodb.com

# Start MongoDB
brew services start mongodb-community

# Connect via shell
mongosh
```

## 🎯 Basic Operations

### Create Database

```javascript
// Use database (creates if doesn't exist)
use myapp
```

### Insert Documents

```javascript
// Insert single document
db.users.insertOne({
  name: "John Doe",
  email: "john@example.com",
  age: 30,
  tags: ["developer", "javascript"]
});

// Insert multiple documents
db.users.insertMany([
  { name: "Jane Doe", email: "jane@example.com", age: 25 },
  { name: "Bob Smith", email: "bob@example.com", age: 35 }
]);
```

### Query Documents

```javascript
// Find all
db.users.find();

// Find with condition
db.users.find({ age: { $gt: 25 } });

// Find one
db.users.findOne({ email: "john@example.com" });

// Projection (select fields)
db.users.find({}, { name: 1, email: 1 });

// Sort
db.users.find().sort({ age: 1 }); // Ascending
db.users.find().sort({ age: -1 }); // Descending

// Limit
db.users.find().limit(10);

// Skip (pagination)
db.users.find().skip(20).limit(10);
```

### Update Documents

```javascript
// Update one
db.users.updateOne(
  { email: "john@example.com" },
  { $set: { age: 31 } }
);

// Update many
db.users.updateMany(
  { age: { $lt: 18 } },
  { $set: { status: "minor" } }
);

// Replace document
db.users.replaceOne(
  { email: "john@example.com" },
  { name: "John Smith", email: "john@example.com", age: 31 }
);

// Upsert (insert if doesn't exist)
db.users.updateOne(
  { email: "new@example.com" },
  { $set: { name: "New User", age: 20 } },
  { upsert: true }
);
```

### Delete Documents

```javascript
// Delete one
db.users.deleteOne({ email: "john@example.com" });

// Delete many
db.users.deleteMany({ status: "inactive" });
```

## 🔍 Query Operators

```javascript
// Comparison operators
db.users.find({ age: { $gt: 25 } });        // Greater than
db.users.find({ age: { $gte: 25 } });       // Greater than or equal
db.users.find({ age: { $lt: 30 } });        // Less than
db.users.find({ age: { $lte: 30 } });       // Less than or equal
db.users.find({ age: { $ne: 25 } });        // Not equal
db.users.find({ age: { $in: [25, 30, 35] } }); // In array

// Logical operators
db.users.find({
  $and: [
    { age: { $gt: 25 } },
    { status: "active" }
  ]
});

db.users.find({
  $or: [
    { age: { $gt: 30 } },
    { status: "premium" }
  ]
});

// Element operators
db.users.find({ email: { $exists: true } });
db.users.find({ tags: { $type: "array" } });

// Array operators
db.users.find({ tags: { $in: ["developer"] } });
db.users.find({ tags: { $all: ["developer", "javascript"] } });
db.users.find({ tags: { $size: 2 } });
```

## 📊 Aggregation Pipeline

```javascript
// Simple aggregation
db.orders.aggregate([
  { $match: { status: "completed" } },
  { $group: {
      _id: "$user_id",
      total: { $sum: "$amount" },
      count: { $sum: 1 }
    }
  },
  { $sort: { total: -1 } },
  { $limit: 10 }
]);

// Lookup (join)
db.orders.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "user_id",
      foreignField: "_id",
      as: "user"
    }
  }
]);
```

## 🔐 Indexes

```javascript
// Create index
db.users.createIndex({ email: 1 });

// Create unique index
db.users.createIndex({ email: 1 }, { unique: true });

// Create compound index
db.users.createIndex({ name: 1, email: 1 });

// List indexes
db.users.getIndexes();

// Drop index
db.users.dropIndex({ email: 1 });
```

---

**Next**: Learn about [Redis](./REDIS-BASICS.md)

