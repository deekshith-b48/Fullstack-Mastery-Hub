# MongoDB CRUD Operations

## 📚 Overview

CRUD (Create, Read, Update, Delete) operations are the fundamental database operations. This guide covers comprehensive CRUD operations in MongoDB.

## ➕ Create Operations

### insertOne()

```javascript
// Insert single document
const result = db.employees.insertOne({
    first_name: "John",
    last_name: "Doe",
    email: "john@example.com",
    salary: 75000,
    department: "IT",
    created_at: new Date()
})

// Access inserted ID
console.log(result.insertedId)
```

### insertMany()

```javascript
// Insert multiple documents
const result = db.employees.insertMany([
    {
        first_name: "Jane",
        last_name: "Smith",
        email: "jane@example.com",
        salary: 80000,
        department: "Sales"
    },
    {
        first_name: "Bob",
        last_name: "Johnson",
        email: "bob@example.com",
        salary: 70000,
        department: "Marketing"
    }
])

// Access inserted IDs
console.log(result.insertedIds)
```

### Insert Options

```javascript
// Insert with ordered: false (continue on error)
db.employees.insertMany(
    [
        { email: "john@example.com" },
        { email: "john@example.com" },  // Duplicate
        { email: "jane@example.com" }
    ],
    { ordered: false }
)

// Write concern
db.employees.insertOne(
    { name: "John" },
    { writeConcern: { w: "majority", wtimeout: 5000 } }
)
```

## 📖 Read Operations

### find()

```javascript
// Find all documents
db.employees.find()

// Find with filter
db.employees.find({ department: "IT" })

// Find with projection
db.employees.find(
    { department: "IT" },
    { first_name: 1, last_name: 1, email: 1, _id: 0 }
)

// Limit results
db.employees.find().limit(10)

// Skip documents
db.employees.find().skip(20).limit(10)

// Sort results
db.employees.find().sort({ salary: -1 })
db.employees.find().sort({ department: 1, salary: -1 })
```

### findOne()

```javascript
// Find single document
db.employees.findOne({ email: "john@example.com" })

// Find one with projection
db.employees.findOne(
    { department: "IT" },
    { first_name: 1, last_name: 1 }
)
```

### Query Operators

```javascript
// Comparison
db.employees.find({ salary: { $gt: 70000 } })
db.employees.find({ salary: { $gte: 70000, $lte: 90000 } })
db.employees.find({ department: { $in: ["IT", "Sales"] } })
db.employees.find({ department: { $ne: "IT" } })

// Logical
db.employees.find({
    $and: [
        { salary: { $gt: 70000 } },
        { department: "IT" }
    ]
})

db.employees.find({
    $or: [
        { department: "IT" },
        { salary: { $gt: 100000 } }
    ]
})

// Element
db.employees.find({ email: { $exists: true } })
db.employees.find({ salary: { $type: "number" } })

// Array
db.employees.find({ hobbies: { $in: ["reading", "coding"] } })
db.employees.find({ hobbies: { $all: ["reading", "coding"] } })
db.employees.find({ hobbies: { $size: 3 } })
```

## ✏️ Update Operations

### updateOne()

```javascript
// Update single document
db.employees.updateOne(
    { email: "john@example.com" },
    { $set: { salary: 80000 } }
)

// Update with multiple fields
db.employees.updateOne(
    { email: "john@example.com" },
    {
        $set: {
            salary: 80000,
            department: "Engineering"
        }
    }
)

// Increment numeric field
db.employees.updateOne(
    { email: "john@example.com" },
    { $inc: { salary: 5000 } }
)

// Add to array
db.employees.updateOne(
    { email: "john@example.com" },
    { $push: { hobbies: "swimming" } }
)
```

### updateMany()

```javascript
// Update multiple documents
db.employees.updateMany(
    { department: "IT" },
    { $set: { salary: 85000 } }
)

// Increment for all
db.employees.updateMany(
    { department: "IT" },
    { $inc: { salary: 1000 } }
)
```

### Update Operators

```javascript
// $set - Set field value
db.employees.updateOne(
    { email: "john@example.com" },
    { $set: { salary: 80000 } }
)

// $unset - Remove field
db.employees.updateOne(
    { email: "john@example.com" },
    { $unset: { hobbies: "" } }
)

// $inc - Increment numeric value
db.employees.updateOne(
    { email: "john@example.com" },
    { $inc: { salary: 5000 } }
)

// $mul - Multiply numeric value
db.employees.updateOne(
    { email: "john@example.com" },
    { $mul: { salary: 1.1 } }
)

// $push - Add to array
db.employees.updateOne(
    { email: "john@example.com" },
    { $push: { hobbies: "swimming" } }
)

// $pull - Remove from array
db.employees.updateOne(
    { email: "john@example.com" },
    { $pull: { hobbies: "reading" } }
)

// $addToSet - Add to array if not exists
db.employees.updateOne(
    { email: "john@example.com" },
    { $addToSet: { hobbies: "coding" } }
)
```

### replaceOne()

```javascript
// Replace entire document
db.employees.replaceOne(
    { email: "john@example.com" },
    {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        salary: 90000,
        department: "IT",
        updated_at: new Date()
    }
)
```

### Update Options

```javascript
// Upsert (insert if not exists)
db.employees.updateOne(
    { email: "john@example.com" },
    { $set: { salary: 80000 } },
    { upsert: true }
)

// Array filters
db.employees.updateOne(
    { email: "john@example.com" },
    { $set: { "hobbies.$[elem]": "programming" } },
    { arrayFilters: [{ elem: "coding" }] }
)
```

## 🗑️ Delete Operations

### deleteOne()

```javascript
// Delete single document
db.employees.deleteOne({ email: "john@example.com" })

// Delete with conditions
db.employees.deleteOne({ salary: { $lt: 50000 } })
```

### deleteMany()

```javascript
// Delete multiple documents
db.employees.deleteMany({ department: "Marketing" })

// Delete all documents
db.employees.deleteMany({})

// Delete with conditions
db.employees.deleteMany({ salary: { $lt: 50000 } })
```

## 🎯 Best Practices

1. **Use appropriate methods** for single vs multiple operations
2. **Use projections** to limit returned data
3. **Create indexes** for frequently queried fields
4. **Use update operators** efficiently
5. **Handle errors** properly
6. **Use write concerns** for critical operations
7. **Test queries** before production

---

**Next**: Learn about [Aggregation Framework](./AGGREGATION-FRAMEWORK.md)

