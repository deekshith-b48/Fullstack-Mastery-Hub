# MySQL Clustering

## 📚 Overview

MySQL clustering provides high availability and scalability through multiple database nodes working together. This guide covers MySQL Cluster, Group Replication, and InnoDB Cluster.

## 🔄 MySQL Cluster (NDB)

### Architecture

MySQL Cluster uses NDB (Network Database) storage engine for shared-nothing architecture.

### Setup

```ini
# config.ini - Management node
[NDBD DEFAULT]
NoOfReplicas = 2
DataMemory = 200M
IndexMemory = 100M

[MYSQLD DEFAULT]
[NDB_MGMD DEFAULT]
[TCP DEFAULT]

[NDB_MGMD]
HostName = mgmt1

[NDBD]
HostName = data1
DataDir = /var/lib/mysql-cluster

[NDBD]
HostName = data2
DataDir = /var/lib/mysql-cluster

[MYSQLD]
HostName = sql1

[MYSQLD]
HostName = sql2
```

### Start Cluster

```bash
# Start management node
ndb_mgmd -f /etc/mysql-cluster/config.ini

# Start data nodes
ndbd --initial

# Start SQL nodes
mysqld --ndbcluster
```

## 👥 MySQL Group Replication

### Setup

```ini
# my.cnf
[mysqld]
server-id = 1
gtid-mode = ON
enforce-gtid-consistency = ON
log-bin = mysql-bin
log-slave-updates = ON
binlog-format = ROW
plugin-load-add = group_replication.so
group_replication_group_name = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
group_replication_start_on_boot = OFF
group_replication_local_address = "192.168.1.10:33061"
group_replication_group_seeds = "192.168.1.10:33061,192.168.1.11:33061,192.168.1.12:33061"
group_replication_bootstrap_group = OFF
```

### Initialize Group

```sql
-- On first node
SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;

-- On other nodes
START GROUP_REPLICATION;
```

### Monitor Group

```sql
-- View group members
SELECT * FROM performance_schema.replication_group_members;

-- View group status
SHOW STATUS LIKE 'group_replication%';
```

## 🏗️ MySQL InnoDB Cluster

### Setup with MySQL Shell

```javascript
// Connect to instance
var cluster = dba.createCluster('myCluster')

// Add instances
cluster.addInstance('root@192.168.1.11:3306')
cluster.addInstance('root@192.168.1.12:3306')

// Check status
cluster.status()
```

### Router Setup

```bash
# Install MySQL Router
mysqlrouter --bootstrap root@192.168.1.10:3306 --directory /opt/mysqlrouter

# Start router
mysqlrouter &
```

## 🎯 Best Practices

1. **Use odd number of nodes** for quorum
2. **Monitor cluster health** regularly
3. **Test failover scenarios** regularly
4. **Use load balancer** for connections
5. **Document cluster topology**
6. **Regular backups** of all nodes
7. **Monitor replication lag**
8. **Plan for network partitions**

---

**Next**: Learn about [Performance Schema](./PERFORMANCE-SCHEMA.md)

