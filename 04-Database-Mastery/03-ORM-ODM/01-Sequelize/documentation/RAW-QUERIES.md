# Sequelize Raw Queries

## 📚 Overview

Sequelize allows you to execute raw SQL queries when ORM methods are insufficient or for performance-critical operations.

## 🔍 Basic Raw Queries

### SELECT Query

```javascript
const { QueryTypes } = require('sequelize');

// Simple query
const users = await sequelize.query(
    'SELECT * FROM users WHERE age > 25',
    { type: QueryTypes.SELECT }
);

// Query with replacements
const users = await sequelize.query(
    'SELECT * FROM users WHERE age > :age AND department = :dept',
    {
        replacements: { age: 25, dept: 'IT' },
        type: QueryTypes.SELECT
    }
);
```

### INSERT Query

```javascript
await sequelize.query(
    'INSERT INTO users (name, email) VALUES (:name, :email)',
    {
        replacements: { name: 'John', email: 'john@example.com' },
        type: QueryTypes.INSERT
    }
);
```

### UPDATE Query

```javascript
await sequelize.query(
    'UPDATE users SET salary = :salary WHERE id = :id',
    {
        replacements: { salary: 80000, id: 1 },
        type: QueryTypes.UPDATE
    }
);
```

### DELETE Query

```javascript
await sequelize.query(
    'DELETE FROM users WHERE id = :id',
    {
        replacements: { id: 1 },
        type: QueryTypes.DELETE
    }
);
```

## 🔒 Security

### Parameterized Queries

```javascript
// ✅ Good: Use replacements
await sequelize.query(
    'SELECT * FROM users WHERE email = :email',
    { replacements: { email: userEmail } }
);

// ❌ Bad: String concatenation (SQL injection risk)
await sequelize.query(
    `SELECT * FROM users WHERE email = '${userEmail}'`
);
```

## 🎯 Best Practices

1. **Use parameterized queries** to prevent SQL injection
2. **Use raw queries** sparingly
3. **Document complex queries**
4. **Test queries** thoroughly
5. **Consider performance** implications

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

