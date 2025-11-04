# SQL Server Security

## 📚 Overview

SQL Server security involves protecting databases from unauthorized access and ensuring data confidentiality, integrity, and availability. This guide covers comprehensive security practices.

## 🔐 Authentication

### Windows Authentication

```sql
-- Create Windows login
CREATE LOGIN [DOMAIN\username] FROM WINDOWS;
```

### SQL Server Authentication

```sql
-- Create SQL login
CREATE LOGIN app_user WITH PASSWORD = 'secure_password';

-- Password policy
CREATE LOGIN app_user 
WITH PASSWORD = 'secure_password' 
MUST_CHANGE, 
CHECK_EXPIRATION = ON,
CHECK_POLICY = ON;
```

## 🔒 Authorization

### Database Users

```sql
-- Create user
CREATE USER app_user FOR LOGIN app_user;

-- Grant permissions
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO app_user;

-- Grant database role
ALTER ROLE db_datareader ADD MEMBER app_user;
ALTER ROLE db_datawriter ADD MEMBER app_user;
```

### Row-Level Security

```sql
-- Enable RLS
ALTER TABLE employees ADD SECURITY POLICY emp_policy;

-- Create security policy
CREATE SECURITY POLICY emp_policy
ADD FILTER PREDICATE dbo.fn_securitypredicate(department_id)
ON employees;
```

## 🛡️ Encryption

### Transparent Data Encryption

```sql
-- Create master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'master_key_password';

-- Create certificate
CREATE CERTIFICATE MyCert 
WITH SUBJECT = 'My Certificate';

-- Enable TDE
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE MyCert;

ALTER DATABASE myapp SET ENCRYPTION ON;
```

### Column Encryption

```sql
-- Encrypt column
CREATE TABLE employees (
    id INT,
    ssn VARBINARY(128) -- Encrypted
);

-- Use encryption functions
OPEN SYMMETRIC KEY MyKey
DECRYPTION BY CERTIFICATE MyCert;

INSERT INTO employees (id, ssn)
VALUES (1, EncryptByKey(Key_GUID('MyKey'), '123-45-6789'));
```

## 🎯 Best Practices

1. **Use Windows Authentication** when possible
2. **Enforce password policies**
3. **Grant minimal privileges**
4. **Enable encryption** for sensitive data
5. **Regular security audits**
6. **Monitor access logs**
7. **Keep SQL Server updated**

---

**Next**: Learn about [Performance Tuning](./PERFORMANCE-TUNING.md)

