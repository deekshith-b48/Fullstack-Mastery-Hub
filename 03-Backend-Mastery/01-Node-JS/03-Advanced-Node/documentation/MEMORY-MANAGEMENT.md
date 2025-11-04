# Node.js Memory Management

## 📚 Overview

Understanding memory management is crucial for building scalable Node.js applications.

## 🎯 Memory Structure

### V8 Heap

```
┌─────────────────────┐
│   New Space         │  ← Young generation
│   (Scavenge)        │
├─────────────────────┤
│   Old Space         │  ← Old generation
│   (Mark-Sweep)      │
├─────────────────────┤
│   Large Object      │
│   Space             │
└─────────────────────┘
```

## 📊 Monitoring Memory

```javascript
// Memory usage
const memoryUsage = process.memoryUsage();

console.log({
  rss: `${Math.round(memoryUsage.rss / 1024 / 1024)}MB`,
  heapTotal: `${Math.round(memoryUsage.heapTotal / 1024 / 1024)}MB`,
  heapUsed: `${Math.round(memoryUsage.heapUsed / 1024 / 1024)}MB`,
  external: `${Math.round(memoryUsage.external / 1024 / 1024)}MB`
});

// Garbage collection flags
node --expose-gc --trace-gc app.js
```

## 🔧 Memory Optimization

### 1. Avoid Memory Leaks

```javascript
// ❌ Bad - Memory leak
const intervals = [];
setInterval(() => {
  const data = new Array(1000000).fill('data');
  intervals.push(data);
}, 1000);

// ✅ Good - Clean up
const interval = setInterval(() => {
  const data = new Array(1000000).fill('data');
  // Process and clear
}, 1000);

// Clear interval
setTimeout(() => clearInterval(interval), 60000);
```

### 2. Use Weak References

```javascript
const { WeakMap } = require('vm');

const cache = new WeakMap();

function cacheResult(obj, result) {
  cache.set(obj, result);
  // Automatically garbage collected when obj is removed
}
```

### 3. Limit Buffer Sizes

```javascript
// ❌ Bad - Large buffer
const buffer = Buffer.alloc(100 * 1024 * 1024); // 100MB

// ✅ Good - Stream processing
const stream = fs.createReadStream('large-file.txt');
stream.on('data', (chunk) => {
  // Process chunk
});
```

## 🚀 Garbage Collection

```javascript
// Manual garbage collection (if --expose-gc flag)
if (global.gc) {
  global.gc();
}

// Monitor GC
const v8 = require('v8');
v8.setFlagsFromString('--trace-gc');
```

---

**Next**: Learn about [Debugging Techniques](./DEBUGGING-TECHNIQUES.md)

