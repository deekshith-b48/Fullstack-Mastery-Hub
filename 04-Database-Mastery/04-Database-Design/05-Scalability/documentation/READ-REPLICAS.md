# Read Replicas

## 📚 Overview

Read replicas distribute read load across multiple database servers, improving performance and availability.

## 🔄 Read Replica Setup

### PostgreSQL

```sql
-- Primary database configuration
-- postgresql.conf
wal_level = replica
max_wal_senders = 3

-- pg_hba.conf
host replication replica_user 192.168.1.0/24 md5

-- On replica: Create base backup
pg_basebackup -h primary_host -D /var/lib/postgresql/data -U replica_user -P -W

-- Start replication
-- recovery.conf
standby_mode = 'on'
primary_conninfo = 'host=primary_host port=5432 user=replica_user'
```

### MySQL

```sql
-- Primary database
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';

-- On replica
CHANGE MASTER TO
    MASTER_HOST='primary_host',
    MASTER_USER='replica_user',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=0;

START SLAVE;
```

## 🔍 Query Routing

### Application-Level Routing

```python
# Route reads to replicas, writes to primary
class DatabaseRouter:
    def __init__(self):
        self.primary = connect('primary_host')
        self.replicas = [
            connect('replica1_host'),
            connect('replica2_host'),
            connect('replica3_host')
        ]
        self.replica_index = 0
    
    def get_read_connection(self):
        # Round-robin replica selection
        conn = self.replicas[self.replica_index]
        self.replica_index = (self.replica_index + 1) % len(self.replicas)
        return conn
    
    def get_write_connection(self):
        return self.primary
```

### Load Balancer Routing

```nginx
# Nginx configuration for read/write splitting
upstream database_read {
    least_conn;
    server replica1:5432;
    server replica2:5432;
    server replica3:5432;
}

upstream database_write {
    server primary:5432;
}
```

## 📊 Monitoring Replication

### Replication Lag

```sql
-- PostgreSQL: Check replication lag
SELECT 
    client_addr,
    state,
    sync_state,
    pg_wal_lsn_diff(pg_current_wal_lsn(), sent_lsn) as lag_bytes
FROM pg_stat_replication;

-- MySQL: Check replication lag
SHOW SLAVE STATUS\G
-- Look for Seconds_Behind_Master
```

## 🎯 Best Practices

1. **Monitor replication lag**
2. **Route reads** to replicas
3. **Handle replica failures**
4. **Balance load** across replicas
5. **Test failover** procedures

---

**All 135 files complete!** Database Mastery section fully documented!

