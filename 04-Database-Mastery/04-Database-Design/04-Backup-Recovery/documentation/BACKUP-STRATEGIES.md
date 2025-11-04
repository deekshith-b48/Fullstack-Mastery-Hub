# Database Backup Strategies

## 📚 Overview

Backup strategies ensure data can be recovered in case of failures. This guide covers different backup types and strategies.

## 💾 Backup Types

### Full Backup

```bash
# Complete database backup
pg_dump -U postgres myapp > backup.sql

# Restore
psql -U postgres myapp < backup.sql
```

**Characteristics:**
- Complete database copy
- Slowest backup type
- Requires most storage
- Fastest restore

### Incremental Backup

```bash
# Backup only changes since last backup
# Depends on previous backups
```

**Characteristics:**
- Only changed data
- Faster backup
- Requires multiple backups for restore

### Differential Backup

```bash
# Backup changes since last full backup
```

**Characteristics:**
- Changes since last full backup
- Faster than full backup
- Simpler restore than incremental

## 🔄 Backup Schedule

### Recommended Strategy

1. **Daily full backups** (off-peak hours)
2. **Hourly incremental backups**
3. **Transaction log backups** (every 15-30 minutes)

## 📊 Backup Storage

### Locations

- **On-site**: Fast access, vulnerable to disasters
- **Off-site**: Protected from disasters, slower access
- **Cloud**: Scalable, accessible, cost-effective

## 🎯 Best Practices

1. **Test backups regularly**
2. **Store backups off-site**
3. **Automate backup process**
4. **Monitor backup success**
5. **Document restore procedures**
6. **Encrypt sensitive backups**
7. **Version backups** for point-in-time recovery

---

**Next**: Learn about [Recovery Procedures](./RECOVERY-PROCEDURES.md)

