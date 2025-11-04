# Backup Retention Policies

## 📚 Overview

Retention policies determine how long backups are kept. This guide covers retention strategies and best practices.

## 📅 Retention Strategies

### Tiered Retention

```bash
# Daily backups: Keep 7 days
# Weekly backups: Keep 4 weeks
# Monthly backups: Keep 12 months
# Yearly backups: Keep indefinitely

# Cleanup script
find /backup/daily -name "*.sql.gz" -mtime +7 -delete
find /backup/weekly -name "*.sql.gz" -mtime +30 -delete
find /backup/monthly -name "*.sql.gz" -mtime +365 -delete
```

### Compliance-Based Retention

```bash
# Regulatory requirements
# Financial data: 7 years
# Healthcare data: 6 years
# General business: 3 years

# Retention based on data type
if [ "$DATA_TYPE" == "financial" ]; then
    RETENTION_DAYS=2555  # 7 years
elif [ "$DATA_TYPE" == "healthcare" ]; then
    RETENTION_DAYS=2190  # 6 years
else
    RETENTION_DAYS=1095  # 3 years
fi
```

## 📊 Storage Optimization

### Compression

```bash
# Compress backups
gzip backup.sql

# Archive old backups
tar -czf backup_2024_01.tar.gz backup_*.sql.gz
```

### Deduplication

```bash
# Use deduplication for incremental backups
# Only store changed blocks
rsync --backup --backup-dir=../backup_$(date +%Y%m%d) source/ dest/
```

## 🎯 Best Practices

1. **Define retention** based on needs
2. **Automate cleanup** of old backups
3. **Document retention** policies
4. **Verify backups** before deletion
5. **Comply with regulations**

---

**Next**: Continue learning about backup and recovery.

