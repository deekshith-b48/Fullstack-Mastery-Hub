# TypeORM Performance Optimization

## 📚 Overview

Optimizing TypeORM performance involves efficient queries, proper indexing, connection management, and caching strategies.

## 🔍 Query Optimization

### Use Select

```typescript
// Select only needed columns
const users = await userRepository.find({
    select: ['id', 'name', 'email']
});
```

### Use Relations Efficiently

```typescript
// Load relations only when needed
const users = await userRepository.find({
    relations: ['posts']
});

// Use query builder for complex joins
const users = await userRepository
    .createQueryBuilder('user')
    .leftJoinAndSelect('user.posts', 'post')
    .getMany();
```

### Use Caching

```typescript
// Enable caching
const users = await userRepository.find({
    cache: true,
    cacheId: 'users_list',
    cacheDuration: 60000  // 60 seconds
});
```

## 📊 Indexing

```typescript
// Create index in entity
@Entity()
@Index(['email'])
@Index(['department', 'salary'])
export class User {
    @Column({ unique: true })
    email: string;
}
```

## 🔗 Connection Pooling

```typescript
export const AppDataSource = new DataSource({
    // ... other options
    extra: {
        max: 10,  // Maximum pool size
        min: 2,   // Minimum pool size
    }
});
```

## 🎯 Best Practices

1. **Create indexes** on frequently queried fields
2. **Use select** to limit fetched data
3. **Enable caching** for read-heavy operations
4. **Use connection pooling**
5. **Monitor query performance**
6. **Use query builder** for complex queries

---

**Next**: Learn about [Multiple Databases](./MULTIPLE-DATABASES.md)

