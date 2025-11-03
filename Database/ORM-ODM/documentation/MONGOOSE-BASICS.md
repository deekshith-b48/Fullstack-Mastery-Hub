# Mongoose - MongoDB ODM

## 📚 Overview

Mongoose is an ODM (Object Document Mapper) for MongoDB and Node.js.

## 🚀 Installation

```bash
npm install mongoose
```

## 🎯 Setup

```javascript
const mongoose = require('mongoose');

// Connect
mongoose.connect('mongodb://localhost:27017/myapp', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// Connection events
mongoose.connection.on('connected', () => {
  console.log('Connected to MongoDB');
});

mongoose.connection.on('error', (err) => {
  console.error('MongoDB error:', err);
});
```

## 🧩 Schemas and Models

### Define Schema

```javascript
const { Schema } = require('mongoose');

const userSchema = new Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true
  },
  age: {
    type: Number,
    min: 0,
    max: 120
  },
  tags: [String],
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Add methods
userSchema.methods.getFullInfo = function() {
  return `${this.name} (${this.email})`;
};

// Static methods
userSchema.statics.findByEmail = function(email) {
  return this.findOne({ email });
};

// Create model
const User = mongoose.model('User', userSchema);
```

## 📝 CRUD Operations

### Create

```javascript
// Create single
const user = await User.create({
  name: 'John Doe',
  email: 'john@example.com',
  age: 30
});

// Create multiple
const users = await User.insertMany([
  { name: 'Jane', email: 'jane@example.com' },
  { name: 'Bob', email: 'bob@example.com' }
]);

// Create with save
const user = new User({
  name: 'John',
  email: 'john@example.com'
});
await user.save();
```

### Read

```javascript
// Find all
const users = await User.find();

// Find by ID
const user = await User.findById('507f1f77bcf86cd799439011');

// Find one
const user = await User.findOne({ email: 'john@example.com' });

// Find with conditions
const users = await User.find({
  age: { $gt: 25 }
}).limit(10).sort({ name: 1 });

// Count
const count = await User.countDocuments({ age: { $gt: 25 } });
```

### Update

```javascript
// Update one
await User.updateOne(
  { email: 'john@example.com' },
  { $set: { age: 31 } }
);

// Update many
await User.updateMany(
  { age: { $lt: 18 } },
  { $set: { status: 'minor' } }
);

// Find and update
const user = await User.findOneAndUpdate(
  { email: 'john@example.com' },
  { $set: { age: 31 } },
  { new: true } // Return updated document
);

// Update instance
const user = await User.findById(id);
user.age = 31;
await user.save();
```

### Delete

```javascript
// Delete one
await User.deleteOne({ email: 'john@example.com' });

// Delete many
await User.deleteMany({ status: 'inactive' });

// Find and delete
const user = await User.findOneAndDelete({ email: 'john@example.com' });

// Delete instance
const user = await User.findById(id);
await user.remove();
```

## 🔗 Relationships

### One-to-Many

```javascript
// User has many Posts
const postSchema = new Schema({
  title: String,
  content: String,
  author: {
    type: Schema.Types.ObjectId,
    ref: 'User'
  }
});

// Populate
const posts = await Post.find().populate('author');
```

### Many-to-Many

```javascript
// Users and Courses
const userSchema = new Schema({
  name: String,
  courses: [{
    type: Schema.Types.ObjectId,
    ref: 'Course'
  }]
});

const courseSchema = new Schema({
  name: String,
  students: [{
    type: Schema.Types.ObjectId,
    ref: 'User'
  }]
});
```

---

**Next**: Learn about [Prisma](./PRISMA-BASICS.md)

