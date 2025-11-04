# Cassandra Fundamentals

## 📚 Overview

Apache Cassandra is a distributed NoSQL database designed to handle large amounts of data across many commodity servers, providing high availability with no single point of failure.

## 🎯 What is Cassandra?

Cassandra is a wide-column store database that manages very large amounts of structured data across many commodity servers. It provides high availability and linear scalability.

### Key Features

- **Distributed**: No single point of failure
- **Scalable**: Linear scalability
- **High Performance**: Fast writes and reads
- **Tunable Consistency**: Choose consistency level
- **Flexible Schema**: Column-family data model
- **Multi-Datacenter**: Built-in support

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Add Cassandra repository
echo "deb https://downloads.apache.org/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

# Import GPG key
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -

# Install Cassandra
sudo apt update
sudo apt install cassandra

# Start Cassandra
sudo systemctl start cassandra
sudo systemctl enable cassandra
```

### macOS

```bash
# Using Homebrew
brew install cassandra

# Start Cassandra
brew services start cassandra
```

## 🔧 CQL Shell

### Connect to Cassandra

```bash
# Connect to local Cassandra
cqlsh

# Connect to remote Cassandra
cqlsh hostname 9042

# Connect with authentication
cqlsh -u username -p password
```

### Basic Commands

```sql
-- Show version
DESCRIBE CLUSTER;

-- Show keyspaces
DESCRIBE KEYSPACES;

-- Use keyspace
USE myapp;

-- Show tables
DESCRIBE TABLES;
```

## 📊 Data Model

### Keyspace

```sql
-- Create keyspace
CREATE KEYSPACE myapp
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

-- Use keyspace
USE myapp;
```

### Table (Column Family)

```sql
-- Create table
CREATE TABLE employees (
    id UUID PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    salary INT,
    department TEXT,
    hire_date TIMESTAMP
);
```

## 🏗️ Basic Operations

### Insert Data

```sql
-- Insert single row
INSERT INTO employees (id, first_name, last_name, email, salary)
VALUES (uuid(), 'John', 'Doe', 'john@example.com', 75000);

-- Insert with timestamp
INSERT INTO employees (id, first_name, last_name, email, hire_date)
VALUES (uuid(), 'Jane', 'Smith', 'jane@example.com', toTimestamp(now()));
```

### Query Data

```sql
-- Select all
SELECT * FROM employees;

-- Select with WHERE (must include partition key)
SELECT * FROM employees WHERE id = uuid();

-- Select specific columns
SELECT first_name, last_name, email FROM employees WHERE id = uuid();
```

### Update Data

```sql
-- Update row
UPDATE employees
SET salary = 80000
WHERE id = uuid();
```

### Delete Data

```sql
-- Delete row
DELETE FROM employees WHERE id = uuid();

-- Delete specific column
DELETE salary FROM employees WHERE id = uuid();
```

## 🔍 Data Types

### Basic Types

- **TEXT, VARCHAR**: Text strings
- **INT, BIGINT**: Integers
- **FLOAT, DOUBLE**: Floating-point
- **BOOLEAN**: Boolean
- **UUID**: Universally unique identifier
- **TIMESTAMP**: Date and time
- **DATE**: Date
- **TIME**: Time

### Collection Types

```sql
-- List
CREATE TABLE users (
    id UUID PRIMARY KEY,
    hobbies LIST<TEXT>
);

-- Set
CREATE TABLE users (
    id UUID PRIMARY KEY,
    tags SET<TEXT>
);

-- Map
CREATE TABLE users (
    id UUID PRIMARY KEY,
    attributes MAP<TEXT, TEXT>
);
```

## 🎯 Best Practices

1. **Design for queries** - Model data for access patterns
2. **Choose appropriate partition key**
3. **Use appropriate consistency level**
4. **Monitor cluster health**
5. **Regular backups**
6. **Plan for scalability**

---

**Next**: Learn about [Data Modeling](./DATA-MODELING.md)

