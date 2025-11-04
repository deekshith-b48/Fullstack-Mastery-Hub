# TypeORM Query Builder

## 📚 Overview

TypeORM Query Builder provides a powerful way to build complex SQL queries using a fluent API.

## 🔍 Basic Queries

### Select

```typescript
const users = await userRepository
    .createQueryBuilder('user')
    .where('user.age > :age', { age: 25 })
    .getMany();

// Select specific columns
const users = await userRepository
    .createQueryBuilder('user')
    .select(['user.id', 'user.name', 'user.email'])
    .getMany();
```

### Joins

```typescript
// Inner join
const users = await userRepository
    .createQueryBuilder('user')
    .innerJoin('user.posts', 'post')
    .where('post.published = :published', { published: true })
    .getMany();

// Left join
const users = await userRepository
    .createQueryBuilder('user')
    .leftJoinAndSelect('user.posts', 'post')
    .getMany();
```

### Conditions

```typescript
const users = await userRepository
    .createQueryBuilder('user')
    .where('user.age > :age', { age: 25 })
    .andWhere('user.department = :dept', { dept: 'IT' })
    .orWhere('user.salary > :salary', { salary: 100000 })
    .getMany();
```

### Ordering and Pagination

```typescript
const users = await userRepository
    .createQueryBuilder('user')
    .orderBy('user.salary', 'DESC')
    .addOrderBy('user.name', 'ASC')
    .skip(20)
    .take(10)
    .getMany();
```

### Aggregations

```typescript
const result = await userRepository
    .createQueryBuilder('user')
    .select('user.department', 'department')
    .addSelect('AVG(user.salary)', 'avgSalary')
    .addSelect('COUNT(user.id)', 'count')
    .groupBy('user.department')
    .getRawMany();
```

## 🎯 Best Practices

1. **Use query builder** for complex queries
2. **Parameterize queries** to prevent SQL injection
3. **Use joins** efficiently
4. **Optimize queries** with proper conditions
5. **Monitor query performance**

---

**Next**: Learn about [Transactions](./TRANSACTIONS.md)

