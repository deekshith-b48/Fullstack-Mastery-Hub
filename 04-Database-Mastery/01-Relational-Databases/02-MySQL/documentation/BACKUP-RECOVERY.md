# MySQL Backup & Recovery

## 📚 Overview

Regular backups are essential for data protection and disaster recovery. This guide covers MySQL backup strategies, tools, and recovery procedures.

## 💾 Backup Types

### Logical Backups

Logical backups contain SQL statements to recreate database objects and data.

### Physical Backups

Physical backups copy the actual database files and directories.

## 🔧 mysqldump

### Basic Backup

```bash
# Backup entire database
mysqldump -u root -p myapp > backup.sql

# Backup specific database
mysqldump -u root -p --databases myapp > backup.sql

# Backup all databases
mysqldump -u root -p --all-databases > all_databases.sql

# Backup specific tables
mysqldump -u root -p myapp employees departments > backup.sql
```

### Backup Options

```bash
# Backup with structure and data
mysqldump -u root -p --single-transaction --routines --triggers myapp > backup.sql

# Backup with compression
mysqldump -u root -p myapp | gzip > backup.sql.gz

# Backup with timestamp
mysqldump -u root -p myapp > backup_$(date +%Y%m%d_%H%M%S).sql

# Backup with consistent snapshot
mysqldump -u root -p --single-transaction myapp > backup.sql
```

### Restore from Backup

```bash
# Restore database
mysql -u root -p myapp < backup.sql

# Restore all databases
mysql -u root -p < all_databases.sql

# Restore specific tables
mysql -u root -p myapp < employees_backup.sql
```

## 📦 mysqlpump

```bash
# Parallel backup (MySQL 5.7+)
mysqlpump -u root -p --parallel-schemas=4 myapp > backup.sql

# Backup with compression
mysqlpump -u root -p --compress-output=ZLIB myapp > backup.zlib

# Decompress and restore
zlib_decompress backup.zlib backup.sql
mysql -u root -p myapp < backup.sql
```

## 💿 Physical Backups

### Percona XtraBackup

```bash
# Full backup
xtrabackup --backup --target-dir=/backup/full

# Incremental backup
xtrabackup --backup --target-dir=/backup/inc1 \
    --incremental-basedir=/backup/full

# Prepare backup
xtrabackup --prepare --target-dir=/backup/full

# Restore
xtrabackup --copy-back --target-dir=/backup/full
```

### MySQL Enterprise Backup

```bash
# Full backup
mysqlbackup --backup-dir=/backup backup

# Restore
mysqlbackup --backup-dir=/backup copy-back
```

## 🔄 Binary Log Backup

### Enable Binary Logging

```ini
# my.cnf
[mysqld]
log-bin = mysql-bin
binlog-format = ROW
```

### Backup Binary Logs

```bash
# Backup binary logs
mysqlbinlog mysql-bin.000001 > binlog_backup.sql
mysqlbinlog mysql-bin.000002 >> binlog_backup.sql

# Backup all binary logs
mysqlbinlog --read-from-remote-server \
    --host=localhost --user=root --password \
    mysql-bin.000001 > binlog_backup.sql
```

### Point-in-Time Recovery

```bash
# Restore full backup
mysql -u root -p myapp < full_backup.sql

# Apply binary logs up to specific time
mysqlbinlog --stop-datetime="2024-01-15 14:30:00" \
    mysql-bin.000001 mysql-bin.000002 | mysql -u root -p

# Or apply up to specific position
mysqlbinlog --stop-position=123456 \
    mysql-bin.000001 | mysql -u root -p
```

## 📅 Automated Backups

### Cron Job

```bash
# Daily backup script
#!/bin/bash
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u root -p'password' --all-databases | gzip > $BACKUP_DIR/backup_$DATE.sql.gz
find $BACKUP_DIR -name "backup_*.sql.gz" -mtime +7 -delete

# Add to crontab
0 2 * * * /path/to/backup_script.sh
```

## 🔄 Recovery Procedures

### Complete Recovery

```bash
# 1. Stop MySQL
systemctl stop mysql

# 2. Restore from backup
mysql -u root -p < full_backup.sql

# 3. Apply binary logs
mysqlbinlog mysql-bin.000001 | mysql -u root -p

# 4. Start MySQL
systemctl start mysql
```

### Table-Level Recovery

```bash
# Restore specific table
mysql -u root -p myapp < employees_backup.sql

# Or from full backup
mysql -u root -p myapp employees < full_backup.sql
```

## 🎯 Best Practices

1. **Regular backups**: Daily at minimum
2. **Test restores**: Verify backups work
3. **Multiple locations**: Store backups offsite
4. **Retention policy**: Keep multiple backup versions
5. **Monitor backup size**: Ensure sufficient disk space
6. **Document procedures**: Document restore steps
7. **Automate backups**: Use cron or scheduling tools
8. **Encrypt backups**: Protect sensitive data
9. **Monitor backup logs**: Check for errors
10. **Regular testing**: Test disaster recovery scenarios

---

**Next**: Learn about [MySQL Clustering](./CLUSTERING-MYSQL.md)

