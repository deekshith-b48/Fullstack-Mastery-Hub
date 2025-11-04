# Mongoose Queries & Population

## 📚 Overview

Mongoose provides a fluent query API and population for referencing documents in other collections.

## 🔍 Query API

### Query Building

```javascript
// Chainable queries
const users = await User
    .find({ age: { $gt: 25 } })
    .select('name email')
    .sort({ age: -1 })
    .limit(10)
    .skip(20);

// Query with conditions
const users = await User.find({
    $or: [
        { department: 'IT' },
        { salary: { $gt: 100000 } }
    ]
}).where('age').gte(25).lte(65);
```

### Query Operators

```javascript
// Comparison
await User.find({ age: { $gt: 25 } });
await User.find({ age: { $gte: 25 } });
await User.find({ age: { $lt: 50 } });
await User.find({ age: { $lte: 50 } });
await User.find({ age: { $ne: 30 } });
await User.find({ age: { $in: [25, 30, 35] } });

// Logical
await User.find({
    $and: [
        { age: { $gt: 25 } },
        { department: 'IT' }
    ]
});

await User.find({
    $or: [
        { department: 'IT' },
        { department: 'Sales' }
    ]
});

// Element
await User.find({ email: { $exists: true } });
await User.find({ age: { $type: 'number' } });

// Array
await User.find({ hobbies: { $in: ['coding', 'reading'] } });
await User.find({ hobbies: { $all: ['coding', 'reading'] } });
await User.find({ hobbies: { $size: 3 } });
```

## 🔗 Population

### Basic Population

```javascript
// Populate single reference
const post = await Post.findById(postId).populate('author');

// Populate multiple references
const post = await Post.findById(postId)
    .populate('author')
    .populate('comments');

// Populate with select
const post = await Post.findById(postId)
    .populate('author', 'name email');

// Populate nested
const post = await Post.findById(postId)
    .populate({
        path: 'comments',
        populate: {
            path: 'author',
            select: 'name'
        }
    });
```

### Population Options

```javascript
// Populate with conditions
const post = await Post.findById(postId).populate({
    path: 'comments',
    match: { approved: true },
    select: 'content author',
    options: { limit: 10, sort: { createdAt: -1 } }
});
```

### Virtual Population

```javascript
// Define virtual populate
userSchema.virtual('posts', {
    ref: 'Post',
    localField: '_id',
    foreignField: 'author'
});

// Use virtual populate
const user = await User.findById(userId).populate('posts');
```

## 🎯 Best Practices

1. **Use query chaining** for readability
2. **Populate efficiently** - only needed fields
3. **Use select** to limit returned data
4. **Index populated fields**
5. **Avoid deep nesting** in population

---

**Next**: Learn about [Aggregation](./AGGREGATION-MONGOOSE.md)

