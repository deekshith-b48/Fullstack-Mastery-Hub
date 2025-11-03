# JavaScript Fundamentals

## 📚 Table of Contents

1. [Variables](#variables)
2. [Data Types](#data-types)
3. [Operators](#operators)
4. [Control Flow](#control-flow)
5. [Functions](#functions)
6. [Objects and Arrays](#objects-and-arrays)
7. [Scope](#scope)
8. [Hoisting](#hoisting)

## Variables

### Declaration

```javascript
// var (function-scoped, avoid in modern JS)
var name = "John";

// let (block-scoped, can be reassigned)
let age = 30;

// const (block-scoped, cannot be reassigned)
const PI = 3.14159;
```

### Naming Rules

- Must start with letter, `$`, or `_`
- Can contain letters, digits, `$`, `_`
- Case-sensitive
- Cannot use reserved words

## Data Types

### Primitive Types

```javascript
// String
let name = "John";
let greeting = 'Hello';
let template = `Hello ${name}`;

// Number
let age = 30;
let price = 99.99;
let hex = 0xFF;
let binary = 0b1010;

// Boolean
let isActive = true;
let isDisabled = false;

// Undefined
let value; // undefined

// Null
let data = null;

// Symbol (ES6)
let id = Symbol('unique');

// BigInt (ES2020)
let bigNumber = 9007199254740991n;
```

### Type Checking

```javascript
typeof "hello"        // "string"
typeof 42             // "number"
typeof true           // "boolean"
typeof undefined      // "undefined"
typeof null           // "object" (bug!)
typeof []             // "object"
typeof {}             // "object"

// Better type checking
Array.isArray([])      // true
Object.prototype.toString.call(null) // "[object Null]"
```

## Operators

### Arithmetic

```javascript
let a = 10;
let b = 3;

a + b  // 13 (addition)
a - b  // 7 (subtraction)
a * b  // 30 (multiplication)
a / b  // 3.333... (division)
a % b  // 1 (modulus)
a ** b // 1000 (exponentiation)

// Increment/Decrement
a++    // Post-increment
++a    // Pre-increment
a--    // Post-decrement
--a    // Pre-decrement
```

### Assignment

```javascript
let x = 10;
x += 5;  // x = x + 5
x -= 3;  // x = x - 3
x *= 2;  // x = x * 2
x /= 2;  // x = x / 2
x %= 3;  // x = x % 3
```

### Comparison

```javascript
10 == "10"   // true (type coercion)
10 === "10"  // false (strict equality)
10 != "10"   // false
10 !== "10"  // true

10 > 5       // true
10 < 5       // false
10 >= 10     // true
10 <= 5      // false
```

### Logical

```javascript
true && false   // false (AND)
true || false   // true (OR)
!true           // false (NOT)

// Short-circuit evaluation
let user = null;
let name = user && user.name;  // null (stops at falsy)
let displayName = user?.name || "Guest"; // "Guest"
```

### Ternary

```javascript
let age = 20;
let status = age >= 18 ? "Adult" : "Minor";
```

## Control Flow

### If/Else

```javascript
if (condition) {
    // code
} else if (anotherCondition) {
    // code
} else {
    // code
}
```

### Switch

```javascript
switch (value) {
    case 1:
        console.log("One");
        break;
    case 2:
        console.log("Two");
        break;
    default:
        console.log("Other");
}
```

### Loops

```javascript
// For loop
for (let i = 0; i < 10; i++) {
    console.log(i);
}

// While loop
let i = 0;
while (i < 10) {
    console.log(i);
    i++;
}

// Do-While
do {
    console.log(i);
    i++;
} while (i < 10);

// For...in (objects)
for (let key in object) {
    console.log(key, object[key]);
}

// For...of (iterables)
for (let item of array) {
    console.log(item);
}
```

## Functions

### Function Declaration

```javascript
function greet(name) {
    return `Hello, ${name}!`;
}

greet("John"); // "Hello, John!"
```

### Function Expression

```javascript
const greet = function(name) {
    return `Hello, ${name}!`;
};
```

### Arrow Functions (ES6)

```javascript
const greet = (name) => {
    return `Hello, ${name}!`;
};

// Implicit return
const greet = (name) => `Hello, ${name}!`;

// Single parameter (no parentheses)
const square = x => x * x;

// No parameters
const hello = () => "Hello!";
```

### Parameters

```javascript
// Default parameters
function greet(name = "Guest") {
    return `Hello, ${name}!`;
}

// Rest parameters
function sum(...numbers) {
    return numbers.reduce((a, b) => a + b, 0);
}

sum(1, 2, 3, 4); // 10
```

## Objects and Arrays

### Objects

```javascript
// Object literal
const person = {
    name: "John",
    age: 30,
    greet: function() {
        return `Hello, I'm ${this.name}`;
    }
};

// Access
person.name;
person["age"];

// Add/Modify
person.city = "NYC";
person["country"] = "USA";

// Delete
delete person.age;
```

### Arrays

```javascript
// Array literal
const fruits = ["apple", "banana", "orange"];

// Access
fruits[0];        // "apple"
fruits.length;    // 3

// Methods
fruits.push("grape");      // Add to end
fruits.pop();              // Remove from end
fruits.unshift("mango");   // Add to start
fruits.shift();            // Remove from start

// Iteration
fruits.forEach(fruit => console.log(fruit));
const lengths = fruits.map(fruit => fruit.length);
const filtered = fruits.filter(fruit => fruit.length > 5);
```

## Scope

### Global Scope

```javascript
let globalVar = "I'm global";

function test() {
    console.log(globalVar); // Accessible
}
```

### Function Scope

```javascript
function test() {
    let functionVar = "I'm function-scoped";
    console.log(functionVar); // Accessible
}
// console.log(functionVar); // Error!
```

### Block Scope

```javascript
if (true) {
    let blockVar = "I'm block-scoped";
    const alsoBlockScoped = "Me too";
}
// console.log(blockVar); // Error!
```

## Hoisting

```javascript
// Function declarations are hoisted
sayHello(); // Works!

function sayHello() {
    console.log("Hello!");
}

// Variables are hoisted but not initialized
console.log(x); // undefined (not error)
var x = 5;

// let and const are not hoisted
console.log(y); // Error!
let y = 10;
```

---

**Next**: Learn about [ES6 Features](./ES6-FEATURES.md)

