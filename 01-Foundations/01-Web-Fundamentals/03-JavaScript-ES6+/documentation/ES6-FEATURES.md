# ES6+ Features - Complete Guide

## 📚 Table of Contents

1. [Let and Const](#let-and-const)
2. [Arrow Functions](#arrow-functions)
3. [Template Literals](#template-literals)
4. [Destructuring](#destructuring)
5. [Spread and Rest Operators](#spread-and-rest-operators)
6. [Default Parameters](#default-parameters)
7. [Promises and Async/Await](#promises-and-asyncawait)
8. [Classes](#classes)
9. [Modules](#modules)
10. [Map, Set, WeakMap, WeakSet](#map-set-weakmap-weakset)

## Let and Const

### Let (Block-Scoped Variables)

```javascript
// Block scope
{
    let x = 1;
    console.log(x); // 1
}
// console.log(x); // ReferenceError

// Loop scope
for (let i = 0; i < 3; i++) {
    setTimeout(() => console.log(i), 100);
}
// Output: 0, 1, 2 (not 3, 3, 3)

// Temporal Dead Zone
console.log(y); // ReferenceError
let y = 5;
```

### Const (Immutable Binding)

```javascript
// Constant binding
const PI = 3.14159;
// PI = 3.14; // TypeError

// Const with objects
const person = { name: "John" };
person.name = "Jane"; // OK - mutating object property
// person = {}; // TypeError - can't reassign

// Const with arrays
const numbers = [1, 2, 3];
numbers.push(4); // OK
numbers[0] = 10; // OK
// numbers = []; // TypeError
```

## Arrow Functions

### Basic Syntax

```javascript
// Traditional function
function add(a, b) {
    return a + b;
}

// Arrow function
const add = (a, b) => {
    return a + b;
};

// Implicit return
const add = (a, b) => a + b;

// Single parameter (no parentheses)
const square = x => x * x;

// No parameters
const greet = () => "Hello!";

// Object return
const getUser = () => ({ name: "John", age: 30 });
```

### This Binding

```javascript
// Traditional - 'this' depends on context
const obj = {
    name: "John",
    greet: function() {
        setTimeout(function() {
            console.log(this.name); // undefined (this is window)
        }, 100);
    }
};

// Arrow function - lexical 'this'
const obj2 = {
    name: "John",
    greet: function() {
        setTimeout(() => {
            console.log(this.name); // "John" (this is obj2)
        }, 100);
    }
};
```

## Template Literals

### Basic Usage

```javascript
const name = "John";
const age = 30;

// Traditional concatenation
const message = "Hello, " + name + "! You are " + age + " years old.";

// Template literal
const message2 = `Hello, ${name}! You are ${age} years old.`;
```

### Multiline Strings

```javascript
// Traditional
const multiline = "Line 1\n" +
                  "Line 2\n" +
                  "Line 3";

// Template literal
const multiline2 = `Line 1
Line 2
Line 3`;
```

### Tagged Templates

```javascript
function tag(strings, ...values) {
    console.log(strings); // ["Hello ", "! You are ", " years old."]
    console.log(values);  // ["John", 30]
    return strings[0] + values[0].toUpperCase() + strings[1] + values[1] + strings[2];
}

const name = "John";
const age = 30;
const result = tag`Hello ${name}! You are ${age} years old.`;
// "Hello JOHN! You are 30 years old."
```

## Destructuring

### Array Destructuring

```javascript
const arr = [1, 2, 3, 4, 5];

// Basic
const [first, second] = arr;
console.log(first, second); // 1, 2

// Skip elements
const [first, , third] = arr;

// Rest operator
const [first, ...rest] = arr;
console.log(rest); // [2, 3, 4, 5]

// Default values
const [a = 10, b = 20] = [1];
console.log(a, b); // 1, 20

// Swap variables
let x = 1, y = 2;
[x, y] = [y, x];
console.log(x, y); // 2, 1
```

### Object Destructuring

```javascript
const person = {
    name: "John",
    age: 30,
    city: "NYC",
    country: "USA"
};

// Basic
const { name, age } = person;

// Rename variables
const { name: personName, age: personAge } = person;

// Default values
const { name, age, salary = 50000 } = person;

// Rest operator
const { name, ...rest } = person;

// Nested destructuring
const user = {
    name: "John",
    address: {
        street: "123 Main St",
        city: "NYC"
    }
};
const { address: { city } } = user;
```

### Function Parameters

```javascript
function greet({ name, age = 18 }) {
    return `Hello, ${name}! You are ${age} years old.`;
}

greet({ name: "John", age: 30 });
greet({ name: "Jane" }); // age defaults to 18
```

## Spread and Rest Operators

### Spread Operator

```javascript
// Arrays
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2]; // [1, 2, 3, 4, 5, 6]

// Copy array
const copy = [...arr1];

// Add elements
const newArr = [...arr1, 4, 5];

// Objects (ES2018)
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const merged = { ...obj1, ...obj2 }; // { a: 1, b: 2, c: 3, d: 4 }

// Override properties
const updated = { ...obj1, b: 20 }; // { a: 1, b: 20 }

// Function arguments
Math.max(...[1, 5, 3, 2]); // 5
```

### Rest Operator

```javascript
// Function parameters
function sum(...numbers) {
    return numbers.reduce((a, b) => a + b, 0);
}
sum(1, 2, 3, 4); // 10

// Array destructuring
const [first, ...rest] = [1, 2, 3, 4];

// Object destructuring
const { name, ...rest } = { name: "John", age: 30, city: "NYC" };
```

## Default Parameters

```javascript
// Traditional
function greet(name) {
    name = name || "Guest";
    return `Hello, ${name}!`;
}

// ES6 default parameters
function greet(name = "Guest", greeting = "Hello") {
    return `${greeting}, ${name}!`;
}

greet(); // "Hello, Guest!"
greet("John"); // "Hello, John!"
greet("John", "Hi"); // "Hi, John!"

// Expressions as defaults
function createUser(name, id = Math.random()) {
    return { name, id };
}

// Can reference previous parameters
function multiply(a, b = a) {
    return a * b;
}
```

## Promises and Async/Await

### Promises

```javascript
// Creating promises
const promise = new Promise((resolve, reject) => {
    setTimeout(() => {
        const success = true;
        if (success) {
            resolve("Data loaded!");
        } else {
            reject("Error occurred!");
        }
    }, 1000);
});

// Using promises
promise
    .then(result => console.log(result))
    .catch(error => console.error(error))
    .finally(() => console.log("Done"));

// Promise.all
Promise.all([promise1, promise2, promise3])
    .then(results => console.log(results))
    .catch(error => console.error(error));

// Promise.allSettled
Promise.allSettled([promise1, promise2])
    .then(results => results.forEach(r => console.log(r.status)));

// Promise.race
Promise.race([promise1, promise2])
    .then(first => console.log("First:", first));
```

### Async/Await

```javascript
// Async function
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}

// Multiple await
async function fetchMultiple() {
    const [user, posts] = await Promise.all([
        fetch('/api/user').then(r => r.json()),
        fetch('/api/posts').then(r => r.json())
    ]);
    return { user, posts };
}

// Async arrow function
const fetchData = async () => {
    const response = await fetch('/api/data');
    return response.json();
};
```

## Classes

### Basic Class

```javascript
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    greet() {
        return `Hello, I'm ${this.name}`;
    }
    
    get info() {
        return `${this.name} is ${this.age} years old`;
    }
    
    set age(newAge) {
        if (newAge > 0) {
            this._age = newAge;
        }
    }
}

const person = new Person("John", 30);
console.log(person.greet()); // "Hello, I'm John"
```

### Inheritance

```javascript
class Student extends Person {
    constructor(name, age, school) {
        super(name, age);
        this.school = school;
    }
    
    study() {
        return `${this.name} is studying at ${this.school}`;
    }
    
    greet() {
        return `${super.greet()} and I'm a student`;
    }
}

const student = new Student("Jane", 20, "University");
```

### Static Methods

```javascript
class MathUtils {
    static add(a, b) {
        return a + b;
    }
    
    static PI = 3.14159;
}

MathUtils.add(2, 3); // 5
console.log(MathUtils.PI);
```

## Modules

### Export

```javascript
// Named exports
export const PI = 3.14159;
export function add(a, b) {
    return a + b;
}

// Or at end
const PI = 3.14159;
function add(a, b) {
    return a + b;
}
export { PI, add };

// Default export
export default class Calculator {
    // ...
}

// Export as
export { add as sum, PI as pi };
```

### Import

```javascript
// Named imports
import { PI, add } from './math.js';
import { add as sum } from './math.js';
import * as math from './math.js';

// Default import
import Calculator from './calculator.js';

// Mixed
import Calculator, { PI } from './calculator.js';

// Dynamic import
const module = await import('./module.js');
```

## Map, Set, WeakMap, WeakSet

### Map

```javascript
const map = new Map();

// Set values
map.set('key1', 'value1');
map.set(1, 'number key');
map.set({}, 'object key');

// Get values
map.get('key1'); // 'value1'

// Check existence
map.has('key1'); // true

// Size
map.size; // 3

// Iteration
for (const [key, value] of map) {
    console.log(key, value);
}

map.forEach((value, key) => {
    console.log(key, value);
});

// Clear
map.clear();
```

### Set

```javascript
const set = new Set([1, 2, 3, 3, 4]); // {1, 2, 3, 4}

// Add
set.add(5);

// Check
set.has(2); // true

// Delete
set.delete(3);

// Size
set.size; // 3

// Iteration
for (const value of set) {
    console.log(value);
}
```

### WeakMap and WeakSet

```javascript
// WeakMap - keys must be objects
const weakMap = new WeakMap();
const obj = {};
weakMap.set(obj, 'value');
weakMap.get(obj); // 'value'

// WeakSet - only objects
const weakSet = new WeakSet();
weakSet.add(obj);
weakSet.has(obj); // true

// Both allow garbage collection when keys are no longer referenced
```

## Additional ES6+ Features

### Optional Chaining (ES2020)

```javascript
const user = {
    address: {
        city: 'NYC'
    }
};

// Safe property access
const city = user?.address?.city; // 'NYC'
const zip = user?.address?.zip; // undefined (no error)

// Method calls
user?.getName?.(); // Only calls if exists

// Array access
const first = arr?.[0];
```

### Nullish Coalescing (ES2020)

```javascript
const value = null ?? 'default'; // 'default'
const value2 = undefined ?? 'default'; // 'default'
const value3 = 0 ?? 'default'; // 0 (not 'default')
const value4 = '' ?? 'default'; // '' (not 'default')

// Chaining
const result = obj?.prop ?? defaultValue;
```

### BigInt (ES2020)

```javascript
const bigNumber = 9007199254740991n;
const another = BigInt("9007199254740991");
const result = bigNumber + another;
```

### GlobalThis (ES2020)

```javascript
// Works in browser, Node.js, etc.
globalThis.console.log('Hello');
```

---

**Next**: Learn about [JavaScript Data Structures](./JS-DATA-STRUCTURES.md)

