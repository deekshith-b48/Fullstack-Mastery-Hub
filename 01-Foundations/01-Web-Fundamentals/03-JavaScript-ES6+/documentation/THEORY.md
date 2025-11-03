# JavaScript ES6+ - Theory

## 📚 Overview

ES6+ (ECMAScript 2015 and beyond) introduced modern JavaScript features that make code more readable, maintainable, and powerful.

## 🎯 Core Concepts

### Let and Const

**Definition**: Block-scoped variable declarations that replace `var`.

**Key Points**:
- `let`: Block-scoped, can be reassigned
- `const`: Block-scoped, cannot be reassigned (immutable binding)
- No hoisting issues like `var`
- Temporal Dead Zone

**Example**:
```javascript
// Block scope
{
  let x = 1;
  const y = 2;
  // x can be reassigned, y cannot
}

// Temporal Dead Zone
console.log(z); // ReferenceError
let z = 3;
```

### Arrow Functions

**Definition**: Concise function syntax with lexical `this` binding.

**Example**:
```javascript
// Traditional function
function add(a, b) {
  return a + b;
}

// Arrow function
const add = (a, b) => a + b;

// With this binding
const obj = {
  name: 'John',
  greet: function() {
    setTimeout(() => {
      console.log(this.name); // 'John' (lexical this)
    }, 1000);
  }
};
```

### Destructuring

**Array Destructuring**:
```javascript
const [first, second, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(rest); // [3, 4, 5]
```

**Object Destructuring**:
```javascript
const { name, age, ...others } = {
  name: 'John',
  age: 30,
  city: 'NYC',
  country: 'USA'
};
```

### Template Literals

**Definition**: Multi-line strings with embedded expressions.

**Example**:
```javascript
const name = 'John';
const message = `Hello, ${name}!
This is a multi-line string.`;

// Tagged templates
function tag(strings, ...values) {
  return strings[0] + values[0].toUpperCase();
}
```

### Spread and Rest Operators

**Spread**:
```javascript
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2];

const obj1 = { a: 1 };
const obj2 = { b: 2 };
const merged = { ...obj1, ...obj2 };
```

**Rest**:
```javascript
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}
sum(1, 2, 3, 4); // 10
```

### Promises and Async/Await

**Promises**:
```javascript
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));
```

**Async/Await**:
```javascript
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

### Classes

**Definition**: Syntactic sugar over JavaScript's prototype-based inheritance.

**Example**:
```javascript
class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  greet() {
    return `Hello, I'm ${this.name}`;
  }

  static createAdult(name) {
    return new Person(name, 18);
  }
}

class Student extends Person {
  constructor(name, age, school) {
    super(name, age);
    this.school = school;
  }
}
```

### Modules

**Export**:
```javascript
// named export
export const PI = 3.14159;
export function add(a, b) { return a + b; }

// default export
export default class Calculator {}
```

**Import**:
```javascript
import Calculator, { PI, add } from './calculator.js';
```

### Map, Set, WeakMap, WeakSet

**Map**: Key-value pairs with any key type
```javascript
const map = new Map();
map.set('key', 'value');
map.get('key'); // 'value'
```

**Set**: Collection of unique values
```javascript
const set = new Set([1, 2, 3, 3]); // {1, 2, 3}
set.add(4);
set.has(2); // true
```

## 🔑 Modern Features

### Optional Chaining (?.)
```javascript
const user = {
  address: {
    city: 'NYC'
  }
};
const city = user?.address?.city; // 'NYC'
const zip = user?.address?.zip; // undefined (no error)
```

### Nullish Coalescing (??)
```javascript
const value = null ?? 'default'; // 'default'
const value2 = 0 ?? 'default'; // 0 (not 'default')
```

### Array Methods
- `map()`: Transform elements
- `filter()`: Select elements
- `reduce()`: Accumulate values
- `find()`: Find first match
- `some()`, `every()`: Test conditions

## 📚 Resources

- [MDN JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [ES6 Features](http://es6-features.org/)
- [JavaScript.info](https://javascript.info/)

---

**Last Updated**: 2024

