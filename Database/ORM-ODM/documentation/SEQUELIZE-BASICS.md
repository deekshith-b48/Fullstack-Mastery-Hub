# Sequelize - ORM Basics

## 📚 Overview

Sequelize is a promise-based Node.js ORM for PostgreSQL, MySQL, MariaDB, SQLite, and SQL Server.

## 🚀 Installation

```bash
npm install sequelize
npm install pg pg-hstore  # PostgreSQL
npm install mysql2         # MySQL
npm install sqlite3        # SQLite
```

## 🎯 Setup

```javascript
const { Sequelize } = require('sequelize');

// Connection
const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: 'postgres', // or 'mysql', 'sqlite'
  logging: console.log
});

// Test connection
async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log('Connection established');
  } catch (error) {
    console.error('Unable to connect:', error);
  }
}
```

## 🧩 Models

### Define Model

```javascript
const { DataTypes } = require('sequelize');

const User = sequelize.define('User', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true
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
  timestamps: true // Adds createdAt, updatedAt
});
```

### Create Tables

```javascript
// Sync models
await User.sync(); // Create if doesn't exist
await User.sync({ force: true }); // Drop and recreate
await User.sync({ alter: true }); // Alter to match model
```

## 📝 CRUD Operations

### Create

```javascript
// Create single
const user = await User.create({
  name: 'John Doe',
  email: 'john@example.com',
  age: 30
});

// Create multiple
const users = await User.bulkCreate([
  { name: 'Jane', email: 'jane@example.com' },
  { name: 'Bob', email: 'bob@example.com' }
]);
```

### Read

```javascript
// Find all
const users = await User.findAll();

// Find by ID
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
  },
  order: [['name', 'ASC']],
  limit: 10
});
```

### Update

```javascript
// Update
await User.update(
  { age: 31 },
  { where: { id: 1 } }
);

// Update instance
const user = await User.findByPk(1);
user.age = 31;
await user.save();
```

### Delete

```javascript
// Delete
await User.destroy({
  where: { id: 1 }
});

// Delete instance
const user = await User.findByPk(1);
await user.destroy();
```

## 🔗 Associations

### One-to-Many

```javascript
// User has many Orders
User.hasMany(Order, {
  foreignKey: 'userId',
  as: 'orders'
});

Order.belongsTo(User, {
  foreignKey: 'userId',
  as: 'user'
});

// Usage
const user = await User.findByPk(1, {
  include: [{ model: Order, as: 'orders' }]
});
```

### Many-to-Many

```javascript
// Users and Products
User.belongsToMany(Product, {
  through: 'UserProducts',
  foreignKey: 'userId',
  as: 'products'
});

Product.belongsToMany(User, {
  through: 'UserProducts',
  foreignKey: 'productId',
  as: 'users'
});
```

---

**Next**: Learn about [Mongoose](./MONGOOSE-BASICS.md)

