# Prisma Schema & Models

## 📚 Overview

Prisma schema defines the database structure and generates type-safe client code. This guide covers schema definition and model relationships.

## 📊 Model Definition

### Basic Model

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?
  age       Int?
  active    Boolean  @default(true)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

### Field Types

```prisma
model Example {
  id          Int       @id @default(autoincrement())
  stringField String
  intField    Int
  floatField  Float
  boolField   Boolean
  dateField   DateTime
  jsonField   Json
  bytesField  Bytes
}
```

### Field Attributes

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?  // Optional
  age       Int      @default(18)
  active    Boolean  @default(true)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

## 🔗 Relations

### One-to-Many

```prisma
model User {
  id    Int    @id @default(autoincrement())
  posts Post[]
}

model Post {
  id       Int  @id @default(autoincrement())
  authorId Int
  author   User @relation(fields: [authorId], references: [id])
}
```

### Many-to-Many

```prisma
model User {
  id    Int    @id @default(autoincrement())
  roles Role[]
}

model Role {
  id    Int    @id @default(autoincrement())
  users User[]
}

// Or with explicit join table
model User {
  id         Int            @id @default(autoincrement())
  userRoles  UserRole[]
}

model Role {
  id        Int            @id @default(autoincrement())
  userRoles UserRole[]
}

model UserRole {
  userId Int
  roleId Int
  user   User @relation(fields: [userId], references: [id])
  role   Role @relation(fields: [roleId], references: [id])

  @@id([userId, roleId])
}
```

### One-to-One

```prisma
model User {
  id      Int     @id @default(autoincrement())
  profile Profile?
}

model Profile {
  id     Int    @id @default(autoincrement())
  userId Int    @unique
  user   User   @relation(fields: [userId], references: [id])
}
```

## 🔍 Queries with Relations

```typescript
// Include relations
const user = await prisma.user.findUnique({
    where: { id: 1 },
    include: {
        posts: true
    }
});

// Nested include
const user = await prisma.user.findUnique({
    where: { id: 1 },
    include: {
        posts: {
            include: {
                comments: true
            }
        }
    }
});
```

## 🎯 Best Practices

1. **Define models** clearly
2. **Use appropriate field types**
3. **Define relations** explicitly
4. **Use unique constraints** where needed
5. **Document schema** with comments

---

**Next**: Learn about [Migrations](./MIGRATIONS.md)

