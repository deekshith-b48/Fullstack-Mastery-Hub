# Async Programming in Node.js

## 📚 Overview

Asynchronous programming allows Node.js to handle multiple operations concurrently without blocking.

## 🔄 Callbacks

```javascript
// Callback pattern
function fetchData(callback) {
  setTimeout(() => {
    callback(null, 'Data');
  }, 1000);
}

fetchData((err, data) => {
  if (err) {
    console.error(err);
    return;
  }
  console.log(data);
});
```

### Callback Hell

```javascript
// ❌ Nested callbacks
getData((err1, data1) => {
  processData(data1, (err2, data2) => {
    saveData(data2, (err3, result) => {
      // Deep nesting
    });
  });
});
```

## 🎯 Promises

### Creating Promises

```javascript
function fetchData() {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const success = true;
      if (success) {
        resolve('Data');
      } else {
        reject(new Error('Failed'));
      }
    }, 1000);
  });
}

// Usage
fetchData()
  .then(data => console.log(data))
  .catch(err => console.error(err));
```

### Promise Chaining

```javascript
fetchData()
  .then(data => processData(data))
  .then(processed => saveData(processed))
  .then(result => console.log(result))
  .catch(err => console.error(err));
```

### Promise.all

```javascript
// Wait for all promises
Promise.all([
  fetchUser(1),
  fetchUser(2),
  fetchUser(3)
])
  .then(users => console.log(users))
  .catch(err => console.error(err));

// Promise.allSettled (all results, even failures)
Promise.allSettled([
  fetchUser(1),
  fetchUser(2)
])
  .then(results => {
    results.forEach(result => {
      if (result.status === 'fulfilled') {
        console.log(result.value);
      } else {
        console.error(result.reason);
      }
    });
  });
```

## ⚡ Async/Await

```javascript
// Async function
async function fetchUserData() {
  try {
    const user = await fetchUser(1);
    const profile = await fetchProfile(user.id);
    return { user, profile };
  } catch (err) {
    console.error('Error:', err);
    throw err;
  }
}

// Parallel execution
async function fetchAllData() {
  const [user, posts, comments] = await Promise.all([
    fetchUser(1),
    fetchPosts(1),
    fetchComments(1)
  ]);
  
  return { user, posts, comments };
}
```

## 🔄 Event Emitters

```javascript
const EventEmitter = require('events');

class MyEmitter extends EventEmitter {}

const emitter = new MyEmitter();

// Listen
emitter.on('event', (data) => {
  console.log('Event received:', data);
});

// Emit
emitter.emit('event', 'data');

// Once (listen only once)
emitter.once('event', () => {
  console.log('Once');
});

// Remove listener
emitter.removeListener('event', handler);
```

---

**Next**: Learn about [Node.js Performance](./NODE-JS-PERFORMANCE.md)

