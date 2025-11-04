# Cassandra Security

## 📚 Overview

Cassandra security involves authentication, authorization, encryption, and network security to protect clusters and data.

## 🔐 Authentication

### Enable Authentication

```yaml
# cassandra.yaml
authenticator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```

### Create Users

```sql
-- Create superuser
CREATE ROLE admin WITH PASSWORD = 'secure_password' AND SUPERUSER = true;

-- Create regular user
CREATE ROLE app_user WITH PASSWORD = 'secure_password';

-- Grant permissions
GRANT ALL ON KEYSPACE myapp TO app_user;
```

## 🔒 Authorization

### Roles and Permissions

```sql
-- Create role
CREATE ROLE readonly;

-- Grant permissions
GRANT SELECT ON KEYSPACE myapp TO readonly;
GRANT SELECT ON TABLE employees TO readonly;

-- Assign role
GRANT readonly TO app_user;
```

## 🛡️ Network Security

### Encryption

```yaml
# cassandra.yaml
server_encryption_options:
  internode_encryption: all
  keystore: conf/.keystore
  keystore_password: password

client_encryption_options:
  enabled: true
  keystore: conf/.keystore
  keystore_password: password
```

## 🎯 Best Practices

1. **Enable authentication** in production
2. **Use strong passwords**
3. **Grant minimal permissions**
4. **Enable encryption**
5. **Restrict network access**
6. **Regular security audits**

---

**Next**: Learn about [Maintenance Operations](./MAINTENANCE-OPERATIONS.md)

