# Node.js Performance

## 📚 Overview

Performance optimization is crucial for scalable Node.js applications.

## 🎯 Performance Tips

### 1. Use Streams for Large Data

```javascript
// ❌ Bad - Loads entire file in memory
const data = fs.readFileSync('large-file.txt');
processData(data);

// ✅ Good - Processes in chunks
const stream = fs.createReadStream('large-file.txt');
stream.on('data', (chunk) => {
  processChunk(chunk);
});
```

### 2. Avoid Blocking Operations

```javascript
// ❌ Bad - Blocks event loop
function heavyComputation() {
  let result = 0;
  for (let i = 0; i < 1000000000; i++) {
    result += i;
  }
  return result;
}

// ✅ Good - Use worker threads or chunk
function heavyComputationAsync() {
  return new Promise((resolve) => {
    setImmediate(() => {
      let result = 0;
      for (let i = 0; i < 1000000; i++) {
        result += i;
      }
      resolve(result);
    });
  });
}
```

### 3. Connection Pooling

```javascript
// PostgreSQL with pg
const { Pool } = require('pg');

const pool = new Pool({
  max: 20, // Maximum connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Reuse connections
async function query(text, params) {
  const client = await pool.connect();
  try {
    return await client.query(text, params);
  } finally {
    client.release();
  }
}
```

### 4. Caching

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 }); // 10 minutes

async function getData(key) {
  let data = cache.get(key);
  if (!data) {
    data = await fetchFromDatabase(key);
    cache.set(key, data);
  }
  return data;
}
```

### 5. Clustering

```javascript
const cluster = require('cluster');
const numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
  // Fork workers
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  // Worker process
  require('./server.js');
}
```

## 📊 Monitoring

### Performance Monitoring

```javascript
// Measure execution time
const start = process.hrtime.bigint();

// Operation
await someOperation();

const end = process.hrtime.bigint();
const duration = Number(end - start) / 1000000; // milliseconds
console.log(`Operation took ${duration}ms`);
```

### Memory Usage

```javascript
const memoryUsage = process.memoryUsage();

console.log({
  rss: `${Math.round(memoryUsage.rss / 1024 / 1024)}MB`,
  heapTotal: `${Math.round(memoryUsage.heapTotal / 1024 / 1024)}MB`,
  heapUsed: `${Math.round(memoryUsage.heapUsed / 1024 / 1024)}MB`,
  external: `${Math.round(memoryUsage.external / 1024 / 1024)}MB`
});
```

---

**Next**: Learn about [Express.js](./../02-Express-JS/documentation/EXPRESS-FUNDAMENTALS.md)

