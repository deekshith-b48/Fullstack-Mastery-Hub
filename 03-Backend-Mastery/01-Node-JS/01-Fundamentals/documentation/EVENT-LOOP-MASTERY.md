# Event Loop Mastery

## 📚 Overview

The Event Loop is Node.js's mechanism for handling asynchronous operations. It allows Node.js to perform non-blocking I/O operations.

## 🔄 Event Loop Phases

### Phase Order

```
┌───────────────────────────┐
│   timers                  │  ← setTimeout, setInterval
├───────────────────────────┤
│   pending callbacks       │  ← I/O callbacks
├───────────────────────────┤
│   idle, prepare           │  ← Internal use
├───────────────────────────┤
│   poll                    │  ← Fetch new I/O events
├───────────────────────────┤
│   check                   │  ← setImmediate callbacks
├───────────────────────────┤
│   close callbacks         │  ← socket.on('close')
└───────────────────────────┘
```

## ⏰ Timers Phase

```javascript
// setTimeout
setTimeout(() => {
  console.log('Timer 1');
}, 1000);

// setInterval
const interval = setInterval(() => {
  console.log('Interval');
}, 1000);

// Clear interval
setTimeout(() => {
  clearInterval(interval);
}, 5000);
```

## 🔍 Poll Phase

The poll phase:
1. Calculates how long to block and wait for I/O
2. Processes events in the poll queue
3. Executes scripts until queue is empty

```javascript
// File I/O (poll phase)
const fs = require('fs');

fs.readFile('file.txt', (err, data) => {
  console.log('File read complete');
});
```

## ✅ Check Phase

```javascript
// setImmediate (check phase)
setImmediate(() => {
  console.log('Immediate');
});

// vs setTimeout
setTimeout(() => {
  console.log('Timeout');
}, 0);

// Output order: Immediate, then Timeout
```

## 🔄 Microtasks vs Macrotasks

### Microtasks (Processed between phases)

```javascript
// Promise callbacks
Promise.resolve().then(() => {
  console.log('Promise');
});

// process.nextTick (highest priority)
process.nextTick(() => {
  console.log('Next tick');
});

// Execution order:
// 1. process.nextTick
// 2. Promise callbacks
// 3. setImmediate
// 4. setTimeout
```

### Macrotasks (Each phase)

- setTimeout/setInterval
- setImmediate
- I/O callbacks

## 📊 Example Execution Order

```javascript
console.log('1. Start');

setTimeout(() => console.log('2. setTimeout'), 0);
setImmediate(() => console.log('3. setImmediate'));

Promise.resolve().then(() => console.log('4. Promise'));

process.nextTick(() => console.log('5. nextTick'));

console.log('6. End');

// Output:
// 1. Start
// 6. End
// 5. nextTick
// 4. Promise
// 2. setTimeout
// 3. setImmediate
```

## 🎯 Understanding Blocking

```javascript
// Blocking operation
function blocking() {
  const start = Date.now();
  while (Date.now() - start < 5000) {
    // Block for 5 seconds
  }
}

// Non-blocking
function nonBlocking() {
  setTimeout(() => {
    console.log('Non-blocking');
  }, 5000);
}
```

## 🔧 Best Practices

### 1. Avoid Blocking the Event Loop

```javascript
// ❌ Bad - Blocks event loop
for (let i = 0; i < 1000000; i++) {
  // Heavy computation
}

// ✅ Good - Use setImmediate for chunking
function processChunk(items, index) {
  const chunkSize = 1000;
  const end = Math.min(index + chunkSize, items.length);
  
  for (let i = index; i < end; i++) {
    // Process item
  }
  
  if (end < items.length) {
    setImmediate(() => processChunk(items, end));
  }
}
```

### 2. Use process.nextTick Sparingly

```javascript
// ✅ Good use - Before event loop continues
function asyncFunction(callback) {
  if (cache) {
    process.nextTick(() => callback(cache));
    return;
  }
  fetchData(callback);
}
```

---

**Next**: Learn about [Modules System](./MODULES-SYSTEM.md)

