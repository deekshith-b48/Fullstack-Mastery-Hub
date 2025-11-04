# SQL Server Maintenance Plans

## 📚 Overview

Maintenance plans automate routine database maintenance tasks like backups, index rebuilding, and statistics updates. This guide covers creating and managing maintenance plans.

## 🎯 Creating Maintenance Plans

### Using SQL Server Management Studio

1. Right-click Maintenance Plans → New Maintenance Plan
2. Configure tasks (Backup, Rebuild Index, Update Statistics)
3. Schedule the plan
4. Save and enable

### Maintenance Plan Tasks

- **Back Up Database**: Full, differential, transaction log backups
- **Rebuild Index**: Rebuild indexes to reduce fragmentation
- **Reorganize Index**: Reorganize indexes without rebuilding
- **Update Statistics**: Update table and index statistics
- **Check Database Integrity**: Verify database integrity
- **Shrink Database**: Reduce database file size
- **Clean Up History**: Remove old maintenance history

## 📊 Best Practices

1. **Schedule during low usage** periods
2. **Test plans** before production
3. **Monitor plan execution** regularly
4. **Document maintenance procedures**
5. **Keep maintenance history** for troubleshooting

---

**Next**: Learn about [Always On Availability](./ALWAYS-ON-AVAILABILITY.md)

