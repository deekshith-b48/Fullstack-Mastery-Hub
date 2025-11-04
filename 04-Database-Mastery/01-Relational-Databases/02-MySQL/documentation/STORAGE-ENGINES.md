# MySQL Storage Engines

## 📚 Overview

MySQL supports multiple storage engines, each optimized for different use cases. This guide covers the major storage engines, their characteristics, and when to use each one.

## 🎯 What are Storage Engines?

Storage engines are components that handle the SQL operations for different table types. MySQL uses a pluggable storage engine architecture, allowing you to choose the best engine for each table.

## 🔧 InnoDB (Default)

### Characteristics

- **ACID Compliant**: Full transaction support
- **Foreign Keys**: Referential integrity
- **Row-Level Locking**: Better concurrency
- **Crash Recovery**: Automatic recovery
- **MVCC**: Multi-version concurrency control

### Usage

```sql
-- Create table with InnoDB
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

-- Or set as default
SET default_storage_engine = InnoDB;
```

### Configuration

```ini
# my.cnf
[mysqld]
default-storage-engine = InnoDB
innodb_buffer_pool_size = 4G
innodb_log_file_size = 512M
innodb_file_per_table = 1
innodb_flush_log_at_trx_commit = 1
```

### Best For

- Most applications (default choice)
- Tables requiring transactions
- Tables with foreign keys
- High concurrency applications
- Data integrity critical applications

## 📊 MyISAM

### Characteristics

- **Fast Reads**: Excellent for read-heavy workloads
- **Table-Level Locking**: Simpler but less concurrent
- **Full-Text Search**: Built-in full-text indexing
- **No Transactions**: No ACID compliance
- **Smaller Footprint**: Less overhead

### Usage

```sql
-- Create table with MyISAM
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FULLTEXT INDEX idx_message (log_message)
) ENGINE=MyISAM;
```

### Best For

- Read-heavy applications
- Log tables
- Data warehousing (read-only)
- Full-text search requirements
- Tables that don't need transactions

## 💾 Memory (HEAP)

### Characteristics

- **In-Memory Storage**: All data in RAM
- **Very Fast**: Fastest read/write operations
- **Temporary**: Data lost on restart
- **Hash Indexes**: Default index type
- **No Transactions**: No ACID support

### Usage

```sql
-- Create memory table
CREATE TABLE session_data (
    session_id VARCHAR(100) PRIMARY KEY,
    user_id INT,
    data TEXT,
    created_at TIMESTAMP
) ENGINE=MEMORY;

-- Or HEAP (alias)
CREATE TABLE temp_data (...) ENGINE=HEAP;
```

### Best For

- Temporary data
- Session storage
- Lookup tables
- Caching
- High-speed temporary processing

## 🔄 Archive

### Characteristics

- **Compressed Storage**: Automatic compression
- **Insert Only**: Only INSERT and SELECT allowed
- **No Updates/Deletes**: Data is immutable
- **Very Efficient**: Excellent compression ratios
- **Slow Queries**: Not optimized for frequent queries

### Usage

```sql
-- Create archive table
CREATE TABLE old_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_message TEXT,
    created_at TIMESTAMP
) ENGINE=ARCHIVE;
```

### Best For

- Historical data
- Log archives
- Audit trails
- Data that's written once and rarely queried

## 🔍 CSV

### Characteristics

- **CSV Format**: Data stored as CSV files
- **No Indexes**: No indexing support
- **Readable**: Can edit with text editor
- **Limited Features**: Basic operations only

### Usage

```sql
-- Create CSV table
CREATE TABLE csv_data (
    id INT,
    name VARCHAR(100),
    value DECIMAL(10, 2)
) ENGINE=CSV;
```

### Best For

- Data exchange
- Import/export operations
- Simple data storage

## 🔗 Federated

### Characteristics

- **Remote Tables**: Access tables on remote MySQL servers
- **No Local Storage**: No local data storage
- **Network Dependent**: Requires network connection
- **Limited Features**: Not all SQL operations supported

### Usage

```sql
-- Enable federated engine
-- Add to my.cnf: federated = 1

-- Create federated table
CREATE TABLE remote_employees (
    id INT,
    name VARCHAR(100)
) ENGINE=FEDERATED
CONNECTION='mysql://user:password@remote_host:3306/database/employees';
```

### Best For

- Distributed databases
- Data federation
- Remote data access

## 📈 Comparison

| Feature | InnoDB | MyISAM | Memory | Archive | CSV |
|---------|--------|--------|--------|---------|-----|
| Transactions | ✅ | ❌ | ❌ | ❌ | ❌ |
| Foreign Keys | ✅ | ❌ | ❌ | ❌ | ❌ |
| Row Locking | ✅ | ❌ | ✅ | ❌ | ❌ |
| Crash Recovery | ✅ | ⚠️ | ❌ | ✅ | ❌ |
| Full-Text Search | ✅ (5.6+) | ✅ | ❌ | ❌ | ❌ |
| Compression | ✅ | ❌ | ❌ | ✅ | ❌ |
| MVCC | ✅ | ❌ | ❌ | ❌ | ❌ |

## 🔧 Changing Storage Engines

### Convert Existing Table

```sql
-- Convert table to InnoDB
ALTER TABLE employees ENGINE=InnoDB;

-- Convert to MyISAM
ALTER TABLE logs ENGINE=MyISAM;

-- Check current engine
SHOW CREATE TABLE employees;
-- Or
SELECT ENGINE FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'myapp' AND TABLE_NAME = 'employees';
```

### Considerations

```sql
-- When converting:
-- 1. Backup data first
-- 2. Check for unsupported features
-- 3. Test in development first
-- 4. Consider downtime for large tables
-- 5. Verify foreign keys after conversion
```

## 🎯 Best Practices

1. **Use InnoDB by default** for most tables
2. **Use MyISAM** only for specific read-heavy, no-transaction needs
3. **Use Memory** for temporary, high-speed data
4. **Use Archive** for historical, rarely-accessed data
5. **Test thoroughly** before changing storage engines
6. **Backup before conversion** to avoid data loss
7. **Consider performance implications** of each engine
8. **Monitor storage engine statistics** for optimization

---

**Next**: Learn about [Replication Strategies](./REPLICATION-STRATEGIES.md)

