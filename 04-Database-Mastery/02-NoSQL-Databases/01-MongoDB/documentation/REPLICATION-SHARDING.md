# MongoDB Replication & Sharding

## 📚 Overview

MongoDB replication provides high availability through replica sets, while sharding enables horizontal scaling across multiple servers.

## 🔄 Replica Sets

### Setup Replica Set

```javascript
// Start MongoDB with replica set
mongod --replSet "rs0" --port 27017

// Initialize replica set
rs.initiate({
    _id: "rs0",
    members: [
        { _id: 0, host: "localhost:27017" },
        { _id: 1, host: "localhost:27018" },
        { _id: 2, host: "localhost:27019" }
    ]
})

// Add member
rs.add("localhost:27020")

// Remove member
rs.remove("localhost:27020")
```

### Replica Set Status

```javascript
// Check replica set status
rs.status()

// Check configuration
rs.conf()

// Check if primary
rs.isMaster()
```

### Read Preferences

```javascript
// Read from primary (default)
db.employees.find().readPref("primary")

// Read from secondary
db.employees.find().readPref("secondary")

// Read from nearest
db.employees.find().readPref("nearest")
```

## 📊 Sharding

### Enable Sharding

```javascript
// Enable sharding for database
sh.enableSharding("myapp")

// Shard collection
sh.shardCollection("myapp.employees", { department: 1 })

// Add shard
sh.addShard("shard1/rs1/localhost:27017")
```

### Shard Key Selection

```javascript
// Good shard key: high cardinality, even distribution
sh.shardCollection("myapp.employees", { email: "hashed" })

// Compound shard key
sh.shardCollection("myapp.employees", { department: 1, _id: 1 })
```

### Sharding Status

```javascript
// Check sharding status
sh.status()

// Check chunk distribution
sh.getBalancerState()
```

## 🎯 Best Practices

1. **Use replica sets** for high availability
2. **Choose appropriate shard key** for even distribution
3. **Monitor replica lag** regularly
4. **Balance shard chunks** automatically
5. **Plan for network partitions**

---

**Next**: Learn about [Transactions](./TRANSACTIONS-MONGODB.md)

