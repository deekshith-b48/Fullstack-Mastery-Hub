# Elasticsearch Security

## 📚 Overview

Elasticsearch security involves authentication, authorization, encryption, and network security to protect clusters and data.

## 🔐 Authentication

### Enable Security

```bash
# elasticsearch.yml
xpack.security.enabled: true
```

### Create Users

```bash
# Set passwords for built-in users
bin/elasticsearch-setup-passwords interactive

# Built-in users:
# elastic - Superuser
# kibana_system - Kibana system user
# logstash_system - Logstash system user
```

### Create Custom Users

```bash
# Create user via API
POST /_security/user/app_user
{
  "password": "secure_password",
  "roles": ["kibana_user"],
  "full_name": "Application User"
}
```

## 🔒 Authorization

### Built-in Roles

- **superuser**: Full access
- **kibana_admin**: Kibana administration
- **kibana_user**: Kibana user access
- **logstash_system**: Logstash system access
- **monitoring_user**: Monitoring access

### Custom Roles

```bash
# Create custom role
POST /_security/role/custom_role
{
  "cluster": ["monitor"],
  "indices": [
    {
      "names": ["employees"],
      "privileges": ["read", "write"]
    }
  ]
}
```

## 🛡️ Network Security

### TLS/SSL

```bash
# elasticsearch.yml
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/elastic-certificates.p12
xpack.security.http.ssl.enabled: true
```

### IP Filtering

```bash
# Filter by IP
xpack.security.http.filter.allow: "192.168.1.0/24"
xpack.security.http.filter.deny: "_all"
```

## 🔐 Encryption

### Encryption at Rest

```bash
# Enable encryption
xpack.security.enabled: true
```

## 🎯 Best Practices

1. **Enable security** in production
2. **Use strong passwords**
3. **Grant minimal privileges**
4. **Use TLS/SSL** for connections
5. **Restrict network access**
6. **Regular security audits**
7. **Keep Elasticsearch updated**

---

**Next**: Learn about [Kibana Visualization](./KIBANA-VISUALIZATION.md)

