# JavaScript Data Structures

## Arrays

### Creation and Manipulation

```javascript
// Creation
const arr = [1, 2, 3];
const arr2 = new Array(1, 2, 3);
const empty = [];

// Access
arr[0]; // 1
arr.length; // 3

// Methods
arr.push(4);        // Add to end
arr.pop();          // Remove from end
arr.unshift(0);     // Add to start
arr.shift();        // Remove from start
arr.splice(1, 1);   // Remove at index
arr.slice(1, 3);    // Copy portion
arr.indexOf(2);     // Find index
arr.includes(2);    // Check existence
arr.reverse();      // Reverse array
arr.sort();         // Sort array
```

### Array Iteration

```javascript
// forEach
arr.forEach(item => console.log(item));

// map - Transform
const doubled = arr.map(x => x * 2);

// filter - Select
const evens = arr.filter(x => x % 2 === 0);

// reduce - Accumulate
const sum = arr.reduce((acc, val) => acc + val, 0);

// find - Find first match
const found = arr.find(x => x > 2);

// findIndex
const index = arr.findIndex(x => x > 2);

// some - Any match
const hasEven = arr.some(x => x % 2 === 0);

// every - All match
const allPositive = arr.every(x => x > 0);
```

### Array Destructuring

```javascript
const [first, second, ...rest] = [1, 2, 3, 4];
// first = 1, second = 2, rest = [3, 4]
```

## Objects

### Creation

```javascript
// Object literal
const obj = {
    name: "John",
    age: 30,
    greet() {
        return `Hello, ${this.name}`;
    }
};

// Constructor
const obj2 = new Object();
obj2.name = "Jane";

// Object.create
const obj3 = Object.create(null);
```

### Access and Manipulation

```javascript
// Access
obj.name;
obj["age"];

// Add/Modify
obj.city = "NYC";
obj["country"] = "USA";

// Delete
delete obj.age;

// Check existence
"name" in obj;
obj.hasOwnProperty("name");

// Get keys/values/entries
Object.keys(obj);
Object.values(obj);
Object.entries(obj);
```

### Object Methods

```javascript
// Object.assign - Copy properties
const copy = Object.assign({}, obj);
const merged = Object.assign({}, obj1, obj2);

// Spread operator (ES2018)
const copy2 = { ...obj };
const merged2 = { ...obj1, ...obj2 };

// Object.freeze - Immutable
const frozen = Object.freeze(obj);
// frozen.name = "New"; // Error in strict mode

// Object.seal - Prevent additions
const sealed = Object.seal(obj);
```

## Map

### Usage

```javascript
const map = new Map();

// Set/Get
map.set('key1', 'value1');
map.set(1, 'number');
map.set({}, 'object');

map.get('key1'); // 'value1'
map.has('key1');  // true
map.size;        // 3
map.delete('key1');

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

## Set

### Usage

```javascript
const set = new Set([1, 2, 3, 3, 4]); // {1, 2, 3, 4}

// Methods
set.add(5);
set.delete(3);
set.has(2);
set.size;
set.clear();

// Iteration
for (const value of set) {
    console.log(value);
}

// Convert to array
const arr = Array.from(set);
const arr2 = [...set];
```

## WeakMap

```javascript
const weakMap = new WeakMap();
const obj = {};

weakMap.set(obj, 'value');
weakMap.get(obj); // 'value'
weakMap.has(obj); // true
weakMap.delete(obj);

// Keys must be objects
// No size property
// Not iterable
// Allows garbage collection
```

## WeakSet

```javascript
const weakSet = new WeakSet();
const obj = {};

weakSet.add(obj);
weakSet.has(obj); // true
weakSet.delete(obj);

// Only objects
// No size property
// Not iterable
// Allows garbage collection
```

## Linked List (Implementation)

```javascript
class ListNode {
    constructor(value) {
        this.value = value;
        this.next = null;
    }
}

class LinkedList {
    constructor() {
        this.head = null;
        this.size = 0;
    }
    
    append(value) {
        const node = new ListNode(value);
        if (!this.head) {
            this.head = node;
        } else {
            let current = this.head;
            while (current.next) {
                current = current.next;
            }
            current.next = node;
        }
        this.size++;
    }
    
    prepend(value) {
        const node = new ListNode(value);
        node.next = this.head;
        this.head = node;
        this.size++;
    }
}
```

## Stack (Implementation)

```javascript
class Stack {
    constructor() {
        this.items = [];
    }
    
    push(item) {
        this.items.push(item);
    }
    
    pop() {
        return this.items.pop();
    }
    
    peek() {
        return this.items[this.items.length - 1];
    }
    
    isEmpty() {
        return this.items.length === 0;
    }
    
    size() {
        return this.items.length;
    }
}
```

## Queue (Implementation)

```javascript
class Queue {
    constructor() {
        this.items = [];
    }
    
    enqueue(item) {
        this.items.push(item);
    }
    
    dequeue() {
        return this.items.shift();
    }
    
    front() {
        return this.items[0];
    }
    
    isEmpty() {
        return this.items.length === 0;
    }
    
    size() {
        return this.items.length;
    }
}
```

## Tree (Binary Search Tree)

```javascript
class TreeNode {
    constructor(value) {
        this.value = value;
        this.left = null;
        this.right = null;
    }
}

class BST {
    constructor() {
        this.root = null;
    }
    
    insert(value) {
        const node = new TreeNode(value);
        if (!this.root) {
            this.root = node;
            return;
        }
        
        let current = this.root;
        while (true) {
            if (value < current.value) {
                if (!current.left) {
                    current.left = node;
                    return;
                }
                current = current.left;
            } else {
                if (!current.right) {
                    current.right = node;
                    return;
                }
                current = current.right;
            }
        }
    }
    
    search(value) {
        let current = this.root;
        while (current) {
            if (value === current.value) return current;
            current = value < current.value ? current.left : current.right;
        }
        return null;
    }
}
```

---

**Next**: Learn about [JavaScript Functions](./JS-FUNCTIONS.md)

