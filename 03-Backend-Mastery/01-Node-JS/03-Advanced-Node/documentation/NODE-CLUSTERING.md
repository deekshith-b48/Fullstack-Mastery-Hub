# Node.js Clustering

## 📚 Overview

Clustering allows Node.js to take advantage of multi-core systems by creating child processes.

## 🎯 Basic Clustering

```javascript
const cluster = require('cluster');
const http = require('http');
const numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
  console.log(`Master ${process.pid} is running`);
  
  // Fork workers
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  
  cluster.on('exit', (worker, code, signal) => {
    console.log(`Worker ${worker.process.pid} died`);
    cluster.fork(); // Restart worker
  });
} else {
  // Workers can share TCP connection
  http.createServer((req, res) => {
    res.writeHead(200);
    res.end('Hello World');
  }).listen(8000);
  
  console.log(`Worker ${process.pid} started`);
}
```

## 🔄 Worker Communication

```javascript
if (cluster.isMaster) {
  const worker = cluster.fork();
  
  worker.send({ message: 'Hello from master' });
  
  worker.on('message', (msg) => {
    console.log('Message from worker:', msg);
  });
} else {
  process.on('message', (msg) => {
    console.log('Message from master:', msg);
    process.send({ message: 'Hello from worker' });
  });
}
```

## 🎯 Load Balancing

```javascript
// Cluster automatically load balances
// Each worker handles requests independently
if (cluster.isMaster) {
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  // Worker handles requests
  require('./server.js');
}
```

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

