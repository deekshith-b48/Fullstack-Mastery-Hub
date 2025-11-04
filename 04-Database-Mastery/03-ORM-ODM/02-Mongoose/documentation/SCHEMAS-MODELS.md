# Mongoose Schemas & Models

## 📚 Overview

Schemas define the structure of documents, while models are constructors compiled from schemas. This guide covers advanced schema definition and model usage.

## 📊 Schema Definition

### Schema Options

```javascript
const userSchema = new Schema({
    name: String,
    email: String
}, {
    timestamps: true,              // Adds createdAt and updatedAt
    versionKey: false,             // Removes __v field
    collection: 'users',           // Custom collection name
    strict: true,                  // Only defined fields allowed
    validateBeforeSave: true       // Validate before saving
});
```

### Field Options

```javascript
const schema = new Schema({
    name: {
        type: String,
        required: true,             // Required field
        unique: true,               // Unique index
        lowercase: true,            // Convert to lowercase
        trim: true,                 // Trim whitespace
        minlength: 2,               // Minimum length
        maxlength: 50,              // Maximum length
        enum: ['admin', 'user'],    // Allowed values
        default: 'user',            // Default value
        index: true,                // Create index
        sparse: true,               // Sparse index
        select: false               // Exclude by default
    },
    age: {
        type: Number,
        min: 0,
        max: 120,
        validate: {
            validator: function(v) {
                return v >= 18;
            },
            message: 'Must be 18 or older'
        }
    }
});
```

### Virtual Properties

```javascript
userSchema.virtual('fullName').get(function() {
    return `${this.firstName} ${this.lastName}`;
});

// Enable virtuals in JSON
userSchema.set('toJSON', { virtuals: true });
```

### Methods

```javascript
// Instance methods
userSchema.methods.getDisplayName = function() {
    return `${this.firstName} ${this.lastName}`;
};

// Usage
const user = await User.findById(userId);
console.log(user.getDisplayName());
```

### Statics

```javascript
// Static methods
userSchema.statics.findByEmail = function(email) {
    return this.findOne({ email: email });
};

// Usage
const user = await User.findByEmail('john@example.com');
```

## 🔗 Relationships

### References

```javascript
// User schema
const userSchema = new Schema({
    name: String,
    posts: [{ type: Schema.Types.ObjectId, ref: 'Post' }]
});

// Post schema
const postSchema = new Schema({
    title: String,
    author: { type: Schema.Types.ObjectId, ref: 'User' }
});
```

### Embedded Documents

```javascript
const addressSchema = new Schema({
    street: String,
    city: String,
    zip: String
});

const userSchema = new Schema({
    name: String,
    address: addressSchema  // Embedded document
});
```

## 🎯 Best Practices

1. **Define schemas** comprehensively
2. **Use appropriate field types**
3. **Add validation** at schema level
4. **Use virtuals** for computed properties
5. **Use methods** for document logic
6. **Use statics** for collection logic

---

**Next**: Learn about [Validation & Middleware](./VALIDATION-MIDDLEWARE.md)

