# Advanced JavaScript Topics

## Memory Management

### Garbage Collection

```javascript
// Automatic garbage collection
let obj = { data: "large" };
obj = null; // Eligible for garbage collection

// WeakMap and WeakSet allow garbage collection
const weakMap = new WeakMap();
let key = {};
weakMap.set(key, "value");
key = null; // Can be garbage collected
```

### Memory Leaks

```javascript
// Common memory leak - closures
function attachHandler() {
    const largeData = new Array(1000000).fill(1);
    document.getElementById('button').onclick = function() {
        // largeData is kept in memory!
        console.log('clicked');
    };
}

// Fix - nullify when done
function attachHandler() {
    const largeData = new Array(1000000).fill(1);
    document.getElementById('button').onclick = function() {
        console.log('clicked');
    };
    largeData = null;
}
```

## Event Loop and Asynchronous Programming

### Event Loop

```javascript
console.log('1');

setTimeout(() => {
    console.log('2');
}, 0);

Promise.resolve().then(() => {
    console.log('3');
});

console.log('4');

// Output: 1, 4, 3, 2
// Call stack -> Microtasks -> Macrotasks
```

### Promises vs Async/Await

```javascript
// Promise chain
fetch('/api/data')
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));

// Async/await
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        const data = await response.json();
        console.log(data);
    } catch (error) {
        console.error(error);
    }
}
```

## Error Handling

### Try-Catch

```javascript
try {
    riskyOperation();
} catch (error) {
    console.error('Error:', error.message);
} finally {
    console.log('Always executes');
}
```

### Custom Errors

```javascript
class CustomError extends Error {
    constructor(message, code) {
        super(message);
        this.name = 'CustomError';
        this.code = code;
    }
}

throw new CustomError('Something went wrong', 500);
```

## Proxies

```javascript
const handler = {
    get(target, prop) {
        return prop in target ? target[prop] : 'default';
    },
    set(target, prop, value) {
        if (typeof value === 'string') {
            target[prop] = value;
        } else {
            throw new TypeError('Value must be string');
        }
    }
};

const proxy = new Proxy({}, handler);
proxy.name = 'John'; // OK
proxy.age = 30; // TypeError
```

## Reflect API

```javascript
const obj = { name: 'John' };

// Reflect.get
Reflect.get(obj, 'name'); // 'John'

// Reflect.set
Reflect.set(obj, 'age', 30);

// Reflect.has
Reflect.has(obj, 'name'); // true

// Reflect.deleteProperty
Reflect.deleteProperty(obj, 'age');

// Reflect.construct
class Person {
    constructor(name) {
        this.name = name;
    }
}
const person = Reflect.construct(Person, ['John']);
```

## Symbols

```javascript
// Unique identifier
const id1 = Symbol('id');
const id2 = Symbol('id');
console.log(id1 === id2); // false

// Use cases
const PRIVATE_KEY = Symbol('private');
const obj = {
    [PRIVATE_KEY]: 'secret',
    public: 'public'
};

// Well-known symbols
class Collection {
    *[Symbol.iterator]() {
        yield 1;
        yield 2;
        yield 3;
    }
}

for (const item of new Collection()) {
    console.log(item);
}
```

## Generators

```javascript
function* numberGenerator() {
    yield 1;
    yield 2;
    yield 3;
}

const gen = numberGenerator();
gen.next(); // { value: 1, done: false }
gen.next(); // { value: 2, done: false }
gen.next(); // { value: 3, done: false }
gen.next(); // { value: undefined, done: true }

// Generator with parameter
function* counter() {
    let count = 0;
    while (true) {
        count = yield count;
    }
}

const c = counter();
c.next(); // { value: 0, done: false }
c.next(5); // { value: 5, done: false }
```

## Iterators

```javascript
const obj = {
    [Symbol.iterator]() {
        let step = 0;
        return {
            next() {
                step++;
                if (step === 1) {
                    return { value: 'hello', done: false };
                } else if (step === 2) {
                    return { value: 'world', done: false };
                }
                return { done: true };
            }
        };
    }
};

for (const value of obj) {
    console.log(value);
}
```

## Decorators (Stage 3)

```javascript
// Requires transpiler (Babel)
function readonly(target, key, descriptor) {
    descriptor.writable = false;
    return descriptor;
}

class Person {
    @readonly
    name = 'John';
}

const person = new Person();
person.name = 'Jane'; // Error in strict mode
```

## Optional Chaining and Nullish Coalescing

```javascript
// Optional chaining
const user = {
    address: {
        city: 'NYC'
    }
};

user?.address?.city; // 'NYC'
user?.address?.zip; // undefined (no error)
user?.getName?.(); // Safe method call

// Nullish coalescing
const value = null ?? 'default'; // 'default'
const value2 = undefined ?? 'default'; // 'default'
const value3 = 0 ?? 'default'; // 0
```

## Performance Optimization

### Debounce

```javascript
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

const debouncedSearch = debounce((query) => {
    console.log('Searching:', query);
}, 300);
```

### Throttle

```javascript
function throttle(func, limit) {
    let inThrottle;
    return function(...args) {
        if (!inThrottle) {
            func.apply(this, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}
```

### Memoization

```javascript
function memoize(fn) {
    const cache = new Map();
    return function(...args) {
        const key = JSON.stringify(args);
        if (cache.has(key)) {
            return cache.get(key);
        }
        const result = fn(...args);
        cache.set(key, result);
        return result;
    };
}

const memoizedFibonacci = memoize(function(n) {
    if (n <= 1) return n;
    return memoizedFibonacci(n - 1) + memoizedFibonacci(n - 2);
});
```

## Web Workers

```javascript
// main.js
const worker = new Worker('worker.js');
worker.postMessage('Hello');
worker.onmessage = (e) => {
    console.log('From worker:', e.data);
};

// worker.js
self.onmessage = (e) => {
    console.log('From main:', e.data);
    self.postMessage('Hi from worker');
};
```

## Performance Monitoring

```javascript
// Performance API
const start = performance.now();
// Do work
const end = performance.now();
console.log(`Time: ${end - start}ms`);

// Performance marks
performance.mark('start');
// Do work
performance.mark('end');
performance.measure('duration', 'start', 'end');
```

---

**Next**: Learn about [Web APIs & DOM](../04-Web-APIs-DOM/documentation/DOM-MANIPULATION.md)

