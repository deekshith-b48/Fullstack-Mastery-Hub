# Index Selection Strategies

## 📚 Overview

Choosing the right indexes is crucial for database performance. This guide covers strategies for selecting appropriate indexes.

## 🔍 Selection Criteria

### High Selectivity

```sql
-- High selectivity (many unique values)
CREATE INDEX idx_email ON users(email);  -- ✅ Good

-- Low selectivity (few unique values)
CREATE INDEX idx_gender ON users(gender);  -- ❌ May not help
```

### Query Patterns

```sql
-- Index columns used in WHERE clause
SELECT * FROM users WHERE email = 'john@example.com';
CREATE INDEX idx_email ON users(email);

-- Index columns used in JOIN
SELECT * FROM users u JOIN orders o ON u.id = o.user_id;
CREATE INDEX idx_orders_user_id ON orders(user_id);
```

### Sort Operations

```sql
-- Index columns used in ORDER BY
SELECT * FROM users ORDER BY created_at DESC;
CREATE INDEX idx_created_at ON users(created_at DESC);
```

## 📊 Composite Index Order

```sql
-- Order matters: equality first, then range, then sort
-- Query: WHERE status = 'active' AND age > 25 ORDER BY name
CREATE INDEX idx_status_age_name ON users(status, age, name);
```

## 🎯 Best Practices

1. **Analyze query patterns** before indexing
2. **Monitor index usage** and remove unused indexes
3. **Consider write performance** impact
4. **Test index effectiveness**
5. **Document index decisions**

---

**Next**: Learn about [Transaction Fundamentals](./../03-Transactions/documentation/TRANSACTION-FUNDAMENTALS.md)

