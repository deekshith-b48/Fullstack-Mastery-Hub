# Node.js Load Balancing

## 📚 Overview

Load balancing distributes incoming requests across multiple servers.

## 🎯 Types of Load Balancing

### 1. Cluster Module (Built-in)

```javascript
const cluster = require('cluster');
const numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  require('./server.js');
}
```

### 2. PM2 Load Balancing

```bash
# Start with load balancing
pm2 start app.js -i max

# Or specify instances
pm2 start app.js -i 4
```

### 3. Nginx Load Balancing

```nginx
upstream backend {
  server localhost:3000;
  server localhost:3001;
  server localhost:3002;
}

server {
  location / {
    proxy_pass http://backend;
  }
}
```

### 4. Load Balancing Algorithms

- **Round Robin**: Distributes requests evenly
- **Least Connections**: Routes to server with fewest connections
- **IP Hash**: Routes based on client IP
- **Weighted**: Assigns different weights to servers

---

**Next**: Learn about [Node.js Ecosystem](./../04-Node-Ecosystem/documentation/NPM-PACKAGE-DEVELOPMENT.md)

