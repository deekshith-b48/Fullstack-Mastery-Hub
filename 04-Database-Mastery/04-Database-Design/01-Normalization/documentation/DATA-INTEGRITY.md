# Data Integrity and Constraints

## 📚 Overview

Data integrity ensures accuracy and consistency of data. This guide covers integrity constraints and enforcement mechanisms.

## 🔒 Integrity Constraints

### Primary Key

```sql
-- Ensures uniqueness and non-null
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);
```

### Foreign Key

```sql
-- Referential integrity
CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cascading actions
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);
```

### Unique Constraint

```sql
-- Ensure uniqueness
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    username VARCHAR(100) UNIQUE
);

-- Composite unique constraint
CREATE TABLE user_roles (
    user_id INT,
    role_id INT,
    UNIQUE (user_id, role_id)
);
```

### Check Constraint

```sql
-- Domain integrity
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    status VARCHAR(20) CHECK (status IN ('active', 'inactive', 'archived'))
);
```

### Not Null Constraint

```sql
-- Ensure required fields
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

## 🔍 Data Validation

### Application-Level Validation

```python
# Validate before database insert
def create_user(name, email, age):
    # Validate email format
    if not re.match(r'^[\w\.-]+@[\w\.-]+\.\w+$', email):
        raise ValueError('Invalid email format')
    
    # Validate age
    if age < 0 or age > 120:
        raise ValueError('Invalid age')
    
    # Insert into database
    db.insert_user(name, email, age)
```

### Database-Level Validation

```sql
-- Use CHECK constraints
ALTER TABLE users 
ADD CONSTRAINT check_age 
CHECK (age >= 0 AND age <= 120);

-- Use triggers
CREATE TRIGGER validate_email
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email';
    END IF;
END;
```

## 🎯 Best Practices

1. **Use constraints** at database level
2. **Validate** at application level too
3. **Document** all constraints
4. **Test** constraint enforcement
5. **Monitor** constraint violations

---

**Next**: Continue learning about data integrity.

