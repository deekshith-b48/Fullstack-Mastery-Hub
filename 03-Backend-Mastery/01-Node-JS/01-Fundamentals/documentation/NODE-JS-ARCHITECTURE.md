# Node.js Architecture

## 📚 Overview

Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine, enabling server-side JavaScript execution.

## 🏗️ Architecture Components

### V8 Engine

- **Purpose**: JavaScript execution engine
- **Features**: Just-In-Time (JIT) compilation
- **Memory Management**: Automatic garbage collection

### Libuv

- **Purpose**: Event loop and async I/O
- **Features**: Thread pool for blocking operations
- **Platform**: Cross-platform C++ library

### Node.js Core

```
┌─────────────────────────────────┐
│      JavaScript Code            │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│      Node.js Core Modules       │
│  (fs, http, crypto, etc.)       │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│      V8 Engine                  │
│      (JavaScript Execution)      │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│      Libuv                      │
│      (Event Loop, I/O)          │
└─────────────────────────────────┘
```

## 🎯 Core Modules

### Built-in Modules

```javascript
// File System
const fs = require('fs');
const fsPromises = require('fs').promises;

// HTTP
const http = require('http');
const https = require('https');

// Path
const path = require('path');

// Events
const EventEmitter = require('events');

// Streams
const stream = require('stream');

// Crypto
const crypto = require('crypto');

// OS
const os = require('os');

// URL
const url = require('url');
```

### File System Module

```javascript
// Synchronous (blocking)
const data = fs.readFileSync('file.txt', 'utf8');

// Asynchronous (non-blocking)
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

// Promise-based
async function readFile() {
  const data = await fsPromises.readFile('file.txt', 'utf8');
  console.log(data);
}
```

### HTTP Module

```javascript
// Create server
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World');
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

## 🧩 Module System

### CommonJS (require/module.exports)

```javascript
// Export module
// math.js
module.exports = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b
};

// Or
exports.multiply = (a, b) => a * b;

// Import
const math = require('./math');
const { add, subtract } = require('./math');
```

### ES Modules (import/export)

```javascript
// Export
// math.mjs
export function add(a, b) {
  return a + b;
}

export default class Calculator {
  // ...
}

// Import
import { add } from './math.mjs';
import Calculator from './math.mjs';
```

## 📦 Package.json

```json
{
  "name": "my-app",
  "version": "1.0.0",
  "description": "My Node.js app",
  "main": "index.js",
  "type": "module", // For ES modules
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.18.0"
  },
  "devDependencies": {
    "nodemon": "^2.0.0"
  },
  "engines": {
    "node": ">=14.0.0"
  }
}
```

## 🎯 Process Object

```javascript
// Environment variables
process.env.NODE_ENV;
process.env.PORT;

// Command line arguments
process.argv; // ['node', 'script.js', 'arg1', 'arg2']

// Process exit
process.exit(0); // Success
process.exit(1); // Error

// Uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('Uncaught exception:', err);
  process.exit(1);
});

// Unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled rejection:', reason);
});
```

## 🔧 Global Objects

```javascript
// __dirname (CommonJS)
console.log(__dirname); // Current directory

// __filename (CommonJS)
console.log(__filename); // Current file path

// global (Node.js global object)
global.myVariable = 'value';

// Buffer (for binary data)
const buffer = Buffer.from('Hello', 'utf8');

// console
console.log('Info');
console.error('Error');
console.warn('Warning');
```

---

**Next**: Learn about [Event Loop](./EVENT-LOOP-MASTERY.md)

