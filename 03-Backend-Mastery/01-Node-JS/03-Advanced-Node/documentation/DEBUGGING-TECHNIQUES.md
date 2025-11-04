# Node.js Debugging Techniques

## 📚 Overview

Effective debugging is essential for identifying and fixing issues in Node.js applications.

## 🐛 Debugger

### Built-in Debugger

```javascript
// Start with debugger
node inspect app.js

// Or use debugger statement
debugger; // Breakpoint in code

// Commands in debugger
// cont, next, step, out, repl, watch('variable')
```

### Chrome DevTools

```bash
# Start with inspect
node --inspect app.js

# Or with breakpoint
node --inspect-brk app.js
```

Then open `chrome://inspect` in Chrome.

## 📝 Console Debugging

```javascript
// console.log
console.log('Value:', value);

// console.error
console.error('Error:', error);

// console.table
console.table([{ name: 'John', age: 30 }]);

// console.time
console.time('operation');
// ... code ...
console.timeEnd('operation');

// console.trace
console.trace('Stack trace');
```

## 🔍 Logging

### Winston Logger

```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

logger.info('Info message');
logger.error('Error message');
```

### Debug Module

```javascript
const debug = require('debug')('app:server');

debug('Debug message'); // Only shows if DEBUG=app:server
```

## 🎯 Error Handling

```javascript
// Stack traces
Error.captureStackTrace(this, this.constructor);

// Custom error
class CustomError extends Error {
  constructor(message) {
    super(message);
    this.name = 'CustomError';
    Error.captureStackTrace(this, this.constructor);
  }
}
```

---

**Next**: Learn about [Security Hardening](./SECURITY-HARDENING.md)

