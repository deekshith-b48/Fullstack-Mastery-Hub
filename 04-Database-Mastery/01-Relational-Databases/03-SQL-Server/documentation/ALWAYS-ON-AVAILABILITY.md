# SQL Server Always On Availability

## 📚 Overview

Always On Availability Groups provide high availability and disaster recovery solutions for SQL Server. This guide covers setup, configuration, and management.

## 🚀 Setup

### Enable Always On

```sql
-- Enable Always On Availability Groups
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'always on availability groups', 1;
RECONFIGURE;
```

### Create Availability Group

```sql
-- Create availability group
CREATE AVAILABILITY GROUP MyAG
WITH (
    AUTOMATED_BACKUP_PREFERENCE = PRIMARY,
    FAILOVER_MODE = AUTOMATIC,
    HEALTH_CHECK_TIMEOUT = 30000
)
FOR DATABASE myapp
REPLICA ON
    'Server1' WITH (
        ENDPOINT_URL = 'TCP://server1:5022',
        AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
        FAILOVER_MODE = AUTOMATIC,
        SEEDING_MODE = AUTOMATIC
    ),
    'Server2' WITH (
        ENDPOINT_URL = 'TCP://server2:5022',
        AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
        FAILOVER_MODE = AUTOMATIC,
        SEEDING_MODE = AUTOMATIC
    );
```

### Add Replica

```sql
-- Add replica to existing group
ALTER AVAILABILITY GROUP MyAG
ADD REPLICA ON 'Server3' WITH (
    ENDPOINT_URL = 'TCP://server3:5022',
    AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,
    FAILOVER_MODE = MANUAL
);
```

## 🔄 Failover

```sql
-- Manual failover
ALTER AVAILABILITY GROUP MyAG FAILOVER;

-- Force failover (data loss possible)
ALTER AVAILABILITY GROUP MyAG FORCE_FAILOVER_ALLOW_DATA_LOSS;
```

## 📊 Monitoring

```sql
-- View availability group status
SELECT * FROM sys.dm_hadr_availability_group_states;

-- View replica status
SELECT * FROM sys.dm_hadr_availability_replica_states;

-- View database replica states
SELECT * FROM sys.dm_hadr_database_replica_states;
```

## 🎯 Best Practices

1. **Use synchronous commit** for zero data loss
2. **Monitor health** regularly
3. **Test failover** procedures
4. **Plan for network** partitions
5. **Document configuration** thoroughly

---

**Next**: Learn about [Security](./SECURITY-SQL-SERVER.md)

