# Entity-Relationship Diagrams (ERD)

## 📚 Overview

ERDs visually represent database structure showing entities, attributes, and relationships.

## 🎯 Core Concepts

### Entities

Represents a real-world object or concept.

```
┌─────────────┐
│    User     │
├─────────────┤
│ id (PK)     │
│ name        │
│ email       │
│ created_at  │
└─────────────┘
```

### Attributes

Properties of entities.

- **Key Attribute**: Unique identifier (Primary Key)
- **Simple Attribute**: Cannot be divided
- **Composite Attribute**: Can be divided
- **Multivalued Attribute**: Multiple values
- **Derived Attribute**: Calculated from other attributes

### Relationships

Connections between entities.

#### One-to-One (1:1)

```
User ────< 1:1 >─── Profile
```

```sql
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE profiles (
  user_id INT PRIMARY KEY,
  bio TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

#### One-to-Many (1:N)

```
User ────< 1:N >─── Order
```

```sql
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE orders (
  id INT PRIMARY KEY,
  user_id INT,
  total DECIMAL(10, 2),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

#### Many-to-Many (M:N)

```
User ────< M:N >─── Product
```

```sql
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

-- Junction table
CREATE TABLE user_products (
  user_id INT,
  product_id INT,
  quantity INT,
  PRIMARY KEY (user_id, product_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
```

## 📐 ERD Notation

### Crow's Foot Notation

```
User ────< ──── Order
     (one)    (many)
```

### Chen Notation

```
┌─────┐         ┌─────┐
│User │─────────│Order│
└─────┘         └─────┘
  1                N
```

## 🎨 Common Patterns

### E-Commerce Example

```
┌─────────┐
│  User   │
└────┬────┘
     │ 1
     │
     │ N
┌────▼────┐      ┌──────────┐
│  Order  │──N───│ OrderItem│
└────┬────┘      └────┬──────┘
     │ 1               │ N
     │                 │
     │                 │ 1
┌────▼────┐      ┌─────▼─────┐
│ Product │      │  Category │
└─────────┘      └───────────┘
```

### Social Media Example

```
┌─────────┐
│  User   │
└────┬────┘
     │
     │ M         N
     │────────────
┌────▼────────────┐
│  Friendship     │
│  (Junction)     │
└─────────────────┘

┌─────────┐      ┌──────────┐
│  User   │──1───│   Post   │
└─────────┘      └────┬─────┘
                      │ N
                      │
                      │ 1
                ┌─────▼─────┐
                │  Comment  │
                └───────────┘
```

## 🛠️ Tools for ERD

- **Lucidchart**: Web-based diagramming
- **draw.io**: Free diagramming tool
- **dbdiagram.io**: Database diagramming
- **pgAdmin**: PostgreSQL tool with ERD
- **MySQL Workbench**: Built-in ERD designer

---

**Next**: Learn about [Indexing Strategies](./../Performance/documentation/INDEXING-STRATEGIES.md)

