# Load Balancing Strategies

## 📚 Overview

Load balancing distributes incoming network traffic across multiple servers to ensure optimal resource utilization and high availability.

## 🎯 Load Balancing Algorithms

### Round Robin

Distributes requests sequentially to each server.

```javascript
// Simple round-robin implementation
class RoundRobinBalancer {
  constructor(servers) {
    this.servers = servers;
    this.currentIndex = 0;
  }
  
  getNextServer() {
    const server = this.servers[this.currentIndex];
    this.currentIndex = (this.currentIndex + 1) % this.servers.length;
    return server;
  }
}
```

**Use Case**: When all servers have similar capacity

### Least Connections

Routes traffic to the server with the fewest active connections.

```javascript
class LeastConnectionsBalancer {
  constructor(servers) {
    this.servers = servers.map(s => ({
      server: s,
      connections: 0
    }));
  }
  
  getNextServer() {
    return this.servers
      .sort((a, b) => a.connections - b.connections)[0]
      .server;
  }
}
```

**Use Case**: Long-lived connections (WebSockets, database connections)

### Weighted Round Robin

Distributes requests based on server capacity/weight.

```javascript
class WeightedRoundRobinBalancer {
  constructor(servers) {
    this.servers = servers; // [{server, weight}, ...]
    this.currentIndex = 0;
    this.currentWeight = 0;
  }
  
  getNextServer() {
    while (true) {
      const server = this.servers[this.currentIndex];
      if (this.currentWeight === 0) {
        this.currentWeight = server.weight;
      }
      
      if (this.currentWeight > 0) {
        this.currentWeight--;
        return server.server;
      }
      
      this.currentIndex = (this.currentIndex + 1) % this.servers.length;
      if (this.currentIndex === 0) {
        this.currentWeight = Math.max(...this.servers.map(s => s.weight));
      }
    }
  }
}
```

**Use Case**: Servers with different capacities

### IP Hash

Routes based on client IP address hash.

```javascript
function hashIP(ip) {
  return ip.split('.').reduce((acc, octet) => {
    return ((acc << 8) + parseInt(octet)) % 2147483647;
  }, 0);
}

function getServerByIP(ip, servers) {
  const hash = hashIP(ip);
  return servers[hash % servers.length];
}
```

**Use Case**: Session persistence, caching benefits

## 🏗️ Load Balancer Types

### Layer 4 (Transport Layer)

Operates on TCP/UDP level.

```javascript
// Simple TCP load balancer
const servers = ['192.168.1.10', '192.168.1.11', '192.168.1.12'];

function handleConnection(clientSocket) {
  const server = getNextServer();
  const serverSocket = net.connect(serverPort, server);
  
  clientSocket.pipe(serverSocket);
  serverSocket.pipe(clientSocket);
}
```

**Pros**: Fast, simple
**Cons**: No content awareness

### Layer 7 (Application Layer)

Operates on HTTP level, can make routing decisions based on content.

```javascript
// HTTP load balancer
app.use((req, res, next) => {
  const server = routeRequest(req);
  proxy.web(req, res, { target: server });
});

function routeRequest(req) {
  // Route based on path
  if (req.path.startsWith('/api/users')) {
    return userServiceServer;
  }
  if (req.path.startsWith('/api/products')) {
    return productServiceServer;
  }
  return defaultServer;
}
```

**Pros**: Content-aware routing, SSL termination
**Cons**: More complex, higher overhead

## 🔧 Load Balancer Features

### Health Checks

```javascript
async function checkServerHealth(server) {
  try {
    const response = await fetch(`http://${server}/health`, {
      timeout: 5000
    });
    return response.status === 200;
  } catch (error) {
    return false;
  }
}

// Periodic health checks
setInterval(async () => {
  for (const server of servers) {
    const healthy = await checkServerHealth(server);
    if (!healthy) {
      removeFromPool(server);
    } else {
      addToPool(server);
    }
  }
}, 10000); // Check every 10 seconds
```

### Session Persistence

```javascript
// Sticky sessions using cookies
app.use((req, res, next) => {
  let serverId = req.cookies.server_id;
  
  if (!serverId || !isServerHealthy(serverId)) {
    serverId = getNextServer();
    res.cookie('server_id', serverId, { maxAge: 3600000 }); // 1 hour
  }
  
  req.targetServer = serverId;
  next();
});
```

### SSL Termination

```javascript
// SSL termination at load balancer
const https = require('https');
const express = require('express');

const app = express();

// Load balancer handles SSL
const server = https.createServer({
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem')
}, app);

// Backend servers use HTTP (internal network)
```

## 🌐 CDN Integration

```javascript
// Route static content to CDN
app.use('/static', (req, res, next) => {
  if (isStaticFile(req.path)) {
    res.redirect(`https://cdn.example.com${req.path}`);
  } else {
    next();
  }
});
```

## 📊 Monitoring

```javascript
// Track metrics
const metrics = {
  requestsPerServer: {},
  responseTimes: {},
  errors: {}
};

function trackRequest(server, responseTime, success) {
  metrics.requestsPerServer[server] = 
    (metrics.requestsPerServer[server] || 0) + 1;
  
  if (!metrics.responseTimes[server]) {
    metrics.responseTimes[server] = [];
  }
  metrics.responseTimes[server].push(responseTime);
  
  if (!success) {
    metrics.errors[server] = (metrics.errors[server] || 0) + 1;
  }
}
```

---

**Next**: Learn about [Caching Strategies](./CACHING-STRATEGIES.md)

