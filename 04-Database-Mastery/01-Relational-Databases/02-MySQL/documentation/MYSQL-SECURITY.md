# MySQL Security

## 📚 Overview

MySQL security involves protecting databases from unauthorized access, data breaches, and security vulnerabilities. This guide covers authentication, authorization, encryption, and comprehensive security best practices.

## 🔐 User Management

### Creating Users

```sql
-- Create user with password
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';

-- Create user with specific host
CREATE USER 'app_user'@'%' IDENTIFIED BY 'secure_password';

-- Create user with password expiration
CREATE USER 'app_user'@'localhost' 
IDENTIFIED BY 'password' 
PASSWORD EXPIRE INTERVAL 90 DAY;

-- Create user with resource limits
CREATE USER 'app_user'@'localhost'
IDENTIFIED BY 'password'
WITH MAX_QUERIES_PER_HOUR 1000
MAX_CONNECTIONS_PER_HOUR 100
MAX_UPDATES_PER_HOUR 500;
```

### Password Management

```sql
-- Change password
ALTER USER 'app_user'@'localhost' IDENTIFIED BY 'new_password';

-- Set password expiration
ALTER USER 'app_user'@'localhost' PASSWORD EXPIRE;

-- Lock/unlock account
ALTER USER 'app_user'@'localhost' ACCOUNT LOCK;
ALTER USER 'app_user'@'localhost' ACCOUNT UNLOCK;

-- View password policy
SHOW VARIABLES LIKE 'validate_password%';
```

### Granting Privileges

```sql
-- Grant database privileges
GRANT SELECT, INSERT, UPDATE ON myapp.* TO 'app_user'@'localhost';

-- Grant table privileges
GRANT SELECT, INSERT, UPDATE ON myapp.employees TO 'app_user'@'localhost';

-- Grant specific column privileges
GRANT SELECT (id, first_name, email) ON myapp.employees TO 'app_user'@'localhost';

-- Grant all privileges
GRANT ALL PRIVILEGES ON myapp.* TO 'admin_user'@'localhost';

-- Grant with grant option
GRANT SELECT ON myapp.* TO 'app_user'@'localhost' WITH GRANT OPTION;

-- Refresh privileges
FLUSH PRIVILEGES;
```

### Revoking Privileges

```sql
-- Revoke specific privilege
REVOKE DELETE ON myapp.* FROM 'app_user'@'localhost';

-- Revoke all privileges
REVOKE ALL PRIVILEGES ON myapp.* FROM 'app_user'@'localhost';

-- Show grants
SHOW GRANTS FOR 'app_user'@'localhost';
```

## 🔒 Network Security

### Firewall Configuration

```bash
# Allow only necessary IPs
# Use iptables or firewall-cmd

# Allow MySQL port only from application servers
iptables -A INPUT -p tcp --dport 3306 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 3306 -j DROP
```

### Bind Address

```ini
# my.cnf - Only listen on specific interface
bind-address = 192.168.1.100

# Don't listen on all interfaces
# bind-address = 0.0.0.0  # NOT SECURE
```

### SSL/TLS Configuration

```bash
# Generate SSL certificates
mysql_ssl_rsa_setup --uid=mysql

# my.cnf
[mysqld]
ssl-ca = /var/lib/mysql/ca.pem
ssl-cert = /var/lib/mysql/server-cert.pem
ssl-key = /var/lib/mysql/server-key.pem
```

### Require SSL for Users

```sql
-- Require SSL connection
ALTER USER 'app_user'@'%' REQUIRE SSL;

-- Require X509 certificate
ALTER USER 'app_user'@'%' REQUIRE X509;

-- Require specific certificate
ALTER USER 'app_user'@'%' REQUIRE ISSUER '/C=US/ST=CA/L=SF/O=Company/CN=CA';
```

## 🛡️ Data Encryption

### Encryption at Rest

```sql
-- Enable encryption for InnoDB tables
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ssn VARCHAR(11) ENCRYPTED
) ENGINE=InnoDB ENCRYPTION='Y';

-- Or encrypt existing table
ALTER TABLE employees ENCRYPTION='Y';
```

### Application-Level Encryption

```sql
-- Use AES_ENCRYPT for sensitive data
INSERT INTO employees (first_name, ssn_encrypted)
VALUES ('John', AES_ENCRYPT('123-45-6789', 'encryption_key'));

-- Decrypt data
SELECT first_name, AES_DECRYPT(ssn_encrypted, 'encryption_key') AS ssn
FROM employees;
```

## 🔍 Audit Logging

### Enable Audit Log

```ini
# my.cnf
[mysqld]
plugin-load-add = audit_log.so
audit-log = FORCE_PLUS_PERMANENT
audit-log-policy = ALL
audit-log-format = JSON
```

### View Audit Logs

```bash
# View audit log
tail -f /var/lib/mysql/audit.log

# Parse JSON audit logs
cat /var/lib/mysql/audit.log | jq .
```

## 🚫 SQL Injection Prevention

### Parameterized Queries

```sql
-- ✅ Good: Parameterized query
PREPARE stmt FROM 'SELECT * FROM users WHERE id = ?';
SET @id = 123;
EXECUTE stmt USING @id;

-- ❌ Bad: String concatenation
-- SELECT * FROM users WHERE id = '123' || user_input
```

### Application Best Practices

```javascript
// Node.js example
const query = 'SELECT * FROM users WHERE id = ?';
const result = await db.query(query, [userId]);
```

## 🔐 Security Best Practices

### Regular Updates

```bash
# Keep MySQL updated
# Apply security patches promptly
# Monitor security advisories
```

### Principle of Least Privilege

```sql
-- Grant only necessary privileges
GRANT SELECT, INSERT ON myapp.employees TO 'app_user'@'localhost';  -- ✅ Good
GRANT ALL ON myapp.* TO 'app_user'@'localhost';  -- ❌ Avoid
```

### Remove Default Users

```sql
-- Remove anonymous users
DROP USER ''@'localhost';
DROP USER ''@'%';

-- Remove test database
DROP DATABASE test;
```

### Secure Configuration

```ini
# my.cnf security settings
local-infile = 0
skip-name-resolve
secure-file-priv = /var/lib/mysql-files/
```

## 🎯 Security Checklist

- [ ] Use strong passwords
- [ ] Remove default users
- [ ] Configure firewall rules
- [ ] Enable SSL/TLS
- [ ] Grant minimal privileges
- [ ] Regular security updates
- [ ] Enable audit logging
- [ ] Encrypt sensitive data
- [ ] Monitor access logs
- [ ] Regular privilege reviews

---

**Next**: Learn about [Backup & Recovery](./BACKUP-RECOVERY.md)

