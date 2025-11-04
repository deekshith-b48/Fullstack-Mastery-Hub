# Mongoose Best Practices

## 📚 Overview

Following best practices ensures maintainable, performant, and secure Mongoose applications.

## 🎯 Code Organization

### Schema Definition

```javascript
// models/User.js
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    // Schema definition
}, {
    timestamps: true
});

module.exports = mongoose.model('User', userSchema);
```

### Service Layer

```javascript
// services/userService.js
const User = require('../models/User');

class UserService {
    async createUser(data) {
        return await User.create(data);
    }

    async getUserById(id) {
        return await User.findById(id);
    }
}

module.exports = new UserService();
```

## 🔒 Security

### Input Validation

```javascript
// Always validate at schema level
const user = await User.create({
    name: req.body.name,
    email: req.body.email
});
// Validation happens automatically
```

### NoSQL Injection Prevention

```javascript
// ✅ Good: Use Mongoose methods
await User.find({ email: userEmail });

// ❌ Bad: Raw queries with user input
await User.find({ $where: `this.email == '${userEmail}'` });
```

## 📊 Performance

### Indexing

```javascript
// Create indexes
userSchema.index({ email: 1 });
userSchema.index({ department: 1, salary: -1 });
```

### Connection Pooling

```javascript
mongoose.connect(uri, {
    maxPoolSize: 10,
    minPoolSize: 5
});
```

## 🎯 Best Practices Checklist

- [ ] Use async/await for all operations
- [ ] Handle errors properly
- [ ] Use transactions for multiple operations
- [ ] Validate data at schema level
- [ ] Create indexes on frequently queried fields
- [ ] Use connection pooling
- [ ] Avoid N+1 queries
- [ ] Use lean() for read-only queries
- [ ] Test thoroughly
- [ ] Document complex logic

---

**Mongoose section complete!** Next: Learn about [TypeORM](./../03-TypeORM/documentation/TYPEORM-FUNDAMENTALS.md)

