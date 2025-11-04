# PostgreSQL Administration

## 📚 Overview

PostgreSQL administration involves managing databases, users, backups, monitoring, and maintaining a healthy database system. This guide covers essential administrative tasks and best practices.

## 👤 User and Role Management

### Creating Users and Roles

```sql
-- Create a role (user)
CREATE ROLE app_user WITH LOGIN PASSWORD 'secure_password';

-- Create role with additional privileges
CREATE ROLE admin_user WITH 
    LOGIN 
    PASSWORD 'admin_password'
    CREATEDB
    CREATEROLE
    SUPERUSER;

-- Create user (same as CREATE ROLE ... WITH LOGIN)
CREATE USER app_user WITH PASSWORD 'secure_password';

-- Alter role
ALTER ROLE app_user WITH PASSWORD 'new_password';
ALTER ROLE app_user WITH CREATEDB;
ALTER ROLE app_user WITH NOCREATEDB;

-- Drop role
DROP ROLE app_user;
```

### Granting Privileges

```sql
-- Grant database privileges
GRANT CONNECT ON DATABASE myapp TO app_user;
GRANT ALL PRIVILEGES ON DATABASE myapp TO admin_user;

-- Grant schema privileges
GRANT USAGE ON SCHEMA public TO app_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO app_user;

-- Grant table privileges
GRANT SELECT, INSERT, UPDATE ON employees TO app_user;
GRANT ALL PRIVILEGES ON employees TO admin_user;

-- Grant on all tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;

-- Grant sequence privileges
GRANT USAGE, SELECT ON SEQUENCE employees_id_seq TO app_user;

-- Grant function privileges
GRANT EXECUTE ON FUNCTION calculate_salary() TO app_user;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_user;
```

### Role Membership

```sql
-- Create role group
CREATE ROLE developers;

-- Add user to role
GRANT developers TO app_user;

-- Remove user from role
REVOKE developers FROM app_user;

-- List role memberships
SELECT 
    r.rolname AS role,
    m.rolname AS member
FROM pg_roles r
JOIN pg_auth_members am ON r.oid = am.roleid
JOIN pg_roles m ON am.member = m.oid;
```

## 🗄️ Database Management

### Creating and Managing Databases

```sql
-- Create database
CREATE DATABASE myapp;

-- Create database with owner
CREATE DATABASE myapp OWNER app_user;

-- Create database with template
CREATE DATABASE myapp_template TEMPLATE template0;

-- Create database with encoding
CREATE DATABASE myapp WITH ENCODING 'UTF8';

-- List databases
\l
-- Or
SELECT datname FROM pg_database;

-- Connect to database
\c myapp
-- Or
CONNECT myapp;

-- Drop database
DROP DATABASE myapp;

-- Rename database
ALTER DATABASE old_name RENAME TO new_name;
```

### Database Configuration

```sql
-- Set database configuration
ALTER DATABASE myapp SET timezone = 'UTC';
ALTER DATABASE myapp SET log_statement = 'all';

-- View database settings
SELECT name, setting FROM pg_settings WHERE name = 'timezone';

-- Reset to default
ALTER DATABASE myapp RESET timezone;
```

## 📊 Monitoring and Statistics

### Database Statistics

```sql
-- View database sizes
SELECT 
    datname,
    pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database
ORDER BY pg_database_size(datname) DESC;

-- View table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - 
                   pg_relation_size(schemaname||'.'||tablename)) AS indexes_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- View index sizes
SELECT 
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
ORDER BY pg_relation_size(indexrelid) DESC;
```

### Connection Monitoring

```sql
-- View active connections
SELECT 
    pid,
    usename,
    application_name,
    client_addr,
    state,
    query_start,
    state_change,
    query
FROM pg_stat_activity
WHERE state = 'active';

-- View all connections
SELECT 
    datname,
    count(*) AS connections
FROM pg_stat_activity
GROUP BY datname;

-- Kill connection
SELECT pg_terminate_backend(pid) 
FROM pg_stat_activity 
WHERE pid = 12345;

-- View blocking queries
SELECT 
    blocked_locks.pid AS blocked_pid,
    blocking_locks.pid AS blocking_pid,
    blocked_activity.query AS blocked_query,
    blocking_activity.query AS blocking_query
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
JOIN pg_catalog.pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.granted;
```

### Query Performance Monitoring

```sql
-- Enable pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- View top queries by execution time
SELECT 
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    max_exec_time,
    rows
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

-- View queries by calls
SELECT 
    LEFT(query, 100) AS query,
    calls,
    total_exec_time,
    mean_exec_time
FROM pg_stat_statements
ORDER BY calls DESC
LIMIT 10;

-- Reset statistics
SELECT pg_stat_statements_reset();
```

## 🔄 Maintenance Operations

### VACUUM

```sql
-- Regular VACUUM
VACUUM employees;

-- VACUUM with ANALYZE
VACUUM ANALYZE employees;

-- VACUUM FULL (reclaims space, locks table)
VACUUM FULL employees;

-- VACUUM VERBOSE (shows progress)
VACUUM VERBOSE employees;

-- VACUUM all tables
VACUUM;

-- Configure auto-vacuum
ALTER TABLE employees SET (
    autovacuum_vacuum_scale_factor = 0.1,
    autovacuum_analyze_scale_factor = 0.05,
    autovacuum_vacuum_cost_delay = 20
);
```

### ANALYZE

```sql
-- Update statistics
ANALYZE employees;

-- Analyze specific columns
ANALYZE employees (salary, department_id);

-- Analyze all tables
ANALYZE;

-- Auto-analyze settings
ALTER TABLE employees SET (
    autovacuum_analyze_scale_factor = 0.05
);
```

### REINDEX

```sql
-- Reindex specific index
REINDEX INDEX idx_employees_email;

-- Reindex table
REINDEX TABLE employees;

-- Reindex database
REINDEX DATABASE myapp;

-- Reindex concurrently (PostgreSQL 12+)
REINDEX INDEX CONCURRENTLY idx_employees_email;
REINDEX TABLE CONCURRENTLY employees;
```

## 💾 Backup and Restore

### pg_dump

```bash
# Dump entire database
pg_dump -U postgres -d myapp > backup.sql

# Dump specific schema
pg_dump -U postgres -d myapp -n public > backup.sql

# Dump specific tables
pg_dump -U postgres -d myapp -t employees -t departments > backup.sql

# Custom format (compressed, allows selective restore)
pg_dump -U postgres -d myapp -Fc > backup.dump

# Directory format (parallel dump)
pg_dump -U postgres -d myapp -Fd -f backup_dir

# Dump with compression
pg_dump -U postgres -d myapp | gzip > backup.sql.gz
```

### pg_restore

```bash
# Restore from custom format
pg_restore -U postgres -d myapp_new backup.dump

# Restore from directory format
pg_restore -U postgres -d myapp_new -d backup_dir

# Restore specific tables
pg_restore -U postgres -d myapp_new -t employees backup.dump

# Restore with jobs (parallel)
pg_restore -U postgres -d myapp_new -j 4 backup.dump
```

### pg_dumpall

```bash
# Dump all databases
pg_dumpall -U postgres > all_databases.sql

# Dump with roles
pg_dumpall -U postgres --roles-only > roles.sql

# Restore all databases
psql -U postgres -f all_databases.sql
```

## 📝 Logging Configuration

### postgresql.conf Settings

```ini
# Enable logging
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'

# Log levels
log_min_messages = warning
log_min_error_statement = error
log_min_duration_statement = 1000  # Log queries > 1 second

# What to log
log_connections = on
log_disconnections = on
log_duration = on
log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h '
log_statement = 'all'  # or 'ddl', 'mod', 'none'
```

### Viewing Logs

```bash
# View log file
tail -f /var/log/postgresql/postgresql-*.log

# Search logs
grep "ERROR" /var/log/postgresql/postgresql-*.log

# View recent errors
tail -100 /var/log/postgresql/postgresql-*.log | grep ERROR
```

## 🔧 Configuration Tuning

### Memory Settings

```ini
# postgresql.conf
shared_buffers = 2GB              # 25% of RAM, max 8GB
work_mem = 16MB                   # Per operation
maintenance_work_mem = 512MB      # For VACUUM, CREATE INDEX
effective_cache_size = 6GB        # 50-75% of RAM
```

### Connection Settings

```ini
max_connections = 100
superuser_reserved_connections = 3
```

### Query Planner

```ini
random_page_cost = 1.1            # For SSD
effective_io_concurrency = 200    # For SSD
default_statistics_target = 100
```

## 🔍 Troubleshooting

### Common Issues

```sql
-- Check for locks
SELECT * FROM pg_locks WHERE NOT granted;

-- Check for long-running queries
SELECT 
    pid,
    now() - query_start AS duration,
    query
FROM pg_stat_activity
WHERE state = 'active'
AND now() - query_start > interval '5 minutes';

-- Check table bloat
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
    n_dead_tup,
    n_live_tup,
    CASE 
        WHEN n_live_tup > 0 
        THEN round(100.0 * n_dead_tup / n_live_tup, 2) 
        ELSE 0 
    END AS dead_tuple_ratio
FROM pg_stat_user_tables
WHERE n_dead_tup > 0
ORDER BY n_dead_tup DESC;
```

### Performance Diagnostics

```sql
-- Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0
AND pg_relation_size(indexrelid) > 1048576  -- > 1MB
ORDER BY pg_relation_size(indexrelid) DESC;

-- Check table statistics
SELECT 
    schemaname,
    tablename,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC;
```

## 🎯 Best Practices

1. **Regular maintenance**: Run VACUUM and ANALYZE regularly
2. **Monitor connections**: Keep track of active connections
3. **Backup regularly**: Schedule automated backups
4. **Monitor performance**: Use pg_stat_statements
5. **Tune configuration**: Adjust settings based on workload
6. **Log important events**: Configure appropriate log levels
7. **Manage users properly**: Follow principle of least privilege
8. **Monitor disk space**: Check database and log sizes regularly
9. **Review slow queries**: Identify and optimize slow queries
10. **Keep statistics updated**: Ensure ANALYZE runs regularly

---

**Next**: Learn about [Replication & High Availability](./REPLICATION-HA.md)

