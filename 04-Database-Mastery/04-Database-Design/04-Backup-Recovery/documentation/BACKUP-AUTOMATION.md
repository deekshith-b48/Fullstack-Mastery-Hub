# Backup Automation

## 📚 Overview

Automating backups ensures consistent, reliable data protection. This guide covers backup automation strategies and tools.

## 🤖 Automation Strategies

### Cron Jobs

```bash
#!/bin/bash
# Daily backup script
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u root -p'password' --all-databases | gzip > $BACKUP_DIR/backup_$DATE.sql.gz

# Keep only last 7 days
find $BACKUP_DIR -name "backup_*.sql.gz" -mtime +7 -delete

# Add to crontab
# 0 2 * * * /path/to/backup_script.sh
```

### Database-Specific Tools

#### PostgreSQL

```bash
# pg_cron extension
CREATE EXTENSION pg_cron;

-- Schedule backup
SELECT cron.schedule(
    'daily-backup',
    '0 2 * * *',
    $$pg_dump -U postgres myapp > /backup/backup.sql$$
);
```

#### MySQL

```bash
# MySQL Event Scheduler
CREATE EVENT daily_backup
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
  CALL backup_database();
```

## ☁️ Cloud Backup Solutions

### AWS RDS

```bash
# Automated backups enabled by default
# Retention period: 1-35 days
# Point-in-time recovery available
```

### Azure SQL Database

```bash
# Automated backups
# Retention: 7-35 days
# Long-term retention available
```

## 📊 Monitoring

### Backup Verification

```bash
# Verify backup integrity
pg_restore --list backup.dump

# Test restore
pg_restore --dry-run backup.dump
```

### Alerting

```bash
# Send alert on backup failure
if [ $? -ne 0 ]; then
    echo "Backup failed!" | mail -s "Backup Alert" admin@example.com
fi
```

## 🎯 Best Practices

1. **Automate all backups**
2. **Verify backup integrity**
3. **Test restore procedures**
4. **Monitor backup success**
5. **Set up alerts** for failures
6. **Document** backup procedures

---

**Next**: Continue learning about backup and recovery.

