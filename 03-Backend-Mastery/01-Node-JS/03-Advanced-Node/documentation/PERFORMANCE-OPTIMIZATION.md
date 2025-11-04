# Node.js Performance Optimization

## 📚 Overview

Performance optimization improves application speed and resource utilization.

## 🎯 Code Optimization

### 1. Use Streams

```javascript
// ❌ Bad - Loads entire file
const data = fs.readFileSync('large-file.txt');
processData(data);

// ✅ Good - Stream processing
fs.createReadStream('large-file.txt')
  .pipe(transformStream)
  .pipe(outputStream);
```

### 2. Avoid Synchronous Operations

```javascript
// ❌ Bad - Blocks event loop
const data = fs.readFileSync('file.txt');

// ✅ Good - Async
const data = await fs.promises.readFile('file.txt');
```

### 3. Use Worker Threads for CPU-Intensive Tasks

```javascript
const { Worker } = require('worker_threads');

function runWorker(data) {
  return new Promise((resolve, reject) => {
    const worker = new Worker('./worker.js', {
      workerData: data
    });
    
    worker.on('message', resolve);
    worker.on('error', reject);
    worker.on('exit', (code) => {
      if (code !== 0) reject(new Error(`Worker stopped with code ${code}`));
    });
  });
}
```

## 📊 Database Optimization

### Connection Pooling

```javascript
const { Pool } = require('pg');

const pool = new Pool({
  max: 20,
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

### Query Optimization

```javascript
// ✅ Use indexes
await User.findAll({
  where: { email: 'user@example.com' }, // email is indexed
  attributes: ['id', 'name'] // Select only needed fields
});
```

## 🚀 Caching

### In-Memory Caching

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 });

async function getCachedData(key) {
  let data = cache.get(key);
  if (!data) {
    data = await fetchFromDatabase(key);
    cache.set(key, data);
  }
  return data;
}
```

### Redis Caching

```javascript
const redis = require('redis');
const client = redis.createClient();

async function getCachedData(key) {
  let data = await client.get(key);
  if (!data) {
    data = await fetchFromDatabase(key);
    await client.setex(key, 600, JSON.stringify(data));
  } else {
    data = JSON.parse(data);
  }
  return data;
}
```

---

**Next**: Learn about [Memory Management](./MEMORY-MANAGEMENT.md)

