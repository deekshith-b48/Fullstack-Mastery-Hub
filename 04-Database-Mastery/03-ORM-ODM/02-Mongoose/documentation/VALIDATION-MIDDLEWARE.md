# Mongoose Validation & Middleware

## 📚 Overview

Mongoose provides built-in validation and middleware hooks for data validation and business logic execution.

## ✅ Validation

### Built-in Validators

```javascript
const userSchema = new Schema({
    email: {
        type: String,
        required: [true, 'Email is required'],
        unique: true,
        lowercase: true,
        trim: true,
        validate: {
            validator: function(v) {
                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
            },
            message: 'Invalid email format'
        }
    },
    age: {
        type: Number,
        min: [0, 'Age must be positive'],
        max: [120, 'Age cannot exceed 120'],
        validate: {
            validator: Number.isInteger,
            message: 'Age must be an integer'
        }
    },
    role: {
        type: String,
        enum: {
            values: ['admin', 'user', 'guest'],
            message: '{VALUE} is not a valid role'
        }
    }
});
```

### Custom Validators

```javascript
userSchema.path('email').validate(function(value) {
    return value.endsWith('@example.com');
}, 'Email must be from example.com domain');
```

### Async Validators

```javascript
userSchema.path('email').validate(async function(value) {
    const count = await this.constructor.countDocuments({ email: value });
    return count === 0;
}, 'Email already exists');
```

## 🪝 Middleware (Hooks)

### Pre Hooks

```javascript
// Pre-save hook
userSchema.pre('save', async function(next) {
    if (this.isModified('password')) {
        this.password = await bcrypt.hash(this.password, 10);
    }
    next();
});

// Pre-remove hook
userSchema.pre('remove', async function(next) {
    // Delete related posts
    await Post.deleteMany({ author: this._id });
    next();
});

// Pre-validate hook
userSchema.pre('validate', function(next) {
    if (this.email) {
        this.email = this.email.toLowerCase();
    }
    next();
});
```

### Post Hooks

```javascript
// Post-save hook
userSchema.post('save', function(doc, next) {
    console.log('User saved:', doc._id);
    next();
});

// Post-remove hook
userSchema.post('remove', function(doc) {
    console.log('User removed:', doc._id);
});
```

### Query Hooks

```javascript
// Pre-find hook
userSchema.pre('find', function() {
    this.where({ active: true });
});

// Post-find hook
userSchema.post('find', function(docs) {
    console.log('Found', docs.length, 'users');
});
```

## 🎯 Best Practices

1. **Use validation** at schema level
2. **Handle validation errors** properly
3. **Use middleware** for common logic
4. **Keep hooks simple**
5. **Test validation** thoroughly

---

**Next**: Learn about [Queries & Population](./QUERIES-POPULATION.md)

