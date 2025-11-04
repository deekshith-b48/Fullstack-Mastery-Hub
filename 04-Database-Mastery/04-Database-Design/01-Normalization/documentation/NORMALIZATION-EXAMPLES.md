# Normalization Examples

## 📚 Overview

Practical examples of database normalization from 1NF through 3NF with real-world scenarios.

## 📊 Example 1: E-Commerce Orders

### Unnormalized

```sql
CREATE TABLE orders (
    order_id INT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address VARCHAR(255),
    product1_name VARCHAR(100),
    product1_price DECIMAL(10, 2),
    product2_name VARCHAR(100),
    product2_price DECIMAL(10, 2),
    order_date DATE
);
```

### 1NF (First Normal Form)

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_name)
);
```

### 2NF (Second Normal Form)

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    base_price DECIMAL(10, 2)
);
```

### 3NF (Third Normal Form)

```sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

CREATE TABLE addresses (
    id INT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    zip VARCHAR(10)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    base_price DECIMAL(10, 2)
);
```

## 📊 Example 2: Employee Management

### Unnormalized

```sql
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(100),
    department VARCHAR(100),
    department_location VARCHAR(100),
    manager_name VARCHAR(100),
    salary DECIMAL(10, 2),
    skills VARCHAR(255)  -- "Java, Python, SQL"
);
```

### Normalized (3NF)

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE employee_skills (
    emp_id INT,
    skill VARCHAR(100),
    PRIMARY KEY (emp_id, skill),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
```

## 🎯 Benefits Demonstrated

1. **Reduced Redundancy**: Customer information stored once
2. **Data Integrity**: Foreign keys ensure consistency
3. **Easier Updates**: Change address in one place
4. **Flexible Queries**: Join tables as needed
5. **Scalability**: Easy to add new attributes

---

**Next**: Continue learning about normalization.

