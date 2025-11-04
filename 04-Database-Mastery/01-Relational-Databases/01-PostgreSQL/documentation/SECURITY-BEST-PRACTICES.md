# PostgreSQL Security Best Practices

## 📚 Overview

Security is crucial for protecting PostgreSQL databases and sensitive data. This guide covers authentication, authorization, encryption, network security, and comprehensive security best practices.

## 🔐 Authentication

### Password Authentication

```sql
-- Create user with password
CREATE USER app_user WITH PASSWORD 'secure_password';

-- Use strong passwords
-- Minimum 12 characters
-- Mix of uppercase, lowercase, numbers, special characters
-- Avoid dictionary words

-- Change password regularly
ALTER USER app_user WITH PASSWORD 'new_secure_password';
```

### Password Policies

```sql
-- Install passwordcheck extension
CREATE EXTENSION passwordcheck;

-- Configure password policies in passwordcheck
-- Edit passwordcheck.c or use pg_password_history extension
```

### pg_hba.conf Configuration

```conf
# pg_hba.conf - Client Authentication Configuration

# Trust local connections (development only)
local   all             all                                     trust

# Require password for local connections
local   all             all                                     md5

# Require password for network connections
host    all             all             127.0.0.1/32            md5

# SSL connections from specific network
hostssl all             all             192.168.1.0/24          md5

# Replication connections
host    replication     replicator      192.168.1.0/24          md5

# Deny all other connections
host    all             all             0.0.0.0/0               reject
```

### SSL/TLS Configuration

```bash
# Generate SSL certificates
openssl req -new -x509 -days 365 -nodes -text -out server.crt \
  -keyout server.key -subj "/CN=db.example.com"

# postgresql.conf
ssl = on
ssl_cert_file = '/etc/ssl/certs/server.crt'
ssl_key_file = '/etc/ssl/private/server.key'
ssl_ca_file = '/etc/ssl/certs/ca.crt'
ssl_crl_file = '/etc/ssl/certs/ca.crl'
```

## 🔒 Authorization

### Role-Based Access Control

```sql
-- Create roles with specific privileges
CREATE ROLE app_readonly;
GRANT CONNECT ON DATABASE myapp TO app_readonly;
GRANT USAGE ON SCHEMA public TO app_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_readonly;

CREATE ROLE app_readwrite;
GRANT CONNECT ON DATABASE myapp TO app_readwrite;
GRANT USAGE ON SCHEMA public TO app_readwrite;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_readwrite;

-- Assign roles to users
GRANT app_readonly TO app_user;
```

### Row-Level Security

```sql
-- Enable RLS on table
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY emp_isolation_policy ON employees
    FOR ALL
    USING (department_id = current_setting('app.current_dept')::int);

-- Users can only see their department's employees
SET app.current_dept = '5';
SELECT * FROM employees;  -- Only sees department 5 employees
```

### Column-Level Security

```sql
-- Revoke access to sensitive columns
REVOKE SELECT (salary, ssn) ON employees FROM app_user;

-- Grant access to specific columns
GRANT SELECT (id, first_name, email) ON employees TO app_user;
```

## 🛡️ Network Security

### Firewall Configuration

```bash
# Allow only necessary IPs
# Use iptables or firewall-cmd

# Allow PostgreSQL port only from application servers
iptables -A INPUT -p tcp --dport 5432 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 5432 -j DROP

# Allow replication only from standby servers
iptables -A INPUT -p tcp --dport 5432 -s 192.168.1.10 -j ACCEPT
```

### Connection Limits

```sql
-- Limit connections per user
ALTER USER app_user WITH CONNECTION LIMIT 10;

-- Limit connections per database
ALTER DATABASE myapp WITH CONNECTION LIMIT 50;
```

### Listen Addresses

```bash
# postgresql.conf
# Only listen on specific interface
listen_addresses = 'localhost,192.168.1.100'

# Don't listen on all interfaces
# listen_addresses = '*'  # NOT SECURE
```

## 🔑 Encryption

### Data at Rest Encryption

```bash
# Use filesystem encryption
# LUKS encryption for data directory
cryptsetup luksFormat /dev/sdb1
cryptsetup luksOpen /dev/sdb1 postgres_data
mkfs.ext4 /dev/mapper/postgres_data
mount /dev/mapper/postgres_data /var/lib/postgresql/data
```

### Transparent Data Encryption

```sql
-- Use pgcrypto extension for column-level encryption
CREATE EXTENSION pgcrypto;

-- Encrypt sensitive data
INSERT INTO employees (first_name, ssn_encrypted)
VALUES ('John', pgp_sym_encrypt('123-45-6789', 'encryption_key'));

-- Decrypt data
SELECT first_name, pgp_sym_decrypt(ssn_encrypted, 'encryption_key') AS ssn
FROM employees;
```

## 🔍 Auditing and Logging

### Enable Audit Logging

```bash
# postgresql.conf
log_connections = on
log_disconnections = on
log_duration = on
log_statement = 'ddl'          # Log DDL statements
log_min_duration_statement = 0  # Log all statements
log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h '
```

### Audit Extensions

```sql
-- Install pgAudit extension
CREATE EXTENSION pgaudit;

-- Configure audit logging
ALTER SYSTEM SET pgaudit.log = 'read,write,ddl';
ALTER SYSTEM SET pgaudit.log_catalog = off;
ALTER SYSTEM SET pgaudit.log_parameter = on;
```

## 🚫 SQL Injection Prevention

### Parameterized Queries

```sql
-- ✅ Good: Parameterized query
PREPARE get_user AS SELECT * FROM users WHERE id = $1;
EXECUTE get_user(123);

-- ❌ Bad: String concatenation
-- SELECT * FROM users WHERE id = '123' || user_input
```

### Application-Level Protection

```javascript
// Node.js example with parameterized queries
const query = 'SELECT * FROM users WHERE id = $1';
const result = await db.query(query, [userId]);
```

## 🔐 Security Best Practices

### Regular Updates

```bash
# Keep PostgreSQL updated
# Apply security patches promptly
# Monitor security advisories
```

### Backup Security

```bash
# Encrypt backups
pg_dump -U postgres -d myapp | gpg -c > backup.sql.gpg

# Secure backup storage
# Limit access to backup files
# Use secure backup locations
```

### Principle of Least Privilege

```sql
-- Grant only necessary privileges
-- Don't grant SUPERUSER unless absolutely necessary
-- Use specific role privileges instead of ALL
GRANT SELECT, INSERT ON employees TO app_user;  -- ✅ Good
GRANT ALL ON employees TO app_user;  -- ❌ Avoid
```

### Regular Security Audits

```sql
-- Review user privileges
SELECT 
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee NOT IN ('postgres', 'PUBLIC')
ORDER BY grantee, table_name;

-- Review role memberships
SELECT 
    r.rolname AS role,
    m.rolname AS member
FROM pg_roles r
JOIN pg_auth_members am ON r.oid = am.roleid
JOIN pg_roles m ON am.member = m.oid;

-- Find unused roles
SELECT rolname 
FROM pg_roles 
WHERE rolname NOT IN (
    SELECT DISTINCT grantee FROM information_schema.role_table_grants
);
```

### Secure Configuration

```bash
# postgresql.conf security settings
shared_preload_libraries = 'pg_stat_statements'  # Monitor queries
log_connections = on
log_disconnections = on
log_checkpoints = on
log_lock_waits = on
```

## 🎯 Security Checklist

- [ ] Use strong passwords
- [ ] Configure pg_hba.conf properly
- [ ] Enable SSL/TLS
- [ ] Use firewall rules
- [ ] Implement row-level security
- [ ] Grant minimal privileges
- [ ] Enable audit logging
- [ ] Encrypt sensitive data
- [ ] Regular security updates
- [ ] Regular security audits
- [ ] Backup encryption
- [ ] Monitor access logs
- [ ] Use connection limits
- [ ] Implement fail2ban
- [ ] Regular privilege reviews

---

**PostgreSQL section complete!** Next: Learn about [MySQL](./../02-MySQL/documentation/MYSQL-FUNDAMENTALS.md)

