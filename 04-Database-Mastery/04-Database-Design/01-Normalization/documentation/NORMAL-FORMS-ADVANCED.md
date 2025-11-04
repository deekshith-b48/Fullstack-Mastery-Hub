# Advanced Normal Forms

## 📚 Overview

Beyond 3NF, there are additional normal forms that address more complex dependency issues. This guide covers 4NF, 5NF, and domain-key normal form.

## 📊 Fourth Normal Form (4NF)

### Rules

1. Must be in BCNF
2. No multi-valued dependencies

### Example

```sql
-- ❌ Before 4NF (Multi-valued dependency)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    skills VARCHAR(255),  -- Multiple values
    languages VARCHAR(255)  -- Multiple values
);

-- ✅ After 4NF (Separate tables)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employee_skills (
    employee_id INT,
    skill VARCHAR(100),
    PRIMARY KEY (employee_id, skill),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE employee_languages (
    employee_id INT,
    language VARCHAR(100),
    PRIMARY KEY (employee_id, language),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
```

## 📊 Fifth Normal Form (5NF)

### Rules

1. Must be in 4NF
2. No join dependencies

### Use Cases

- Complex relationships
- Rarely needed in practice
- Mostly theoretical

## 🎯 Domain-Key Normal Form (DKNF)

### Concept

- Every constraint is a logical consequence of domain and key constraints
- Ultimate normalization form
- Difficult to achieve in practice

## 🎯 When to Stop Normalizing

1. **Performance considerations**: Too much normalization can hurt performance
2. **Complexity**: Higher normal forms increase complexity
3. **Practical needs**: Most applications stop at 3NF
4. **Business requirements**: Some redundancy may be acceptable

## 🎯 Best Practices

1. **Normalize to 3NF** for most cases
2. **Consider 4NF** for multi-valued attributes
3. **Avoid over-normalization**
4. **Balance** normalization with performance
5. **Document** normalization decisions

---

**Next**: Continue learning about normalization and database design principles.

