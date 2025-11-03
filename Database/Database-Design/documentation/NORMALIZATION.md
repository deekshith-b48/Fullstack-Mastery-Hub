# Database Normalization

## 📚 Overview

Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

## 🎯 Normal Forms

### First Normal Form (1NF)

**Rules**:
- Each column contains atomic values
- No repeating groups
- Each row is unique

```sql
-- ❌ Violates 1NF
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  phone_numbers VARCHAR(255) -- "555-1234, 555-5678"
);

-- ✅ 1NF Compliant
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE user_phones (
  id INT PRIMARY KEY,
  user_id INT,
  phone_number VARCHAR(20),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Second Normal Form (2NF)

**Rules**:
- Must be in 1NF
- All non-key attributes fully dependent on primary key

```sql
-- ❌ Violates 2NF
CREATE TABLE orders (
  order_id INT,
  product_id INT,
  product_name VARCHAR(255), -- Depends on product_id, not order_id
  quantity INT,
  PRIMARY KEY (order_id, product_id)
);

-- ✅ 2NF Compliant
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  user_id INT,
  order_date DATE
);

CREATE TABLE order_items (
  order_id INT,
  product_id INT,
  quantity INT,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(255),
  price DECIMAL(10, 2)
);
```

### Third Normal Form (3NF)

**Rules**:
- Must be in 2NF
- No transitive dependencies (non-key attributes depend only on primary key)

```sql
-- ❌ Violates 3NF
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  name VARCHAR(255),
  department_id INT,
  department_name VARCHAR(255), -- Depends on department_id
  department_location VARCHAR(255) -- Depends on department_id
);

-- ✅ 3NF Compliant
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  name VARCHAR(255),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(255),
  department_location VARCHAR(255)
);
```

### Boyce-Codd Normal Form (BCNF)

**Rules**:
- Must be in 3NF
- Every determinant is a candidate key

```sql
-- Example scenario
-- Student, Course, Instructor
-- Where Instructor determines Course

-- ✅ BCNF Compliant
CREATE TABLE course_instructors (
  course_id INT,
  instructor_id INT,
  PRIMARY KEY (course_id, instructor_id)
);

CREATE TABLE student_courses (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id)
);
```

## 🔄 Denormalization

Sometimes, denormalization is needed for performance:

```sql
-- Denormalized for read performance
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  user_id INT,
  user_name VARCHAR(255), -- Denormalized from users table
  user_email VARCHAR(255), -- Denormalized from users table
  total DECIMAL(10, 2)
);

-- Trade-off: Faster reads, but must update in multiple places
```

## ✅ Benefits of Normalization

1. **Reduced Redundancy**: No duplicate data
2. **Data Integrity**: Easier to maintain consistency
3. **Easier Updates**: Update in one place
4. **Storage Efficiency**: Less storage space

## ⚠️ When to Denormalize

- Read-heavy workloads
- Reporting/analytics tables
- Real-time requirements
- Complex joins causing performance issues

---

**Next**: Learn about [ER Diagrams](./ER-DIAGRAMS.md)

