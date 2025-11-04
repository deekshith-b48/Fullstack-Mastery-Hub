# Backup Verification

## 📚 Overview

Verifying backups ensures they can be restored successfully. This guide covers backup verification procedures and best practices.

## ✅ Verification Methods

### Integrity Checks

```bash
# PostgreSQL: Verify backup file
pg_restore --list backup.dump > /dev/null
if [ $? -eq 0 ]; then
    echo "Backup is valid"
else
    echo "Backup is corrupted"
fi

# MySQL: Verify backup
mysqlcheck --check-all-databases
```

### Test Restores

```bash
# Test restore to separate database
createdb test_restore
pg_restore -d test_restore backup.dump

# Verify data
psql -d test_restore -c "SELECT COUNT(*) FROM users;"

# Cleanup
dropdb test_restore
```

### Checksum Verification

```bash
# Generate checksum
md5sum backup.sql > backup.sql.md5

# Verify checksum
md5sum -c backup.sql.md5

# SHA256 checksum
sha256sum backup.sql > backup.sql.sha256
sha256sum -c backup.sql.sha256
```

## 🔍 Automated Verification

### Script Example

```bash
#!/bin/bash
BACKUP_FILE="backup_$(date +%Y%m%d).sql"
CHECKSUM_FILE="${BACKUP_FILE}.md5"

# Create backup
pg_dump myapp > $BACKUP_FILE

# Generate checksum
md5sum $BACKUP_FILE > $CHECKSUM_FILE

# Verify
if md5sum -c $CHECKSUM_FILE; then
    echo "Backup verified successfully"
else
    echo "Backup verification failed"
    exit 1
fi

# Test restore
createdb test_verify
pg_restore -d test_verify $BACKUP_FILE
if [ $? -eq 0 ]; then
    echo "Restore test passed"
    dropdb test_verify
else
    echo "Restore test failed"
    exit 1
fi
```

## 📊 Verification Schedule

### Recommended

1. **After each backup**: Verify checksum
2. **Weekly**: Test restore to separate database
3. **Monthly**: Full restore test
4. **Quarterly**: Disaster recovery drill

## 🎯 Best Practices

1. **Verify every backup**
2. **Test restores regularly**
3. **Use checksums**
4. **Automate verification**
5. **Document procedures**

---

**Next**: Continue learning about backup and recovery.

