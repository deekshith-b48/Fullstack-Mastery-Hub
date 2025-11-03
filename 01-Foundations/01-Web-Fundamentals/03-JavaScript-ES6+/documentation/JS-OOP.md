# JavaScript Object-Oriented Programming

## Objects

### Object Literals

```javascript
const person = {
    name: "John",
    age: 30,
    greet() {
        return `Hello, I'm ${this.name}`;
    }
};
```

### Object Constructors

```javascript
function Person(name, age) {
    this.name = name;
    this.age = age;
    this.greet = function() {
        return `Hello, I'm ${this.name}`;
    };
}

const person = new Person("John", 30);
```

### Object.create()

```javascript
const personPrototype = {
    greet() {
        return `Hello, I'm ${this.name}`;
    }
};

const person = Object.create(personPrototype);
person.name = "John";
person.age = 30;
```

## Prototypes

### Prototype Chain

```javascript
function Person(name) {
    this.name = name;
}

Person.prototype.greet = function() {
    return `Hello, I'm ${this.name}`;
};

const person = new Person("John");
person.greet(); // "Hello, I'm John"

// Check prototype
Person.prototype.isPrototypeOf(person); // true
Object.getPrototypeOf(person) === Person.prototype; // true
```

### Prototype Inheritance

```javascript
function Animal(name) {
    this.name = name;
}

Animal.prototype.speak = function() {
    return `${this.name} makes a sound`;
};

function Dog(name, breed) {
    Animal.call(this, name);
    this.breed = breed;
}

// Inherit prototype
Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog;

Dog.prototype.speak = function() {
    return `${this.name} barks`;
};

const dog = new Dog("Rex", "Labrador");
dog.speak(); // "Rex barks"
```

## Classes (ES6)

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
```

### Inheritance

```javascript
class Student extends Person {
    constructor(name, age, school) {
        super(name, age);
        this.school = school;
    }
    
    study() {
        return `${this.name} is studying`;
    }
    
    greet() {
        return `${super.greet()} and I'm a student`;
    }
}
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
```

### Private Fields (ES2022)

```javascript
class BankAccount {
    #balance = 0; // Private field
    
    deposit(amount) {
        this.#balance += amount;
    }
    
    getBalance() {
        return this.#balance;
    }
}

const account = new BankAccount();
account.#balance; // SyntaxError
```

## Encapsulation

### Using Closures

```javascript
function createCounter() {
    let count = 0;
    
    return {
        increment() {
            count++;
        },
        getCount() {
            return count;
        }
    };
}

const counter = createCounter();
counter.increment();
counter.getCount(); // 1
```

### Using Private Fields

```javascript
class Counter {
    #count = 0;
    
    increment() {
        this.#count++;
    }
    
    getCount() {
        return this.#count;
    }
}
```

## Polymorphism

```javascript
class Animal {
    speak() {
        return "Animal makes sound";
    }
}

class Dog extends Animal {
    speak() {
        return "Dog barks";
    }
}

class Cat extends Animal {
    speak() {
        return "Cat meows";
    }
}

function makeSound(animal) {
    console.log(animal.speak()); // Polymorphic call
}

makeSound(new Dog()); // "Dog barks"
makeSound(new Cat()); // "Cat meows"
```

## Mixins

```javascript
const CanFly = {
    fly() {
        return `${this.name} is flying`;
    }
};

const CanSwim = {
    swim() {
        return `${this.name} is swimming`;
    }
};

class Duck {
    constructor(name) {
        this.name = name;
    }
}

// Apply mixins
Object.assign(Duck.prototype, CanFly, CanSwim);

const duck = new Duck("Donald");
duck.fly(); // "Donald is flying"
duck.swim(); // "Donald is swimming"
```

## Factory Functions

```javascript
function createPerson(name, age) {
    return {
        name,
        age,
        greet() {
            return `Hello, I'm ${this.name}`;
        }
    };
}

const person = createPerson("John", 30);
```

## Design Patterns

### Singleton

```javascript
class Singleton {
    constructor() {
        if (Singleton.instance) {
            return Singleton.instance;
        }
        Singleton.instance = this;
    }
}

const s1 = new Singleton();
const s2 = new Singleton();
console.log(s1 === s2); // true
```

### Module Pattern

```javascript
const MyModule = (function() {
    let privateVar = 0;
    
    function privateFunction() {
        return privateVar;
    }
    
    return {
        publicMethod() {
            privateVar++;
            return privateFunction();
        }
    };
})();
```

### Observer Pattern

```javascript
class EventEmitter {
    constructor() {
        this.events = {};
    }
    
    on(event, callback) {
        if (!this.events[event]) {
            this.events[event] = [];
        }
        this.events[event].push(callback);
    }
    
    emit(event, data) {
        if (this.events[event]) {
            this.events[event].forEach(callback => callback(data));
        }
    }
}
```

---

**Next**: Learn about [Advanced JavaScript](./JS-ADVANCED.md)

