# MongoDB Atlas Cloud

## 📚 Overview

MongoDB Atlas is a fully managed cloud database service that handles deployment, scaling, and management of MongoDB clusters.

## 🚀 Getting Started

### Create Cluster

1. Sign up at mongodb.com/cloud/atlas
2. Create new cluster
3. Choose cloud provider (AWS, Azure, GCP)
4. Select region and cluster tier
5. Configure cluster settings

### Connect to Atlas

```javascript
// Connection string
const uri = "mongodb+srv://username:password@cluster.mongodb.net/myapp?retryWrites=true&w=majority"

// Connect
const client = new MongoClient(uri)
await client.connect()
```

## 🔧 Atlas Features

### Automated Backups

- Continuous backups
- Point-in-time recovery
- Automated backup scheduling

### Monitoring

- Real-time performance metrics
- Alert configuration
- Query performance insights

### Scaling

- Scale up/down cluster tier
- Add/remove replica set members
- Configure auto-scaling

## 🎯 Best Practices

1. **Use connection string** with SRV records
2. **Configure IP whitelist** for security
3. **Enable backups** for production
4. **Monitor performance** regularly
5. **Set up alerts** for critical metrics

---

**MongoDB section complete!** Next: Learn about [Redis](./../02-Redis/documentation/REDIS-FUNDAMENTALS.md)

