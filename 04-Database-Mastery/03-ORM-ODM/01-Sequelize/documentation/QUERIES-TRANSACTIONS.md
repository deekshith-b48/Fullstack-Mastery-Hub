# Sequelize Queries & Transactions

## 📚 Overview

Sequelize provides powerful querying capabilities and transaction support for complex database operations.

## 🔍 Advanced Queries

### Where Clauses

```javascript
const { Op } = require('sequelize');

// Comparison operators
await User.findAll({
    where: {
        age: {
            [Op.gt]: 25,      // Greater than
            [Op.gte]: 25,     // Greater than or equal
            [Op.lt]: 50,      // Less than
            [Op.lte]: 50,     // Less than or equal
            [Op.ne]: 30,      // Not equal
            [Op.between]: [25, 50],
            [Op.in]: [25, 30, 35],
            [Op.notIn]: [20, 40]
        }
    }
});

// Logical operators
await User.findAll({
    where: {
        [Op.and]: [
            { age: { [Op.gt]: 25 } },
            { department: 'IT' }
        ],
        [Op.or]: [
            { department: 'IT' },
            { department: 'Sales' }
        ]
    }
});

// Like
await User.findAll({
    where: {
        email: {
            [Op.like]: '%@example.com'
        }
    }
});
```

### Ordering and Limiting

```javascript
// Order by
await User.findAll({
    order: [
        ['age', 'DESC'],
        ['name', 'ASC']
    ]
});

// Limit and offset
await User.findAll({
    limit: 10,
    offset: 20
});
```

### Eager Loading

```javascript
// Include related models
const users = await User.findAll({
    include: [{
        model: Post,
        as: 'posts',
        where: { published: true },
        required: false  // LEFT JOIN
    }]
});

// Nested includes
const users = await User.findAll({
    include: [{
        model: Post,
        include: [{
            model: Comment
        }]
    }]
});
```

## 🔄 Transactions

### Basic Transaction

```javascript
const transaction = await sequelize.transaction();

try {
    const user = await User.create({
        name: 'John',
        email: 'john@example.com'
    }, { transaction });

    await Post.create({
        title: 'My Post',
        userId: user.id
    }, { transaction });

    await transaction.commit();
} catch (error) {
    await transaction.rollback();
    throw error;
}
```

### Automatic Transaction

```javascript
await sequelize.transaction(async (t) => {
    const user = await User.create({
        name: 'John',
        email: 'john@example.com'
    }, { transaction: t });

    await Post.create({
        title: 'My Post',
        userId: user.id
    }, { transaction: t });
});
```

## 🎯 Best Practices

1. **Use transactions** for multiple related operations
2. **Handle errors** and rollback properly
3. **Use eager loading** efficiently
4. **Optimize queries** with proper where clauses
5. **Use indexes** for frequently queried fields

---

**Next**: Learn about [Hooks & Validations](./HOOKS-VALIDATIONS.md)

