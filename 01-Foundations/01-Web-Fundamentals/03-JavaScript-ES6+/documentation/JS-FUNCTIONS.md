# JavaScript Functions - Deep Dive

## Function Types

### Function Declaration

```javascript
function greet(name) {
    return `Hello, ${name}!`;
}

// Hoisted - can call before declaration
greet("John"); // Works!
```

### Function Expression

```javascript
const greet = function(name) {
    return `Hello, ${name}!`;
};

// Not hoisted
greet("John");
```

### Arrow Functions

```javascript
const greet = (name) => {
    return `Hello, ${name}!`;
};

// Implicit return
const add = (a, b) => a + b;

// Single parameter
const square = x => x * x;
```

### IIFE (Immediately Invoked Function Expression)

```javascript
(function() {
    console.log("IIFE");
})();

(() => {
    console.log("Arrow IIFE");
})();
```

## Function Parameters

### Default Parameters

```javascript
function greet(name = "Guest", greeting = "Hello") {
    return `${greeting}, ${name}!`;
}

greet(); // "Hello, Guest!"
```

### Rest Parameters

```javascript
function sum(...numbers) {
    return numbers.reduce((a, b) => a + b, 0);
}

sum(1, 2, 3, 4); // 10
```

### Named Parameters (via Object)

```javascript
function createUser({ name, age, email }) {
    return { name, age, email };
}

createUser({ name: "John", age: 30, email: "john@example.com" });
```

## Scope and Closures

### Lexical Scope

```javascript
function outer() {
    const outerVar = "outer";
    
    function inner() {
        console.log(outerVar); // Can access outer scope
    }
    
    inner();
}
```

### Closures

```javascript
function counter() {
    let count = 0;
    
    return function() {
        count++;
        return count;
    };
}

const increment = counter();
increment(); // 1
increment(); // 2
```

### Practical Closure Example

```javascript
function createMultiplier(multiplier) {
    return function(number) {
        return number * multiplier;
    };
}

const double = createMultiplier(2);
double(5); // 10
```

## Higher-Order Functions

### Functions as Arguments

```javascript
function processArray(arr, callback) {
    return arr.map(callback);
}

const numbers = [1, 2, 3];
const doubled = processArray(numbers, x => x * 2);
```

### Functions as Return Values

```javascript
function createValidator(rule) {
    return function(value) {
        return rule(value);
    };
}

const isEmail = createValidator(value => value.includes('@'));
isEmail("test@example.com"); // true
```

## This Binding

### Explicit Binding

```javascript
function greet() {
    return `Hello, ${this.name}`;
}

const person = { name: "John" };

// call
greet.call(person); // "Hello, John"

// apply
greet.apply(person, []);

// bind
const boundGreet = greet.bind(person);
boundGreet();
```

### Arrow Functions and This

```javascript
const obj = {
    name: "John",
    traditional: function() {
        setTimeout(function() {
            console.log(this.name); // undefined
        }, 100);
    },
    arrow: function() {
        setTimeout(() => {
            console.log(this.name); // "John"
        }, 100);
    }
};
```

## Recursion

### Basic Recursion

```javascript
function factorial(n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

factorial(5); // 120
```

### Tail Recursion

```javascript
function factorialTail(n, acc = 1) {
    if (n <= 1) return acc;
    return factorialTail(n - 1, n * acc);
}
```

## Function Methods

### call, apply, bind

```javascript
function introduce(greeting, punctuation) {
    return `${greeting}, I'm ${this.name}${punctuation}`;
}

const person = { name: "John" };

// call - arguments as comma-separated
introduce.call(person, "Hello", "!");

// apply - arguments as array
introduce.apply(person, ["Hi", "!"]);

// bind - returns new function
const intro = introduce.bind(person);
intro("Hey", ".");
```

## Generator Functions

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
```

## Async Functions

```javascript
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error(error);
        throw error;
    }
}
```

## Function Composition

```javascript
const compose = (f, g) => x => f(g(x));

const add1 = x => x + 1;
const multiply2 = x => x * 2;

const addThenMultiply = compose(multiply2, add1);
addThenMultiply(5); // (5 + 1) * 2 = 12

// Pipe (left to right)
const pipe = (...fns) => x => fns.reduce((acc, fn) => fn(acc), x);
const multiplyThenAdd = pipe(multiply2, add1);
multiplyThenAdd(5); // (5 * 2) + 1 = 11
```

## Currying

```javascript
// Traditional
function add(a, b, c) {
    return a + b + c;
}

// Curried
function curriedAdd(a) {
    return function(b) {
        return function(c) {
            return a + b + c;
        };
    };
}

// Arrow function currying
const curriedAdd2 = a => b => c => a + b + c;

curriedAdd2(1)(2)(3); // 6

// Partial application
const add5 = curriedAdd2(5);
const add5And10 = add5(10);
add5And10(3); // 18
```

---

**Next**: Learn about [Object-Oriented Programming](./JS-OOP.md)

