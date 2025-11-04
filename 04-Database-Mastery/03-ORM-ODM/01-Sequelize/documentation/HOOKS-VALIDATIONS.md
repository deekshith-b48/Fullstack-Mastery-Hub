# Sequelize Hooks & Validations

## 📚 Overview

Sequelize hooks allow you to execute code at specific lifecycle events, while validations ensure data integrity.

## 🪝 Hooks (Lifecycle Events)

### Model Hooks

```javascript
const User = sequelize.define('User', {
    name: DataTypes.STRING,
    email: DataTypes.STRING
});

// Before create
User.beforeCreate((user, options) => {
    user.email = user.email.toLowerCase();
});

// After create
User.afterCreate((user, options) => {
    console.log('User created:', user.id);
});

// Before update
User.beforeUpdate((user, options) => {
    user.updatedAt = new Date();
});

// Before destroy
User.beforeDestroy((user, options) => {
    // Cleanup logic
});
```

### Hook Types

```javascript
// beforeValidate / afterValidate
// beforeCreate / afterCreate
// beforeUpdate / afterUpdate
// beforeDestroy / afterDestroy
// beforeSave / afterSave
// beforeBulkCreate / afterBulkCreate
// beforeBulkUpdate / afterBulkUpdate
// beforeBulkDestroy / afterBulkDestroy
```

## ✅ Validations

### Built-in Validators

```javascript
const User = sequelize.define('User', {
    email: {
        type: DataTypes.STRING,
        validate: {
            isEmail: true,
            notEmpty: true
        }
    },
    age: {
        type: DataTypes.INTEGER,
        validate: {
            min: 0,
            max: 120,
            isInt: true
        }
    },
    url: {
        type: DataTypes.STRING,
        validate: {
            isUrl: true
        }
    }
});
```

### Custom Validators

```javascript
const User = sequelize.define('User', {
    email: {
        type: DataTypes.STRING,
        validate: {
            isEmail: true,
            customValidator(value) {
                if (!value.endsWith('@example.com')) {
                    throw new Error('Email must be from example.com');
                }
            }
        }
    }
});
```

### Validation Errors

```javascript
try {
    const user = await User.create({
        email: 'invalid-email'
    });
} catch (error) {
    if (error instanceof Sequelize.ValidationError) {
        console.error('Validation errors:', error.errors);
    }
}
```

## 🎯 Best Practices

1. **Use hooks** for data transformation
2. **Validate data** at model level
3. **Handle validation errors** properly
4. **Keep hooks simple**
5. **Test hooks** thoroughly

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

