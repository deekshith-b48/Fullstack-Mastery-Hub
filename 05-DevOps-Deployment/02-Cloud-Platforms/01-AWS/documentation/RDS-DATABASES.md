# AWS RDS Databases

## 📚 Overview

Amazon Relational Database Service (RDS) makes it easy to set up, operate, and scale relational databases in the cloud. RDS supports multiple database engines including MySQL, PostgreSQL, MariaDB, Oracle, and SQL Server.

## 🎯 Supported Database Engines

### Available Engines

- **MySQL**: Popular open-source database
- **PostgreSQL**: Advanced open-source database
- **MariaDB**: MySQL fork
- **Oracle**: Enterprise database
- **SQL Server**: Microsoft database
- **Aurora**: MySQL and PostgreSQL compatible (high performance)

## 🚀 Creating RDS Instances

### Create MySQL Instance

```bash
# Create MySQL RDS instance
aws rds create-db-instance \
  --db-instance-identifier my-mysql-db \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --engine-version 8.0.35 \
  --master-username admin \
  --master-user-password MyPassword123! \
  --allocated-storage 20 \
  --storage-type gp3 \
  --vpc-security-group-ids sg-12345678 \
  --db-subnet-group-name my-subnet-group \
  --backup-retention-period 7 \
  --storage-encrypted
```

### Create PostgreSQL Instance

```bash
# Create PostgreSQL RDS instance
aws rds create-db-instance \
  --db-instance-identifier my-postgres-db \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --engine-version 15.4 \
  --master-username postgres \
  --master-user-password MyPassword123! \
  --allocated-storage 20 \
  --storage-type gp3 \
  --vpc-security-group-ids sg-12345678 \
  --db-subnet-group-name my-subnet-group
```

### Create Aurora Cluster

```bash
# Create Aurora MySQL cluster
aws rds create-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --engine aurora-mysql \
  --engine-version 8.0.mysql_aurora.3.04.0 \
  --master-username admin \
  --master-user-password MyPassword123! \
  --database-name mydb

# Create Aurora instance
aws rds create-db-instance \
  --db-instance-identifier my-aurora-instance-1 \
  --db-instance-class db.r6g.large \
  --engine aurora-mysql \
  --db-cluster-identifier my-aurora-cluster
```

## 🔧 Instance Management

### Instance Operations

```bash
# List instances
aws rds describe-db-instances

# Get specific instance
aws rds describe-db-instances \
  --db-instance-identifier my-mysql-db

# Modify instance
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --db-instance-class db.t3.small \
  --apply-immediately

# Reboot instance
aws rds reboot-db-instance \
  --db-instance-identifier my-mysql-db

# Delete instance
aws rds delete-db-instance \
  --db-instance-identifier my-mysql-db \
  --skip-final-snapshot
```

### Snapshots

```bash
# Create snapshot
aws rds create-db-snapshot \
  --db-instance-identifier my-mysql-db \
  --db-snapshot-identifier my-snapshot

# List snapshots
aws rds describe-db-snapshots

# Restore from snapshot
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db \
  --db-snapshot-identifier my-snapshot
```

## 🔄 High Availability

### Multi-AZ Deployment

```bash
# Enable Multi-AZ
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --multi-az \
  --apply-immediately

# Automatic failover
# Standby replica in different AZ
```

### Read Replicas

```bash
# Create read replica
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-read-replica \
  --source-db-instance-identifier my-mysql-db \
  --db-instance-class db.t3.micro
```

### Aurora Replicas

```bash
# Aurora automatically creates replicas
# Add additional replica
aws rds create-db-instance \
  --db-instance-identifier my-aurora-replica \
  --db-instance-class db.r6g.large \
  --engine aurora-mysql \
  --db-cluster-identifier my-aurora-cluster
```

## 🔐 Security

### Encryption

```bash
# Enable encryption at rest
aws rds create-db-instance \
  --db-instance-identifier my-encrypted-db \
  --storage-encrypted \
  --kms-key-id <key-id>
```

### Network Security

```bash
# Create DB subnet group
aws rds create-db-subnet-group \
  --db-subnet-group-name my-subnet-group \
  --db-subnet-group-description "My DB subnet group" \
  --subnet-ids subnet-12345678 subnet-87654321

# Modify security groups
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --vpc-security-group-ids sg-12345678 sg-87654321
```

### Parameter Groups

```bash
# Create parameter group
aws rds create-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --db-parameter-group-family mysql8.0 \
  --description "My parameter group"

# Modify parameter
aws rds modify-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --parameters "ParameterName=max_connections,ParameterValue=200,ApplyMethod=immediate"
```

## 📊 Monitoring

### CloudWatch Metrics

```bash
# Get CPU utilization
aws cloudwatch get-metric-statistics \
  --namespace AWS/RDS \
  --metric-name CPUUtilization \
  --dimensions Name=DBInstanceIdentifier,Value=my-mysql-db \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Average
```

### Performance Insights

```bash
# Enable Performance Insights
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --enable-performance-insights \
  --performance-insights-retention-period 7
```

### Enhanced Monitoring

```bash
# Enable enhanced monitoring
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --monitoring-interval 60 \
  --monitoring-role-arn arn:aws:iam::123456789012:role/rds-monitoring-role
```

## 🔄 Backup and Recovery

### Automated Backups

```bash
# Configure backup retention
aws rds modify-db-instance \
  --db-instance-identifier my-mysql-db \
  --backup-retention-period 7 \
  --preferred-backup-window "03:00-04:00"
```

### Point-in-Time Recovery

```bash
# Restore to specific time
aws rds restore-db-instance-to-point-in-time \
  --source-db-instance-identifier my-mysql-db \
  --target-db-instance-identifier restored-db \
  --restore-time 2024-01-15T10:30:00Z
```

## 🎯 Best Practices

1. **Multi-AZ**: Enable for production
2. **Backups**: Configure automated backups
3. **Encryption**: Enable encryption at rest
4. **Monitoring**: Use CloudWatch and Performance Insights
5. **Security Groups**: Restrict access
6. **Parameter Groups**: Tune for performance
7. **Read Replicas**: Offload read traffic

## 🎓 Learning Resources

- RDS Documentation: https://docs.aws.amazon.com/rds/
- RDS Best Practices: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html
- Aurora: https://aws.amazon.com/rds/aurora/

---

**Next**: Learn about [Lambda Serverless](./LAMBDA-SERVERLESS.md)

