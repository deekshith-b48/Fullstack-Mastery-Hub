# PostgreSQL Replication & High Availability

## 📚 Overview

PostgreSQL replication enables data to be copied from one database server to another, providing high availability, load distribution, and disaster recovery capabilities. This guide covers streaming replication, logical replication, and high availability setups.

## 🔄 Replication Types

### Physical Replication (Streaming)

Physical replication replicates entire database clusters at the block level. It's fast and reliable but requires identical PostgreSQL versions.

### Logical Replication

Logical replication replicates specific tables or databases using WAL (Write-Ahead Log) decoding. It's more flexible and allows selective replication.

## 🚀 Streaming Replication Setup

### Primary Server Configuration

```bash
# postgresql.conf
wal_level = replica                    # or 'logical' for logical replication
max_wal_senders = 3                    # Number of replication connections
wal_keep_segments = 16                 # Keep WAL segments (PostgreSQL < 13)
wal_keep_size = 1GB                    # Keep WAL size (PostgreSQL 13+)
hot_standby = on                       # Allow read queries on standby
```

### pg_hba.conf Configuration

```bash
# Allow replication connections
host replication replicator 192.168.1.0/24 md5
```

### Create Replication User

```sql
-- Create replication user
CREATE USER replicator WITH REPLICATION PASSWORD 'replication_password';

-- Grant necessary privileges
GRANT CONNECT ON DATABASE myapp TO replicator;
```

### Standby Server Setup

```bash
# Backup primary database
pg_basebackup -h primary_host -D /var/lib/postgresql/data -U replicator -v -P -W

# Or using pg_basebackup with streaming
pg_basebackup -h primary_host -D /var/lib/postgresql/data \
  -U replicator -v -P -W -R --wal-method=stream
```

### recovery.conf (PostgreSQL < 12)

```conf
# recovery.conf
standby_mode = 'on'
primary_conninfo = 'host=primary_host port=5432 user=replicator password=replication_password'
trigger_file = '/tmp/postgresql.trigger.5432'
```

### postgresql.auto.conf (PostgreSQL 12+)

```sql
-- PostgreSQL 12+ uses postgresql.auto.conf
-- Created automatically by pg_basebackup -R
primary_conninfo = 'host=primary_host port=5432 user=replicator password=replication_password'
```

### Start Standby Server

```bash
# Start PostgreSQL on standby
systemctl start postgresql
```

## 📊 Monitoring Replication

### Check Replication Status

```sql
-- On primary: View replication slots
SELECT * FROM pg_replication_slots;

-- On primary: View replication statistics
SELECT 
    client_addr,
    state,
    sync_state,
    sync_priority,
    pg_wal_lsn_diff(pg_current_wal_lsn(), sent_lsn) AS lag_bytes
FROM pg_stat_replication;

-- On standby: Check recovery status
SELECT pg_is_in_recovery();

-- On standby: View WAL receiver status
SELECT * FROM pg_stat_wal_receiver;

-- Check replication lag
SELECT 
    EXTRACT(EPOCH FROM (now() - pg_last_xact_replay_timestamp())) AS lag_seconds;
```

### Replication Lag Monitoring

```sql
-- On primary: Check lag in bytes
SELECT 
    client_addr,
    state,
    pg_wal_lsn_diff(pg_current_wal_lsn(), sent_lsn) AS sent_lag_bytes,
    pg_wal_lsn_diff(sent_lsn, write_lsn) AS write_lag_bytes,
    pg_wal_lsn_diff(write_lsn, flush_lsn) AS flush_lag_bytes,
    pg_wal_lsn_diff(flush_lsn, replay_lsn) AS replay_lag_bytes
FROM pg_stat_replication;
```

## 🔄 Logical Replication

### Setup Logical Replication

```sql
-- On primary: Enable logical replication
ALTER SYSTEM SET wal_level = logical;
-- Restart PostgreSQL

-- On primary: Create publication
CREATE PUBLICATION myapp_pub FOR TABLE employees, departments;

-- Or publish all tables
CREATE PUBLICATION all_tables FOR ALL TABLES;

-- On subscriber: Create subscription
CREATE SUBSCRIPTION myapp_sub 
CONNECTION 'host=primary_host port=5432 user=replicator password=replication_password dbname=myapp'
PUBLICATION myapp_pub;
```

### Manage Publications

```sql
-- Add table to publication
ALTER PUBLICATION myapp_pub ADD TABLE products;

-- Remove table from publication
ALTER PUBLICATION myapp_pub DROP TABLE products;

-- View publications
SELECT * FROM pg_publication;

-- View publication tables
SELECT * FROM pg_publication_tables;
```

### Manage Subscriptions

```sql
-- View subscriptions
SELECT * FROM pg_subscription;

-- View subscription status
SELECT * FROM pg_stat_subscription;

-- Disable subscription
ALTER SUBSCRIPTION myapp_sub DISABLE;

-- Enable subscription
ALTER SUBSCRIPTION myapp_sub ENABLE;

-- Drop subscription
DROP SUBSCRIPTION myapp_sub;
```

## 🔀 Failover and Switchover

### Manual Failover

```sql
-- On standby: Promote to primary
SELECT pg_promote();

-- Or create trigger file
touch /tmp/postgresql.trigger.5432
```

### Automatic Failover with pg_auto_failover

```bash
# Install pg_auto_failover
# Create monitor node
pg_autoctl create monitor --pgdata /var/lib/postgresql/monitor

# Create primary node
pg_autoctl create postgres --pgdata /var/lib/postgresql/primary --monitor 'postgresql://monitor:5432/pg_auto_failover'

# Create standby node
pg_autoctl create postgres --pgdata /var/lib/postgresql/standby --monitor 'postgresql://monitor:5432/pg_auto_failover'
```

### Patroni for High Availability

```yaml
# patroni.yml
scope: myapp
namespace: /db/
name: postgresql1

restapi:
  listen: 0.0.0.0:8008
  connect_address: 192.168.1.10:8008

etcd3:
  host: 192.168.1.20:2379

bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 30
    maximum_lag_on_failover: 1048576
    postgresql:
      use_pg_rewind: true
      parameters:
        wal_level: replica
        hot_standby: "on"

postgresql:
  listen: 0.0.0.0:5432
  connect_address: 192.168.1.10:5432
  data_dir: /var/lib/postgresql/data
  pgpass: /tmp/pgpass
  authentication:
    replication:
      username: replicator
      password: replication_password
    superuser:
      username: postgres
      password: postgres_password
```

## 📈 Read Replicas

### Setup Read Replica

```bash
# Create read replica (same as streaming replication)
pg_basebackup -h primary_host -D /var/lib/postgresql/data \
  -U replicator -v -P -W -R --wal-method=stream
```

### Load Balancing

```nginx
# nginx.conf for load balancing read replicas
upstream postgres_read {
    least_conn;
    server standby1:5432;
    server standby2:5432;
    server standby3:5432;
}

server {
    listen 5432;
    proxy_pass postgres_read;
}
```

## 🔐 Replication Security

### SSL/TLS Configuration

```bash
# postgresql.conf
ssl = on
ssl_cert_file = '/etc/ssl/certs/server.crt'
ssl_key_file = '/etc/ssl/private/server.key'

# pg_hba.conf
hostssl replication replicator 192.168.1.0/24 md5
```

### Network Security

```bash
# Use firewall rules
# Allow replication only from trusted IPs
# Use VPN for replication traffic
# Encrypt replication connections
```

## 🎯 Best Practices

1. **Monitor replication lag**: Set up alerts for lag thresholds
2. **Test failover regularly**: Ensure failover procedures work
3. **Use replication slots**: Prevent WAL deletion
4. **Monitor disk space**: Ensure WAL segments don't fill disk
5. **Backup standby servers**: Have backups of replicas
6. **Use connection pooling**: Route reads to replicas
7. **Document procedures**: Document failover steps
8. **Regular testing**: Test disaster recovery scenarios
9. **Monitor replication slots**: Prevent slot growth
10. **Use appropriate sync level**: Balance performance and durability

---

**Next**: Learn about [Security Best Practices](./SECURITY-BEST-PRACTICES.md)

