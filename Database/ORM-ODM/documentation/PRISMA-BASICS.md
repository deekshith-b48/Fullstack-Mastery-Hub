# Prisma - Next-Generation ORM

## 📚 Overview

Prisma is a modern ORM with type-safety, auto-generated queries, and excellent developer experience.

## 🚀 Installation

```bash
npm install prisma @prisma/client
npx prisma init
```

## ⚙️ Configuration

### Schema Definition

```prisma
// schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  published Boolean  @default(false)
  authorId  Int
  author    User     @relation(fields: [authorId], references: [id])
  createdAt DateTime @default(now())
}
```

### Generate Client

```bash
npx prisma generate
```

## 📝 CRUD Operations

### Create

```javascript
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// Create single
const user = await prisma.user.create({
  data: {
    email: 'john@example.com',
    name: 'John Doe'
  }
});

// Create with relation
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    content: 'Post content',
    author: {
      connect: { id: 1 }
    }
  }
});
```

### Read

```javascript
// Find all
const users = await prisma.user.findMany();

// Find unique
const user = await prisma.user.findUnique({
  where: { email: 'john@example.com' }
});

// Find first
const user = await prisma.user.findFirst({
  where: {
    age: { gt: 25 }
  }
});

// Include relations
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: { posts: true }
});
```

### Update

```javascript
// Update
const user = await prisma.user.update({
  where: { id: 1 },
  data: { name: 'John Smith' }
});

// Update many
await prisma.user.updateMany({
  where: { age: { lt: 18 } },
  data: { status: 'minor' }
});
```

### Delete

```javascript
// Delete
await prisma.user.delete({
  where: { id: 1 }
});

// Delete many
await prisma.user.deleteMany({
  where: { status: 'inactive' }
});
```

## 🔍 Advanced Queries

```javascript
// Filtering
const users = await prisma.user.findMany({
  where: {
    AND: [
      { age: { gte: 18 } },
      { status: 'active' }
    ]
  },
  orderBy: { name: 'asc' },
  take: 10,
  skip: 20
});

// Aggregation
const result = await prisma.user.aggregate({
  _count: { id: true },
  _avg: { age: true },
  _max: { age: true },
  _min: { age: true }
});
```

## 🔄 Migrations

```bash
# Create migration
npx prisma migrate dev --name add_user_table

# Apply migrations
npx prisma migrate deploy

# Reset database
npx prisma migrate reset
```

---

**Next**: Learn about [Backup & Recovery](./../Backup-Recovery/documentation/BACKUP-STRATEGIES.md)

