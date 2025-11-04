# TypeORM Multiple Databases

## 📚 Overview

TypeORM supports working with multiple databases simultaneously, useful for microservices and multi-tenant applications.

## 🔧 Multiple Data Sources

### Setup

```typescript
// Primary database
export const PrimaryDataSource = new DataSource({
    type: 'postgres',
    name: 'primary',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'password',
    database: 'primary_db',
    entities: [User, Post]
});

// Secondary database
export const SecondaryDataSource = new DataSource({
    type: 'mysql',
    name: 'secondary',
    host: 'localhost',
    port: 3306,
    username: 'root',
    password: 'password',
    database: 'secondary_db',
    entities: [Log, Audit]
});
```

### Using Multiple Sources

```typescript
// Initialize both
await PrimaryDataSource.initialize();
await SecondaryDataSource.initialize();

// Use specific data source
const userRepository = PrimaryDataSource.getRepository(User);
const logRepository = SecondaryDataSource.getRepository(Log);
```

## 🎯 Best Practices

1. **Use separate data sources** for different databases
2. **Manage connections** properly
3. **Handle errors** from each source
4. **Monitor performance** of each database

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

