# MongoDB Security Best Practices

## 📚 Overview

MongoDB security involves authentication, authorization, encryption, and network security to protect data and prevent unauthorized access.

## 🔐 Authentication

### Create User

```javascript
// Create admin user
use admin
db.createUser({
    user: "admin",
    pwd: "secure_password",
    roles: ["root"]
})

// Create application user
use myapp
db.createUser({
    user: "app_user",
    pwd: "secure_password",
    roles: [
        { role: "readWrite", db: "myapp" }
    ]
})
```

### Enable Authentication

```bash
# Start MongoDB with authentication
mongod --auth

# Or in mongod.conf
security:
  authorization: enabled
```

## 🔒 Authorization

### Built-in Roles

```javascript
// Database user admin
db.createUser({
    user: "db_admin",
    pwd: "password",
    roles: ["dbAdmin"]
})

// Read-only user
db.createUser({
    user: "readonly",
    pwd: "password",
    roles: ["read"]
})

// Read-write user
db.createUser({
    user: "readwrite",
    pwd: "password",
    roles: ["readWrite"]
})
```

### Custom Roles

```javascript
// Create custom role
db.createRole({
    role: "customRole",
    privileges: [
        {
            resource: { db: "myapp", collection: "employees" },
            actions: ["find", "insert", "update"]
        }
    ],
    roles: []
})
```

## 🛡️ Network Security

### Bind to Specific IP

```bash
# mongod.conf
net:
  bindIp: 127.0.0.1,192.168.1.100
```

### Firewall Rules

```bash
# Allow only necessary IPs
iptables -A INPUT -p tcp --dport 27017 -s 192.168.1.0/24 -j ACCEPT
```

## 🔐 Encryption

### Encryption at Rest

```bash
# Enable encryption
mongod --enableEncryption --encryptionKeyFile /path/to/keyfile
```

### TLS/SSL

```bash
# Start with TLS
mongod --tlsMode requireTLS --tlsCertificateKeyFile /path/to/cert.pem
```

## 🎯 Best Practices

1. **Enable authentication** in production
2. **Use strong passwords**
3. **Grant minimal privileges**
4. **Use TLS/SSL** for connections
5. **Restrict network access**
6. **Encrypt sensitive data**
7. **Regular security audits**
8. **Keep MongoDB updated**

---

**Next**: Learn about [MongoDB Atlas Cloud](./ATLAS-CLOUD.md)

