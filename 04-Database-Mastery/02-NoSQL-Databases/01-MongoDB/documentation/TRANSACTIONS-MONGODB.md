# MongoDB Transactions

## 📚 Overview

MongoDB supports multi-document ACID transactions starting from version 4.0, providing data consistency across multiple operations.

## 🔄 Transaction Operations

### Start Transaction

```javascript
// Start session
const session = client.startSession()

// Start transaction
session.startTransaction()

try {
    // Perform operations
    await db.employees.insertOne(
        { name: "John", salary: 75000 },
        { session }
    )
    
    await db.accounts.updateOne(
        { user_id: 123 },
        { $inc: { balance: -100 } },
        { session }
    )
    
    // Commit transaction
    await session.commitTransaction()
} catch (error) {
    // Abort transaction
    await session.abortTransaction()
} finally {
    session.endSession()
}
```

### Transaction Options

```javascript
// Transaction with read concern
session.startTransaction({
    readConcern: { level: "snapshot" },
    writeConcern: { w: "majority" }
})
```

## 🎯 Best Practices

1. **Keep transactions short** to reduce lock time
2. **Use appropriate read/write concerns**
3. **Handle errors** properly
4. **Test transaction behavior** thoroughly
5. **Monitor transaction performance**

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

