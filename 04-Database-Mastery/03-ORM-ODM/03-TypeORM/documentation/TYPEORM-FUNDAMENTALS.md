# TypeORM Fundamentals

## 📚 Overview

TypeORM is an ORM for TypeScript and JavaScript (ES7+) that supports Active Record and Data Mapper patterns. It works with MySQL, PostgreSQL, MariaDB, SQLite, SQL Server, and MongoDB.

## 🎯 What is TypeORM?

TypeORM is a powerful ORM that can run in Node.js, Browser, Cordova, PhoneGap, Ionic, React Native, and Electron platforms and can be used with TypeScript and JavaScript.

### Key Features

- **TypeScript Support**: Full TypeScript support
- **Active Record & Data Mapper**: Both patterns supported
- **Relations**: Easy relationship management
- **Migrations**: Database version control
- **Eager & Lazy Relations**: Flexible loading
- **Transactions**: Transaction support
- **Multiple Databases**: Support for many databases

## 🚀 Installation

### Install TypeORM

```bash
# Install TypeORM
npm install typeorm

# Install database driver
npm install pg                    # PostgreSQL
npm install mysql2                # MySQL
npm install sqlite3               # SQLite
npm install mssql                 # SQL Server
npm install mongodb                # MongoDB

# Install reflect-metadata
npm install reflect-metadata
```

## 🔧 Setup

### Data Source Configuration

```typescript
// data-source.ts
import { DataSource } from 'typeorm';

export const AppDataSource = new DataSource({
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'password',
    database: 'myapp',
    entities: [__dirname + '/**/*.entity{.ts,.js}'],
    synchronize: false,  // Use migrations in production
    logging: true
});

// Initialize
AppDataSource.initialize()
    .then(() => console.log('Data Source initialized'))
    .catch((error) => console.error('Error:', error));
```

### TypeScript Configuration

```json
// tsconfig.json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  }
}
```

## 📊 Defining Entities

### Basic Entity

```typescript
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('users')
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    firstName: string;

    @Column()
    lastName: string;

    @Column({ unique: true })
    email: string;

    @Column({ nullable: true })
    age: number;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    createdAt: Date;
}
```

### Column Types

```typescript
@Column('varchar', { length: 100 })
@Column('int')
@Column('float')
@Column('decimal', { precision: 10, scale: 2 })
@Column('boolean')
@Column('date')
@Column('timestamp')
@Column('json')
@Column('text')
```

## 🔍 Basic Operations

### Create

```typescript
// Active Record pattern
const user = new User();
user.firstName = 'John';
user.lastName = 'Doe';
user.email = 'john@example.com';
await user.save();

// Repository pattern
const userRepository = AppDataSource.getRepository(User);
const user = userRepository.create({
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com'
});
await userRepository.save(user);
```

### Read

```typescript
// Find all
const users = await userRepository.find();

// Find by ID
const user = await userRepository.findOneBy({ id: 1 });

// Find with conditions
const users = await userRepository.findBy({ age: MoreThan(25) });

// Find one
const user = await userRepository.findOne({
    where: { email: 'john@example.com' }
});
```

### Update

```typescript
// Update
await userRepository.update(1, { age: 31 });

// Save (Active Record)
const user = await userRepository.findOneBy({ id: 1 });
user.age = 31;
await user.save();
```

### Delete

```typescript
// Delete
await userRepository.delete(1);

// Remove
const user = await userRepository.findOneBy({ id: 1 });
await userRepository.remove(user);
```

## 🎯 Best Practices

1. **Use TypeScript** for type safety
2. **Define entities** clearly
3. **Use migrations** for schema changes
4. **Handle errors** properly
5. **Use transactions** for multiple operations

---

**Next**: Learn about [Entities & Relations](./ENTITIES-RELATIONS.md)

