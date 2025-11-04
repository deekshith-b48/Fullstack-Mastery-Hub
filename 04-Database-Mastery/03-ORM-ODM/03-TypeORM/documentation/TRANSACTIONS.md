# TypeORM Transactions

## 📚 Overview

TypeORM supports transactions for atomic operations across multiple database operations.

## 🔄 Basic Transactions

### Query Runner

```typescript
const queryRunner = AppDataSource.createQueryRunner();

await queryRunner.connect();
await queryRunner.startTransaction();

try {
    await queryRunner.manager.save(user);
    await queryRunner.manager.save(post);
    await queryRunner.commitTransaction();
} catch (error) {
    await queryRunner.rollbackTransaction();
    throw error;
} finally {
    await queryRunner.release();
}
```

### Transaction Decorator

```typescript
@Transaction()
async createUserWithPost(userData: any, postData: any) {
    const user = await this.userRepository.save(userData);
    postData.userId = user.id;
    await this.postRepository.save(postData);
}
```

### Isolated Transaction

```typescript
await AppDataSource.transaction(async (manager) => {
    const user = await manager.save(User, userData);
    await manager.save(Post, { ...postData, userId: user.id });
});
```

## 🎯 Best Practices

1. **Use transactions** for multiple related operations
2. **Handle errors** and rollback properly
3. **Keep transactions short**
4. **Test transaction behavior** thoroughly

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

