# Azure SQL Database

## 📚 Overview

Azure SQL Database is a fully managed relational database service based on SQL Server. It provides high availability, automatic backups, and built-in security features.

## 🎯 SQL Database Options

### Service Tiers

- **Basic**: For lightweight workloads
- **Standard**: General-purpose workloads
- **Premium**: High-performance workloads
- **Hyperscale**: Massive scale-out databases
- **Serverless**: Auto-pause, pay-per-use

### Deployment Models

- **Single Database**: Isolated database
- **Elastic Pool**: Shared resources across databases
- **Managed Instance**: Full SQL Server compatibility

## 🚀 Creating Databases

### Create SQL Server

```bash
# Create SQL server
az sql server create \
  --name myserver \
  --resource-group myResourceGroup \
  --location eastus \
  --admin-user sqladmin \
  --admin-password MyPassword123!

# Create SQL server with firewall rule
az sql server firewall-rule create \
  --resource-group myResourceGroup \
  --server myserver \
  --name AllowAzureServices \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0
```

### Create Database

```bash
# Create single database
az sql db create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --service-objective S0 \
  --backup-storage-redundancy Local

# Create database with specific tier
az sql db create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --edition GeneralPurpose \
  --compute-model Serverless \
  --family Gen5 \
  --capacity 2
```

### Elastic Pool

```bash
# Create elastic pool
az sql elastic-pool create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myElasticPool \
  --edition GeneralPurpose \
  --dtu 50

# Add database to elastic pool
az sql db update \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --elastic-pool myElasticPool
```

## 🔧 Database Management

### Database Operations

```bash
# List databases
az sql db list \
  --resource-group myResourceGroup \
  --server myserver

# Get database details
az sql db show \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase

# Update database
az sql db update \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --service-objective S1

# Delete database
az sql db delete \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase
```

### Backup and Restore

```bash
# Create manual backup (point-in-time restore)
az sql db restore \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --dest-name myRestoredDatabase \
  --time "2024-01-15T10:30:00Z"

# Long-term retention
az sql db ltr-backup set \
  --resource-group myResourceGroup \
  --server myserver \
  --database-name myDatabase \
  --weekly-retention "P4W" \
  --monthly-retention "P12M" \
  --yearly-retention "P1Y"
```

## 🔐 Security

### Firewall Rules

```bash
# Add firewall rule
az sql server firewall-rule create \
  --resource-group myResourceGroup \
  --server myserver \
  --name AllowMyIP \
  --start-ip-address 203.0.113.0 \
  --end-ip-address 203.0.113.255

# List firewall rules
az sql server firewall-rule list \
  --resource-group myResourceGroup \
  --server myserver
```

### Virtual Network

```bash
# Create virtual network rule
az sql server vnet-rule create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myVNetRule \
  --vnet-name myVNet \
  --subnet mySubnet
```

### Azure AD Authentication

```bash
# Enable Azure AD admin
az sql server ad-admin create \
  --resource-group myResourceGroup \
  --server myserver \
  --display-name "Admin User" \
  --object-id {object-id}
```

## 🔄 High Availability

### Geo-Replication

```bash
# Create geo-replica
az sql db replica create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myDatabase \
  --partner-server myPartnerServer \
  --partner-resource-group myResourceGroup
```

### Failover Groups

```bash
# Create failover group
az sql failover-group create \
  --resource-group myResourceGroup \
  --server myserver \
  --name myFailoverGroup \
  --partner-server myPartnerServer \
  --partner-resource-group myResourceGroup \
  --failover-policy Automatic
```

## 📊 Monitoring

### Metrics

```bash
# Get database metrics
az monitor metrics list \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Sql/servers/myserver/databases/myDatabase \
  --metric "cpu_percent"
```

### Query Performance Insights

```bash
# Enable Query Performance Insight
# Configured through Azure Portal or REST API
```

## 🎯 Best Practices

1. **Service Tier**: Choose appropriate tier
2. **Elastic Pools**: Use for multiple databases
3. **Backup**: Configure automated backups
4. **Security**: Enable firewall and Azure AD
5. **Monitoring**: Monitor performance metrics
6. **Scaling**: Use auto-scaling for serverless
7. **High Availability**: Enable geo-replication

## 🎓 Learning Resources

- SQL Database Documentation: https://docs.microsoft.com/azure/sql-database/
- Best Practices: https://docs.microsoft.com/azure/sql-database/sql-database-best-practices
- SQL Database: https://azure.microsoft.com/services/sql-database/

---

**Next**: Learn about [Blob Storage](./BLOB-STORAGE.md)

