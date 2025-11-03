# Cassandra Basics

## 📚 Overview

Apache Cassandra is a distributed NoSQL database designed for high availability and scalability.

## 🚀 Key Concepts

### Keyspace

Equivalent to database in SQL.

```cql
CREATE KEYSPACE myapp
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

USE myapp;
```

### Column Family (Table)

```cql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email TEXT,
  name TEXT,
  age INT
);

-- With clustering
CREATE TABLE posts (
  user_id UUID,
  post_id UUID,
  title TEXT,
  content TEXT,
  created_at TIMESTAMP,
  PRIMARY KEY (user_id, created_at, post_id)
) WITH CLUSTERING ORDER BY (created_at DESC);
```

### Data Types

```cql
UUID, TEXT, VARCHAR, INT, BIGINT
BOOLEAN, FLOAT, DOUBLE, DECIMAL
TIMESTAMP, DATE, TIME
LIST<TEXT>, SET<INT>, MAP<TEXT, TEXT>
```

## 📝 Operations

```cql
-- Insert
INSERT INTO users (id, email, name, age)
VALUES (uuid(), 'john@example.com', 'John', 30);

-- Select
SELECT * FROM users WHERE id = ?;

-- Update
UPDATE users SET age = 31 WHERE id = ?;

-- Delete
DELETE FROM users WHERE id = ?;
```

## 🎯 Partitioning and Clustering

```cql
-- Partition key: user_id
-- Clustering keys: created_at, post_id
CREATE TABLE posts (
  user_id UUID,        -- Partition key
  created_at TIMESTAMP, -- Clustering key
  post_id UUID,        -- Clustering key
  title TEXT,
  PRIMARY KEY (user_id, created_at, post_id)
);

-- Can query by partition key
SELECT * FROM posts WHERE user_id = ?;

-- Can filter by clustering keys
SELECT * FROM posts 
WHERE user_id = ? 
  AND created_at > ? 
ORDER BY created_at DESC;
```

---

**Summary**: Cassandra excels at distributed, high-availability scenarios.

