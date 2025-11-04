# Node.js Modules System

## 📚 Overview

Node.js uses a module system to organize code into reusable pieces.

## 🎯 CommonJS (Default)

### Export

```javascript
// math.js
// Named exports
exports.add = (a, b) => a + b;
exports.subtract = (a, b) => a - b;

// Or
module.exports = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b
};

// Default export
module.exports = (a, b) => a + b;

// Function export
module.exports = function(a, b) {
  return a + b;
};
```

### Import

```javascript
// Import entire module
const math = require('./math');

// Destructure
const { add, subtract } = require('./math');

// Import Node.js built-in
const fs = require('fs');
const http = require('http');

// Import from node_modules
const express = require('express');
```

## 📦 ES Modules

### Enable ES Modules

```json
// package.json
{
  "type": "module"
}
```

### Export

```javascript
// math.mjs or math.js (with type: "module")
// Named exports
export function add(a, b) {
  return a + b;
}

export const PI = 3.14159;

// Default export
export default class Calculator {
  // ...
}

// Export all
export * from './other-module';
```

### Import

```javascript
// Named imports
import { add, PI } from './math.js';

// Default import
import Calculator from './math.js';

// Import all
import * as math from './math.js';

// Dynamic import
const module = await import('./math.js');
```

## 🔍 Module Resolution

### Relative Paths

```javascript
// Same directory
const module = require('./module');

// Parent directory
const module = require('../module');

// File extensions
const module = require('./module.js'); // Optional
```

### Node Modules

```javascript
// Searches in:
// 1. node_modules in current directory
// 2. node_modules in parent directories
// 3. Global node_modules
const express = require('express');
```

### Core Modules

```javascript
// Built-in modules (no ./ or path needed)
const fs = require('fs');
const path = require('path');
```

## 📁 Module Structure

### Module Wrapper

Every module is wrapped in:

```javascript
(function(exports, require, module, __filename, __dirname) {
  // Your code here
});
```

### Module Caching

Modules are cached after first load:

```javascript
// module.js
console.log('Module loaded');

// app.js
require('./module'); // "Module loaded"
require('./module'); // Nothing (cached)
```

## 🎯 Circular Dependencies

```javascript
// a.js
const b = require('./b');
module.exports = { name: 'A' };

// b.js
const a = require('./a');
module.exports = { name: 'B' };

// Result: Partial exports due to load order
```

**Solution**: Restructure to avoid circular dependencies

---

**Next**: Learn about [Buffers and Streams](./BUFFER-STREAMS.md)

