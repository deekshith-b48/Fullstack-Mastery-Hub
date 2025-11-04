# Sequelize Fundamentals

## 📚 Overview

Sequelize is a promise-based Node.js ORM for PostgreSQL, MySQL, MariaDB, SQLite, and Microsoft SQL Server. It provides an easy-to-use abstraction layer for database operations.

## 🎯 What is Sequelize?

Sequelize simplifies database interactions by providing an object-relational mapping layer. It allows you to work with databases using JavaScript objects instead of raw SQL queries.

### Key Features

- **Promise-Based**: Async/await support
- **Relations**: Easy relationship management
- **Migrations**: Database version control
- **Validations**: Built-in validation
- **Hooks**: Lifecycle hooks
- **Transactions**: Transaction support
- **Raw Queries**: SQL when needed

## 🚀 Installation

### Install Sequelize

```bash
# Install Sequelize
npm install sequelize

# Install database driver
npm install pg pg-hstore          # PostgreSQL
npm install mysql2                 # MySQL
npm install sqlite3                # SQLite
npm install tedious                # SQL Server
```

## 🔧 Setup

### Initialize Sequelize

```javascript
const { Sequelize } = require('sequelize');

// PostgreSQL
const sequelize = new Sequelize('database', 'username', 'password', {
    host: 'localhost',
    dialect: 'postgres'
});

// MySQL
const sequelize = new Sequelize('database', 'username', 'password', {
    host: 'localhost',
    dialect: 'mysql'
});

// SQLite
const sequelize = new Sequelize({
    dialect: 'sqlite',
    storage: './database.sqlite'
});
```

### Test Connection

```javascript
async function testConnection() {
    try {
        await sequelize.authenticate();
        console.log('Connection established successfully.');
    } catch (error) {
        console.error('Unable to connect:', error);
    }
}

testConnection();
```

## 📊 Defining Models

### Basic Model

```javascript
const { DataTypes } = require('sequelize');

const User = sequelize.define('User', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    firstName: {
        type: DataTypes.STRING,
        allowNull: false
    },
    lastName: {
        type: DataTypes.STRING,
        allowNull: false
    },
    email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
        validate: {
            isEmail: true
        }
    },
    age: {
        type: DataTypes.INTEGER,
        validate: {
            min: 0,
            max: 120
        }
    }
}, {
    tableName: 'users',
    timestamps: true
});
```

### Data Types

```javascript
const { DataTypes } = require('sequelize');

// String types
DataTypes.STRING          // VARCHAR(255)
DataTypes.STRING(100)      // VARCHAR(100)
DataTypes.TEXT            // TEXT
DataTypes.CHAR(10)        // CHAR(10)

// Numeric types
DataTypes.INTEGER         // INTEGER
DataTypes.BIGINT          // BIGINT
DataTypes.FLOAT           // FLOAT
DataTypes.DOUBLE          // DOUBLE
DataTypes.DECIMAL(10, 2)  // DECIMAL(10, 2)

// Date/Time
DataTypes.DATE            // DATETIME
DataTypes.DATEONLY        // DATE
DataTypes.TIME            // TIME

// Boolean
DataTypes.BOOLEAN         // BOOLEAN

// JSON
DataTypes.JSON            // JSON
DataTypes.JSONB          // JSONB (PostgreSQL)
```

## 🔍 Basic Operations

### Create

```javascript
// Create single record
const user = await User.create({
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    age: 30
});

// Create multiple records
const users = await User.bulkCreate([
    {
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com'
    },
    {
        firstName: 'Bob',
        lastName: 'Johnson',
        email: 'bob@example.com'
    }
]);
```

### Read

```javascript
// Find all
const users = await User.findAll();

// Find by primary key
const user = await User.findByPk(1);

// Find one
const user = await User.findOne({
    where: { email: 'john@example.com' }
});

// Find with conditions
const users = await User.findAll({
    where: {
        age: {
            [Op.gt]: 25
        }
    }
});
```

### Update

```javascript
// Update single record
await User.update(
    { age: 31 },
    { where: { id: 1 } }
);

// Update and return
const user = await User.findByPk(1);
user.age = 31;
await user.save();
```

### Delete

```javascript
// Delete single record
await User.destroy({
    where: { id: 1 }
});

// Delete multiple
await User.destroy({
    where: {
        age: {
            [Op.lt]: 18
        }
    }
});
```

## 🔗 Associations

### One-to-Many

```javascript
// User has many Posts
User.hasMany(Post, { foreignKey: 'userId' });
Post.belongsTo(User, { foreignKey: 'userId' });
```

### Many-to-Many

```javascript
// User belongs to many Roles
User.belongsToMany(Role, { through: 'UserRoles' });
Role.belongsToMany(User, { through: 'UserRoles' });
```

### One-to-One

```javascript
// User has one Profile
User.hasOne(Profile, { foreignKey: 'userId' });
Profile.belongsTo(User, { foreignKey: 'userId' });
```

## 🎯 Best Practices

1. **Use async/await** for database operations
2. **Define models** before associations
3. **Use transactions** for multiple operations
4. **Handle errors** properly
5. **Use migrations** for schema changes
6. **Validate data** at model level

---

**Next**: Learn about [Models & Associations](./MODELS-ASSOCIATIONS.md)

