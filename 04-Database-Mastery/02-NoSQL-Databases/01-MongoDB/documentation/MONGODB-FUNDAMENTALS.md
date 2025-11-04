# MongoDB Fundamentals

## 📚 Overview

MongoDB is a popular NoSQL document database that stores data in flexible, JSON-like documents. It's designed for scalability and developer productivity.

## 🎯 What is MongoDB?

MongoDB is a document-oriented database that stores data in BSON (Binary JSON) format. Unlike relational databases, it doesn't require a fixed schema.

### Key Features

- **Document Model**: Flexible schema design
- **Horizontal Scaling**: Sharding for large datasets
- **High Performance**: Indexed queries
- **Rich Query Language**: Complex queries supported
- **Replication**: Built-in replication
- **Aggregation Framework**: Powerful data processing

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Import MongoDB GPG key
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -

# Add repository
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod
```

### macOS

```bash
# Using Homebrew
brew tap mongodb/brew
brew install mongodb-community

# Start MongoDB
brew services start mongodb-community
```

### Windows

Download MongoDB Community Server from: https://www.mongodb.com/try/download/community

## 🔧 MongoDB Shell

### Connect to MongoDB

```bash
# Connect to local MongoDB
mongosh

# Connect to remote MongoDB
mongosh "mongodb://hostname:27017"

# Connect with authentication
mongosh "mongodb://username:password@hostname:27017/database"
```

### Basic Commands

```javascript
// Show databases
show dbs

// Use database
use myapp

// Show collections
show collections

// Show current database
db

// Get database stats
db.stats()
```

## 📊 Data Model

### Documents

```javascript
// Document structure (JSON-like)
{
    _id: ObjectId("507f1f77bcf86cd799439011"),
    first_name: "John",
    last_name: "Doe",
    email: "john@example.com",
    age: 30,
    address: {
        street: "123 Main St",
        city: "New York",
        zip: "10001"
    },
    hobbies: ["reading", "coding", "traveling"],
    created_at: ISODate("2024-01-15T10:30:00Z")
}
```

### Collections

Collections are groups of documents (similar to tables in SQL).

### Databases

Databases contain collections (similar to databases in SQL).

## 🏗️ Basic Operations

### Create Database

```javascript
// Create database (use it)
use myapp

// Database is created when first document is inserted
```

### Create Collection

```javascript
// Create collection explicitly
db.createCollection("employees")

// Or create implicitly by inserting document
db.employees.insertOne({ name: "John" })
```

### Insert Documents

```javascript
// Insert single document
db.employees.insertOne({
    first_name: "John",
    last_name: "Doe",
    email: "john@example.com",
    salary: 75000,
    department: "IT"
})

// Insert multiple documents
db.employees.insertMany([
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
```

### Query Documents

```javascript
// Find all documents
db.employees.find()

// Find with filter
db.employees.find({ department: "IT" })

// Find one document
db.employees.findOne({ email: "john@example.com" })

// Find with projection
db.employees.find(
    { department: "IT" },
    { first_name: 1, last_name: 1, email: 1 }
)

// Find with conditions
db.employees.find({ salary: { $gt: 70000 } })
db.employees.find({ salary: { $gte: 70000, $lte: 90000 } })
```

### Update Documents

```javascript
// Update single document
db.employees.updateOne(
    { email: "john@example.com" },
    { $set: { salary: 80000 } }
)

// Update multiple documents
db.employees.updateMany(
    { department: "IT" },
    { $set: { salary: 85000 } }
)

// Replace document
db.employees.replaceOne(
    { email: "john@example.com" },
    {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        salary: 90000,
        department: "IT"
    }
)
```

### Delete Documents

```javascript
// Delete single document
db.employees.deleteOne({ email: "john@example.com" })

// Delete multiple documents
db.employees.deleteMany({ department: "Marketing" })

// Delete all documents
db.employees.deleteMany({})
```

## 🔍 Query Operators

```javascript
// Comparison operators
db.employees.find({ salary: { $gt: 70000 } })      // Greater than
db.employees.find({ salary: { $gte: 70000 } })     // Greater than or equal
db.employees.find({ salary: { $lt: 80000 } })      // Less than
db.employees.find({ salary: { $lte: 80000 } })     // Less than or equal
db.employees.find({ salary: { $ne: 75000 } })      // Not equal
db.employees.find({ salary: { $in: [70000, 80000] } })  // In array

// Logical operators
db.employees.find({
    $and: [
        { salary: { $gt: 70000 } },
        { department: "IT" }
    ]
})

db.employees.find({
    $or: [
        { department: "IT" },
        { department: "Sales" }
    ]
})

db.employees.find({
    $not: { salary: { $lt: 50000 } }
})
```

## 📈 Indexes

```javascript
// Create index
db.employees.createIndex({ email: 1 })

// Create unique index
db.employees.createIndex({ email: 1 }, { unique: true })

// Create compound index
db.employees.createIndex({ department: 1, salary: -1 })

// List indexes
db.employees.getIndexes()

// Drop index
db.employees.dropIndex({ email: 1 })
```

## 🎯 Best Practices

1. **Design schema** based on access patterns
2. **Create indexes** on frequently queried fields
3. **Use appropriate data types**
4. **Embed related data** when accessed together
5. **Reference data** when accessed separately
6. **Regular backups** are essential
7. **Monitor performance** regularly

---

**Next**: Learn about [CRUD Operations](./CRUD-OPERATIONS.md)

