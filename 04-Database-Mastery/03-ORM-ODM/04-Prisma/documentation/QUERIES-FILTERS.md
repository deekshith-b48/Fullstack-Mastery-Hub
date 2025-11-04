# Prisma Queries & Filters

## 📚 Overview

Prisma provides a powerful query API with filtering, sorting, pagination, and relation inclusion capabilities.

## 🔍 Filtering

### Where Clauses

```typescript
// Equality
const users = await prisma.user.findMany({
    where: { email: 'john@example.com' }
});

// Comparison
const users = await prisma.user.findMany({
    where: {
        age: {
            gt: 25,   // Greater than
            gte: 25,  // Greater than or equal
            lt: 50,   // Less than
            lte: 50,  // Less than or equal
            not: 30   // Not equal
        }
    }
});

// In/NotIn
const users = await prisma.user.findMany({
    where: {
        email: {
            in: ['john@example.com', 'jane@example.com']
        }
    }
});

// Contains
const users = await prisma.user.findMany({
    where: {
        name: {
            contains: 'John',
            mode: 'insensitive'  // Case insensitive
        }
    }
});

// Logical operators
const users = await prisma.user.findMany({
    where: {
        OR: [
            { department: 'IT' },
            { salary: { gt: 100000 } }
        ],
        AND: [
            { age: { gte: 25 } },
            { active: true }
        ]
    }
});
```

### Sorting

```typescript
const users = await prisma.user.findMany({
    orderBy: [
        { salary: 'desc' },
        { name: 'asc' }
    ]
});
```

### Pagination

```typescript
// Limit and skip
const users = await prisma.user.findMany({
    skip: 20,
    take: 10
});

// Cursor-based pagination
const users = await prisma.user.findMany({
    cursor: { id: 10 },
    take: 10
});
```

## 🎯 Best Practices

1. **Use appropriate filters**
2. **Index filtered fields**
3. **Use pagination** for large datasets
4. **Optimize queries** with select
5. **Monitor query performance**

---

**Next**: Learn about [Transactions](./TRANSACTIONS-PRISMA.md)

