# Redis Security

## 📚 Overview

Redis security involves authentication, network security, and access control to protect data and prevent unauthorized access.

## 🔐 Authentication

### Enable Authentication

```bash
# redis.conf
requirepass your_secure_password

# Or set via command
CONFIG SET requirepass your_secure_password
```

### Authenticate

```bash
# Authenticate in CLI
AUTH password

# Or connect with password
redis-cli -a password
```

## 🔒 Network Security

### Bind to Specific IP

```bash
# redis.conf
bind 127.0.0.1 192.168.1.100

# Don't bind to all interfaces
# bind 0.0.0.0  # NOT SECURE
```

### Firewall Rules

```bash
# Allow only necessary IPs
iptables -A INPUT -p tcp --dport 6379 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 6379 -j DROP
```

### Disable Dangerous Commands

```bash
# redis.conf
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command CONFIG "CONFIG_9a2b3c4d"
```

## 🛡️ ACL (Access Control Lists)

### Create ACL User

```bash
# Create user with password
ACL SETUSER alice on >password ~cached:* +get +set

# User permissions:
# +command - Allow command
# -command - Deny command
# @category - Allow command category
# ~pattern - Allowed key pattern
```

## 🎯 Best Practices

1. **Enable authentication** in production
2. **Use strong passwords**
3. **Restrict network access**
4. **Disable dangerous commands**
5. **Use ACL** for fine-grained access
6. **Encrypt sensitive data**
7. **Keep Redis updated**

---

**Next**: Learn about [Use Cases & Scenarios](./USE-CASES-SCENARIOS.md)

