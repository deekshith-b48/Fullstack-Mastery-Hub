# Sequelize Migrations & Seeding

## 📚 Overview

Migrations manage database schema changes over time, while seeding populates the database with initial data.

## 🔧 Migration Setup

### Initialize Sequelize

```bash
# Install Sequelize CLI
npm install --save-dev sequelize-cli

# Initialize Sequelize
npx sequelize-cli init
```

### Migration Structure

```
migrations/
  └── 20240101000000-create-users.js
```

## 📝 Creating Migrations

### Create Migration

```bash
# Create migration file
npx sequelize-cli migration:generate --name create-users

# Or
npx sequelize migration:generate --name create-users
```

### Migration File

```javascript
// migrations/20240101000000-create-users.js
'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('users', {
            id: {
                type: Sequelize.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            firstName: {
                type: Sequelize.STRING,
                allowNull: false
            },
            lastName: {
                type: Sequelize.STRING,
                allowNull: false
            },
            email: {
                type: Sequelize.STRING,
                allowNull: false,
                unique: true
            },
            createdAt: {
                type: Sequelize.DATE,
                allowNull: false
            },
            updatedAt: {
                type: Sequelize.DATE,
                allowNull: false
            }
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('users');
    }
};
```

## 🔄 Running Migrations

```bash
# Run all pending migrations
npx sequelize-cli db:migrate

# Undo last migration
npx sequelize-cli db:migrate:undo

# Undo all migrations
npx sequelize-cli db:migrate:undo:all

# Migrate to specific version
npx sequelize-cli db:migrate:undo:all --to 20240101000000
```

## 🌱 Seeding

### Create Seed

```bash
# Create seed file
npx sequelize-cli seed:generate --name demo-users
```

### Seed File

```javascript
// seeders/20240101000000-demo-users.js
'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.bulkInsert('users', [
            {
                firstName: 'John',
                lastName: 'Doe',
                email: 'john@example.com',
                createdAt: new Date(),
                updatedAt: new Date()
            },
            {
                firstName: 'Jane',
                lastName: 'Smith',
                email: 'jane@example.com',
                createdAt: new Date(),
                updatedAt: new Date()
            }
        ]);
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.bulkDelete('users', null, {});
    }
};
```

### Run Seeds

```bash
# Run all seeders
npx sequelize-cli db:seed:all

# Undo last seed
npx sequelize-cli db:seed:undo

# Undo all seeds
npx sequelize-cli db:seed:undo:all
```

## 🎯 Best Practices

1. **Version control migrations**
2. **Test migrations** before production
3. **Keep migrations reversible**
4. **Use seeds** for test data
5. **Document schema changes**

---

**Next**: Learn about [Queries & Transactions](./QUERIES-TRANSACTIONS.md)

