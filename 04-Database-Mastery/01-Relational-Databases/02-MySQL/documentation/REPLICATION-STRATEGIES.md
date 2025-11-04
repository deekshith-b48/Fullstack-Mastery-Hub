# MySQL Replication Strategies

## 📚 Overview

MySQL replication allows you to copy data from one MySQL server (master) to one or more MySQL servers (slaves/replicas). This guide covers replication setup, configuration, monitoring, and various replication strategies.

## 🔄 Replication Types

### Statement-Based Replication (SBR)

Replicates SQL statements as they were executed on the master.

### Row-Based Replication (RBR)

Replicates the actual row changes that occurred on the master.

### Mixed Replication

Uses statement-based replication by default, but automatically switches to row-based for certain statements.

## 🚀 Master-Slave Replication Setup

### Master Server Configuration

```ini
# my.cnf on master
[mysqld]
server-id = 1
log-bin = mysql-bin
binlog-format = ROW
expire_logs_days = 7
max_binlog_size = 100M
```

### Create Replication User

```sql
-- On master: Create replication user
CREATE USER 'replicator'@'%' IDENTIFIED BY 'replication_password';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;
```

### Get Master Status

```sql
-- On master: Get binary log position
SHOW MASTER STATUS;

-- Output:
-- File: mysql-bin.000001
-- Position: 154
-- Binlog_Do_DB:
-- Binlog_Ignore_DB:
```

### Slave Server Configuration

```ini
# my.cnf on slave
[mysqld]
server-id = 2
relay-log = mysql-relay-bin
log-slave-updates = 1
read-only = 1
```

### Configure Slave

```sql
-- On slave: Configure replication
CHANGE MASTER TO
    MASTER_HOST='master_host',
    MASTER_USER='replicator',
    MASTER_PASSWORD='replication_password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154;

-- Start replication
START SLAVE;

-- Check slave status
SHOW SLAVE STATUS\G
```

## 📊 Monitoring Replication

### Check Slave Status

```sql
-- View detailed replication status
SHOW SLAVE STATUS\G

-- Key fields:
-- Slave_IO_Running: Yes/No
-- Slave_SQL_Running: Yes/No
-- Seconds_Behind_Master: Replication lag
-- Last_IO_Error: IO thread errors
-- Last_SQL_Error: SQL thread errors
```

### Check Master Status

```sql
-- View master status
SHOW MASTER STATUS;

-- View binary logs
SHOW BINARY LOGS;

-- View binary log events
SHOW BINLOG EVENTS IN 'mysql-bin.000001';
```

### Monitor Replication Lag

```sql
-- Check replication lag
SELECT 
    TIMESTAMPDIFF(SECOND, 
        (SELECT MAX(Time) FROM mysql.slave_relay_log_info),
        NOW()) AS lag_seconds;

-- Or use Seconds_Behind_Master from SHOW SLAVE STATUS
```

## 🔀 Replication Topologies

### Master-Slave (Simple)

```
Master → Slave
```

### Master-Slave (Multiple Slaves)

```
        → Slave 1
Master → Slave 2
        → Slave 3
```

### Master-Master (Circular)

```
Master 1 ↔ Master 2
```

### Master-Master Setup

```sql
-- On both servers, configure as master and slave
-- Server 1
CHANGE MASTER TO
    MASTER_HOST='server2',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154;

-- Server 2
CHANGE MASTER TO
    MASTER_HOST='server1',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154;
```

### Chain Replication

```
Master → Slave 1 → Slave 2 → Slave 3
```

### Ring Replication

```
Master 1 → Master 2 → Master 3 → Master 1
```

## 🔧 Replication Configuration

### Filtering Replication

```sql
-- Replicate only specific databases
CHANGE MASTER TO
    -- ... other settings ...
    REPLICATE_DO_DB = myapp;

-- Or in my.cnf
replicate-do-db = myapp
replicate-ignore-db = test

-- Replicate specific tables
replicate-do-table = myapp.employees
replicate-ignore-table = myapp.logs
```

### Replication Options

```sql
-- Skip errors
SET GLOBAL sql_slave_skip_counter = 1;

-- Or in my.cnf
slave-skip-errors = 1062,1032

-- Stop replication
STOP SLAVE;

-- Reset replication
RESET SLAVE;
RESET SLAVE ALL;  -- Removes all replication configuration
```

## 🔄 GTID Replication (Global Transaction ID)

### Enable GTID

```ini
# my.cnf on master and slave
[mysqld]
gtid-mode = ON
enforce-gtid-consistency = ON
```

### Configure GTID Replication

```sql
-- On slave: Use GTID instead of log file/position
CHANGE MASTER TO
    MASTER_HOST='master_host',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_AUTO_POSITION = 1;

START SLAVE;
```

### GTID Benefits

- Automatic position tracking
- Easier failover
- Better consistency
- Simpler multi-source replication

## 📈 Multi-Source Replication

### Setup Multiple Masters

```sql
-- On slave: Configure multiple channels
CHANGE MASTER TO
    MASTER_HOST='master1',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154
FOR CHANNEL 'master1';

CHANGE MASTER TO
    MASTER_HOST='master2',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154
FOR CHANNEL 'master2';

-- Start all channels
START SLAVE FOR CHANNEL 'master1';
START SLAVE FOR CHANNEL 'master2';

-- Check status per channel
SHOW SLAVE STATUS FOR CHANNEL 'master1'\G
```

## 🔄 Failover and Switchover

### Manual Failover

```sql
-- On slave: Promote to master
STOP SLAVE;
RESET SLAVE ALL;
SET GLOBAL read_only = 0;

-- On applications: Update connection to new master
```

### Automatic Failover

Use MySQL Group Replication or MySQL InnoDB Cluster for automatic failover.

## 🎯 Best Practices

1. **Monitor replication lag** regularly
2. **Use GTID** for easier management
3. **Test failover procedures** regularly
4. **Backup master and slaves** regularly
5. **Monitor binary logs** disk space
6. **Use appropriate binlog format** (ROW recommended)
7. **Set read-only** on slaves
8. **Document replication topology**
9. **Monitor replication errors**
10. **Plan for replication lag** in applications

---

**Next**: Learn about [MySQL Security](./MYSQL-SECURITY.md)

