# Sequelize Performance Optimization

## 📚 Overview

Optimizing Sequelize performance involves efficient queries, proper indexing, connection pooling, and query optimization techniques.

## 🔍 Query Optimization

### Use Eager Loading Efficiently

```javascript
// ✅ Good: Include only needed relations
const users = await User.findAll({
    include: [{
        model: Post,
        attributes: ['id', 'title']  // Only fetch needed fields
    }]
});

// ❌ Bad: Include all relations
const users = await User.findAll({
    include: [Post, Comment, Like]  // May fetch unnecessary data
});
```

### Use Attributes

```javascript
// Select only needed columns
const users = await User.findAll({
    attributes: ['id', 'name', 'email']
});

// Exclude columns
const users = await User.findAll({
    attributes: { exclude: ['password'] }
});
```

### Use Raw Queries for Complex Operations

```javascript
// For complex queries, use raw SQL
const users = await sequelize.query(
    'SELECT * FROM users WHERE age > :age',
    {
        replacements: { age: 25 },
        type: QueryTypes.SELECT
    }
);
```

## 📊 Connection Pooling

```javascript
const sequelize = new Sequelize('database', 'username', 'password', {
    host: 'localhost',
    dialect: 'postgres',
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
});
```

## 🔍 Indexing

```javascript
// Add indexes in migrations
await queryInterface.addIndex('users', ['email'], {
    unique: true,
    name: 'users_email_unique'
});

await queryInterface.addIndex('users', ['department', 'salary'], {
    name: 'users_dept_salary_idx'
});
```

## 🎯 Best Practices

1. **Use connection pooling**
2. **Index frequently queried columns**
3. **Limit fetched data**
4. **Use raw queries** for complex operations
5. **Monitor query performance**
6. **Avoid N+1 queries**
7. **Use transactions** appropriately

---

**Next**: Learn about [Raw Queries](./RAW-QUERIES.md)

