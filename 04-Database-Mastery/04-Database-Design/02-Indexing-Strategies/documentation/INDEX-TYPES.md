# Database Index Types

## 📚 Overview

Indexes are data structures that improve the speed of data retrieval operations. This guide covers different index types and their use cases.

## 🎯 Index Types

### B-Tree Index

**Most common index type**

```sql
-- Standard B-tree index
CREATE INDEX idx_email ON users(email);

-- Composite index
CREATE INDEX idx_name_age ON users(last_name, first_name, age);
```

**Use Cases:**
- Equality and range queries
- Sorting operations
- Most common use cases

### Hash Index

```sql
-- Hash index (PostgreSQL)
CREATE INDEX idx_user_hash ON users USING HASH(email);
```

**Use Cases:**
- Equality lookups only
- Fast exact matches
- Not suitable for range queries

### Bitmap Index

```sql
-- Bitmap index (Oracle, some databases)
CREATE BITMAP INDEX idx_status ON orders(status);
```

**Use Cases:**
- Low cardinality columns
- Boolean or enum types
- Data warehousing

### Full-Text Index

```sql
-- Full-text index (PostgreSQL)
CREATE INDEX idx_content_fts ON posts USING GIN(to_tsvector('english', content));
```

**Use Cases:**
- Text search
- Content search
- Document search

### Partial Index

```sql
-- Index only subset of rows
CREATE INDEX idx_active_users ON users(email) WHERE active = true;
```

**Use Cases:**
- Filtered queries
- Conditional indexing
- Reduce index size

## 🎯 Best Practices

1. **Index frequently queried columns**
2. **Use composite indexes** for multiple column queries
3. **Consider index selectivity**
4. **Monitor index usage**
5. **Balance** read and write performance

---

**Next**: Learn about [Index Selection](./INDEX-SELECTION.md)

