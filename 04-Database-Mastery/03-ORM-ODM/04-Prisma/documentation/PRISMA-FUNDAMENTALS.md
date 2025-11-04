# Prisma Fundamentals

## 📚 Overview

Prisma is a next-generation ORM that provides type-safe database access, automatic migrations, and a powerful query API for TypeScript and Node.js.

## 🎯 What is Prisma?

Prisma is a modern database toolkit that makes database access easy with type safety, auto-completion, and compile-time checks. It supports PostgreSQL, MySQL, SQLite, SQL Server, and MongoDB.

### Key Features

- **Type Safety**: Full TypeScript type safety
- **Auto-Generated Client**: Type-safe database client
- **Migrations**: Automatic migration generation
- **Prisma Studio**: Visual database browser
- **Query Builder**: Powerful query API
- **Multi-Database**: Support for multiple databases

## 🚀 Installation

### Install Prisma

```bash
# Install Prisma CLI
npm install -D prisma

# Install Prisma Client
npm install @prisma/client

# Initialize Prisma
npx prisma init
```

## 🔧 Setup

### Prisma Schema

```prisma
// prisma/schema.prisma
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
  updatedAt DateTime @updatedAt
}
```

### Environment Variables

```bash
# .env
DATABASE_URL="postgresql://user:password@localhost:5432/myapp?schema=public"
```

### Generate Client

```bash
# Generate Prisma Client
npx prisma generate
```

### Client Usage

```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// Use client
async function main() {
    const users = await prisma.user.findMany();
}

main()
    .catch((e) => console.error(e))
    .finally(async () => await prisma.$disconnect());
```

## 🔍 Basic Operations

### Create

```typescript
// Create single record
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

```typescript
// Find all
const users = await prisma.user.findMany();

// Find unique
const user = await prisma.user.findUnique({
    where: { email: 'john@example.com' }
});

// Find first
const user = await prisma.user.findFirst({
    where: { name: { contains: 'John' } }
});
```

### Update

```typescript
// Update
const user = await prisma.user.update({
    where: { id: 1 },
    data: { name: 'Jane Doe' }
});

// Update many
await prisma.user.updateMany({
    where: { age: { lt: 18 } },
    data: { active: false }
});
```

### Delete

```typescript
// Delete
await prisma.user.delete({
    where: { id: 1 }
});

// Delete many
await prisma.user.deleteMany({
    where: { active: false }
});
```

## 🎯 Best Practices

1. **Use type-safe queries**
2. **Generate client** after schema changes
3. **Use migrations** for schema changes
4. **Handle errors** properly
5. **Disconnect client** when done

---

**Next**: Learn about [Schema & Models](./SCHEMA-MODELS.md)

