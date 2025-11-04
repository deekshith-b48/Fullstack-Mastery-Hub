# Mongoose Fundamentals

## 📚 Overview

Mongoose is a MongoDB object modeling tool for Node.js. It provides a schema-based solution for modeling application data with built-in type casting, validation, query building, and business logic hooks.

## 🎯 What is Mongoose?

Mongoose provides a straight-forward, schema-based solution to model application data. It includes built-in type casting, validation, query building, and business logic hooks.

### Key Features

- **Schemas**: Define data structure
- **Models**: Construct documents
- **Validation**: Built-in validators
- **Middleware**: Pre/post hooks
- **Query Building**: Fluent API
- **Population**: Reference other documents
- **Plugins**: Reusable functionality

## 🚀 Installation

### Install Mongoose

```bash
# Install Mongoose
npm install mongoose
```

## 🔧 Setup

### Connect to MongoDB

```javascript
const mongoose = require('mongoose');

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/myapp', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

// Connection events
mongoose.connection.on('connected', () => {
    console.log('Mongoose connected to MongoDB');
});

mongoose.connection.on('error', (err) => {
    console.error('Mongoose connection error:', err);
});

mongoose.connection.on('disconnected', () => {
    console.log('Mongoose disconnected');
});
```

### Async Connection

```javascript
// Using async/await
async function connectDB() {
    try {
        await mongoose.connect('mongodb://localhost:27017/myapp');
        console.log('MongoDB connected');
    } catch (error) {
        console.error('Connection error:', error);
    }
}

connectDB();
```

## 📊 Defining Schemas

### Basic Schema

```javascript
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    firstName: {
        type: String,
        required: true,
        trim: true
    },
    lastName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        validate: {
            validator: function(v) {
                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
            },
            message: 'Invalid email format'
        }
    },
    age: {
        type: Number,
        min: 0,
        max: 120
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});
```

### Schema Types

```javascript
const schema = new Schema({
    name: String,                    // String
    age: Number,                     // Number
    active: Boolean,                 // Boolean
    birthday: Date,                  // Date
    hobbies: [String],               // Array of strings
    address: {                       // Nested object
        street: String,
        city: String,
        zip: String
    },
    tags: [{
        name: String,
        color: String
    }],
    metadata: Schema.Types.Mixed,   // Any type
    userId: Schema.Types.ObjectId   // ObjectId reference
});
```

### Create Model

```javascript
// Create model from schema
const User = mongoose.model('User', userSchema);

// Export model
module.exports = User;
```

## 🔍 Basic Operations

### Create

```javascript
// Create single document
const user = await User.create({
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    age: 30
});

// Create multiple documents
const users = await User.insertMany([
    {
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com'
    },
    {
        firstName: 'Bob',
        lastName: 'Johnson',
        email: 'bob@example.com'
    }
]);
```

### Read

```javascript
// Find all
const users = await User.find();

// Find by ID
const user = await User.findById(userId);

// Find one
const user = await User.findOne({ email: 'john@example.com' });

// Find with conditions
const users = await User.find({ age: { $gt: 25 } });

// Select specific fields
const users = await User.find().select('firstName lastName email');

// Limit and skip
const users = await User.find().limit(10).skip(20);

// Sort
const users = await User.find().sort({ age: -1 });
```

### Update

```javascript
// Update one
await User.updateOne(
    { email: 'john@example.com' },
    { age: 31 }
);

// Update many
await User.updateMany(
    { department: 'IT' },
    { salary: 85000 }
);

// Find and update
const user = await User.findOneAndUpdate(
    { email: 'john@example.com' },
    { age: 31 },
    { new: true }  // Return updated document
);

// Save method
const user = await User.findById(userId);
user.age = 31;
await user.save();
```

### Delete

```javascript
// Delete one
await User.deleteOne({ email: 'john@example.com' });

// Delete many
await User.deleteMany({ age: { $lt: 18 } });

// Find and delete
await User.findOneAndDelete({ email: 'john@example.com' });
```

## 🎯 Best Practices

1. **Define schemas** before creating models
2. **Use validation** at schema level
3. **Handle errors** properly
4. **Use async/await** for operations
5. **Index frequently queried fields**
6. **Use middleware** for common logic

---

**Next**: Learn about [Schemas & Models](./SCHEMAS-MODELS.md)

