# Mongoose Transactions & Sessions

## 📚 Overview

Mongoose supports MongoDB transactions for atomic operations across multiple documents or collections.

## 🔄 Transactions

### Basic Transaction

```javascript
const session = await mongoose.startSession();

session.startTransaction();

try {
    const user = await User.create([{
        name: 'John',
        email: 'john@example.com'
    }], { session });

    await Post.create([{
        title: 'My Post',
        author: user[0]._id
    }], { session });

    await session.commitTransaction();
} catch (error) {
    await session.abortTransaction();
    throw error;
} finally {
    session.endSession();
}
```

### Transaction with Operations

```javascript
const session = await mongoose.startSession();

try {
    await session.withTransaction(async () => {
        const user = await User.create([{
            name: 'John',
            email: 'john@example.com'
        }], { session });

        await Post.create([{
            title: 'My Post',
            author: user[0]._id
        }], { session });
    });
} finally {
    await session.endSession();
}
```

## 🎯 Best Practices

1. **Use transactions** for multiple related operations
2. **Handle errors** and abort on failure
3. **Keep transactions short**
4. **Test transaction behavior** thoroughly
5. **Monitor transaction performance**

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

