# Backup Strategies

## 📚 Overview

Database backups are essential for data protection and disaster recovery.

## 🎯 Backup Types

### Full Backup

Complete backup of entire database.

```bash
# PostgreSQL
pg_dump -U username -d database_name > backup.sql

# MySQL
mysqldump -u username -p database_name > backup.sql

# MongoDB
mongodump --db myapp --out /backup/directory
```

### Incremental Backup

Backs up only changes since last backup.

```bash
# PostgreSQL WAL archiving (automatic incremental)
# Configure postgresql.conf
archive_mode = on
archive_command = 'cp %p /backup/wal/%f'
```

### Differential Backup

Backs up changes since last full backup.

## 🔄 Backup Strategies

### PostgreSQL

```bash
# Full backup
pg_dump -U postgres -F c -f backup.dump myapp

# Custom format (compressed)
pg_dump -U postgres -F c -f backup.dump myapp

# Restore
pg_restore -U postgres -d myapp_new backup.dump

# Continuous backup (WAL archiving)
# Enables point-in-time recovery
```

### MySQL

```bash
# Full backup
mysqldump -u root -p --all-databases > full_backup.sql

# Single database
mysqldump -u root -p myapp > myapp_backup.sql

# With structure only
mysqldump -u root -p --no-data myapp > schema.sql

# Restore
mysql -u root -p myapp < myapp_backup.sql
```

### MongoDB

```bash
# Full backup
mongodump --db myapp --out /backup/$(date +%Y%m%d)

# Restore
mongorestore --db myapp /backup/20240101/myapp

# Compressed backup
mongodump --db myapp --archive=backup.archive --gzip

# Restore compressed
mongorestore --archive=backup.archive --gzip
```

## ⏰ Backup Schedule

### Recommended Schedule

```
Full Backup: Weekly (Sunday 2 AM)
Incremental: Daily (2 AM)
Retention: 
  - Daily: 7 days
  - Weekly: 4 weeks
  - Monthly: 12 months
```

### Automation

```bash
#!/bin/bash
# backup.sh
BACKUP_DIR="/backup/postgresql"
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump -U postgres myapp > "$BACKUP_DIR/myapp_$DATE.sql"

# Keep only last 30 days
find $BACKUP_DIR -name "*.sql" -mtime +30 -delete
```

```bash
# Cron job (run daily at 2 AM)
0 2 * * * /path/to/backup.sh
```

## 🔄 Replication

### PostgreSQL Replication

```sql
-- Master setup
-- postgresql.conf
wal_level = replica
max_wal_senders = 3

-- pg_hba.conf
host replication replica_user 192.168.1.0/24 md5

-- Create replica user
CREATE USER replica_user REPLICATION LOGIN PASSWORD 'password';
```

### MySQL Replication

```sql
-- Master setup
-- my.cnf
[mysqld]
log-bin=mysql-bin
server-id=1

-- Create replica user
CREATE USER 'replica'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%';
```

## 🔐 Backup Security

```bash
# Encrypt backups
pg_dump -U postgres myapp | gpg --encrypt --recipient backup@example.com > backup.sql.gpg

# Decrypt and restore
gpg --decrypt backup.sql.gpg | psql -U postgres myapp
```

## 📦 Cloud Backups

### AWS S3

```bash
# Upload to S3
aws s3 cp backup.sql s3://my-backup-bucket/$(date +%Y%m%d)/backup.sql

# Automated script
pg_dump myapp | gzip | aws s3 cp - s3://bucket/backup-$(date +%Y%m%d).sql.gz
```

---

**Next**: Learn about [Recovery Procedures](./RECOVERY-PROCEDURES.md)

