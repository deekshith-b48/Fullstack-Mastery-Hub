# Error Handling in Node.js

## 📚 Overview

Proper error handling is crucial for robust Node.js applications.

## 🎯 Error Types

### Standard Errors

```javascript
// Error
throw new Error('Something went wrong');

// TypeError
throw new TypeError('Invalid type');

// ReferenceError
throw new ReferenceError('Variable not defined');

// SyntaxError
throw new SyntaxError('Invalid syntax');
```

### Custom Errors

```javascript
class CustomError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.name = 'CustomError';
    this.statusCode = statusCode;
    Error.captureStackTrace(this, this.constructor);
  }
}

throw new CustomError('Custom error', 400);
```

## 🔄 Callback Error Handling

### Error-First Callback Pattern

```javascript
function asyncOperation(callback) {
  fs.readFile('file.txt', (err, data) => {
    if (err) {
      return callback(err); // Error first
    }
    callback(null, data); // Success second
  });
}

// Usage
asyncOperation((err, data) => {
  if (err) {
    console.error('Error:', err);
    return;
  }
  console.log('Data:', data);
});
```

## 🎯 Promise Error Handling

```javascript
// .catch()
asyncOperation()
  .then(data => {
    console.log(data);
  })
  .catch(err => {
    console.error('Error:', err);
  });

// Try-catch with async/await
async function handleAsync() {
  try {
    const data = await asyncOperation();
    console.log(data);
  } catch (err) {
    console.error('Error:', err);
  }
}
```

## 🛡️ Global Error Handlers

### Uncaught Exceptions

```javascript
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  // Cleanup before exit
  process.exit(1);
});
```

### Unhandled Rejections

```javascript
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection:', reason);
  // Log or handle
});
```

### Domain (Deprecated, use alternatives)

```javascript
// Use try-catch or async/await instead
```

## 📝 Best Practices

### 1. Always Handle Errors

```javascript
// ❌ Bad
fs.readFile('file.txt', (data) => {
  console.log(data);
});

// ✅ Good
fs.readFile('file.txt', (err, data) => {
  if (err) {
    console.error('Error:', err);
    return;
  }
  console.log(data);
});
```

### 2. Use Error Objects

```javascript
// ❌ Bad
throw 'Error message';

// ✅ Good
throw new Error('Error message');
```

### 3. Provide Context

```javascript
// ✅ Good
function processUser(userId) {
  try {
    // Process user
  } catch (err) {
    err.message = `Failed to process user ${userId}: ${err.message}`;
    throw err;
  }
}
```

### 4. Don't Suppress Errors

```javascript
// ❌ Bad
try {
  riskyOperation();
} catch (err) {
  // Silent failure
}

// ✅ Good
try {
  riskyOperation();
} catch (err) {
  console.error('Operation failed:', err);
  // Handle appropriately
}
```

---

**Next**: Learn about [Async Programming](./ASYNC-PROGRAMMING.md)

