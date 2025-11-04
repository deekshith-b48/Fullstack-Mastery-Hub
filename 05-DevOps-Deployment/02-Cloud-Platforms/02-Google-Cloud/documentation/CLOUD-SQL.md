# Google Cloud SQL

## 📚 Overview

Google Cloud SQL is a fully-managed relational database service for MySQL, PostgreSQL, and SQL Server. It provides automated backups, replication, and high availability.

## 🎯 Supported Databases

### Database Engines

- **MySQL**: Versions 5.7, 8.0
- **PostgreSQL**: Versions 11, 12, 13, 14, 15
- **SQL Server**: Versions 2017, 2019, 2022

## 🚀 Creating Instances

### Create MySQL Instance

```bash
# Create MySQL instance
gcloud sql instances create my-mysql-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=us-east1 \
  --root-password=MyPassword123!

# Create with custom configuration
gcloud sql instances create my-mysql-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-n1-standard-1 \
  --region=us-east1 \
  --storage-type=SSD \
  --storage-size=20GB \
  --storage-auto-increase \
  --backup-start-time=03:00 \
  --enable-bin-log
```

### Create PostgreSQL Instance

```bash
# Create PostgreSQL instance
gcloud sql instances create my-postgres-instance \
  --database-version=POSTGRES_15 \
  --tier=db-f1-micro \
  --region=us-east1 \
  --root-password=MyPassword123!
```

### Instance Tiers

- **db-f1-micro**: Shared-core (1 vCPU, 0.6 GB RAM)
- **db-g1-small**: Shared-core (1 vCPU, 1.7 GB RAM)
- **db-n1-standard-***: Standard (1-32 vCPUs, 3.75-120 GB RAM)
- **db-n1-highmem-***: High memory (1-32 vCPUs, 6.5-208 GB RAM)

## 🔧 Instance Management

### Instance Operations

```bash
# List instances
gcloud sql instances list

# Get instance details
gcloud sql instances describe my-mysql-instance

# Update instance
gcloud sql instances patch my-mysql-instance \
  --tier=db-n1-standard-2

# Restart instance
gcloud sql instances restart my-mysql-instance

# Delete instance
gcloud sql instances delete my-mysql-instance
```

### Databases

```bash
# Create database
gcloud sql databases create mydb \
  --instance=my-mysql-instance

# List databases
gcloud sql databases list --instance=my-mysql-instance

# Delete database
gcloud sql databases delete mydb --instance=my-mysql-instance
```

### Users

```bash
# Create user
gcloud sql users create myuser \
  --instance=my-mysql-instance \
  --password=MyPassword123!

# List users
gcloud sql users list --instance=my-mysql-instance

# Change password
gcloud sql users set-password myuser \
  --instance=my-mysql-instance \
  --password=NewPassword123!
```

## 🔄 High Availability

### Read Replicas

```bash
# Create read replica
gcloud sql instances create my-replica \
  --master-instance-name=my-mysql-instance \
  --tier=db-n1-standard-1 \
  --region=us-east1
```

### Failover Replicas

```bash
# Create failover replica
gcloud sql instances create my-failover \
  --master-instance-name=my-mysql-instance \
  --tier=db-n1-standard-1 \
  --region=us-west1 \
  --replication=ASYNC \
  --failover
```

### High Availability

```bash
# Enable high availability
gcloud sql instances patch my-mysql-instance \
  --availability-type=REGIONAL
```

## 🔐 Security

### SSL/TLS

```bash
# Require SSL
gcloud sql instances patch my-mysql-instance \
  --require-ssl

# Get SSL certificate
gcloud sql ssl-certs get server-ca \
  --instance=my-mysql-instance
```

### Authorized Networks

```bash
# Add authorized network
gcloud sql instances patch my-mysql-instance \
  --authorized-networks=203.0.113.0/24,198.51.100.0/24
```

### Private IP

```bash
# Configure private IP
gcloud sql instances patch my-mysql-instance \
  --network=projects/PROJECT_ID/global/networks/my-vpc \
  --no-assign-ip
```

## 📊 Backups

### Automated Backups

```bash
# Configure backups
gcloud sql instances patch my-mysql-instance \
  --backup-start-time=03:00 \
  --backup \
  --enable-bin-log
```

### Manual Backups

```bash
# Create backup
gcloud sql backups create \
  --instance=my-mysql-instance \
  --description="Manual backup"

# List backups
gcloud sql backups list --instance=my-mysql-instance

# Restore from backup
gcloud sql backups restore BACKUP_ID \
  --backup-instance=my-mysql-instance
```

## 🔍 Monitoring

### Cloud Monitoring

```bash
# View metrics
gcloud monitoring metrics list --filter="resource.type=cloudsql_database"
```

## 🎯 Best Practices

1. **High Availability**: Enable for production
2. **Backups**: Configure automated backups
3. **SSL**: Require SSL connections
4. **Authorized Networks**: Restrict access
5. **Monitoring**: Monitor performance metrics
6. **Right-sizing**: Choose appropriate tiers
7. **Replication**: Use read replicas for read-heavy workloads

## 🎓 Learning Resources

- Cloud SQL Documentation: https://cloud.google.com/sql/docs
- Best Practices: https://cloud.google.com/sql/docs/mysql/best-practices
- Database Options: https://cloud.google.com/sql/docs/mysql/instance-settings

---

**Next**: Learn about [Cloud Functions](./CLOUD-FUNCTIONS.md)

