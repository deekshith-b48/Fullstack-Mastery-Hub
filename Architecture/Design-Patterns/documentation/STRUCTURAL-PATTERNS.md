# Structural Design Patterns

## 📚 Overview

Structural patterns explain how to assemble objects and classes into larger structures while keeping them flexible and efficient.

## 🔌 Adapter Pattern

Allows incompatible interfaces to work together.

```javascript
// Old interface
class OldLogger {
  log(message) {
    console.log(`[OLD] ${message}`);
  }
}

// New interface
class NewLogger {
  info(message) {
    console.log(`[INFO] ${message}`);
  }
  
  error(message) {
    console.error(`[ERROR] ${message}`);
  }
}

// Adapter
class LoggerAdapter {
  constructor(newLogger) {
    this.logger = newLogger;
  }
  
  log(message) {
    this.logger.info(message); // Adapt to new interface
  }
}

// Usage
const newLogger = new NewLogger();
const adapter = new LoggerAdapter(newLogger);
adapter.log('Hello'); // Uses newLogger.info internally
```

**Use Cases**: Integrating third-party libraries, legacy code integration

## 🎨 Decorator Pattern

Adds behavior to objects dynamically without altering their structure.

```javascript
class Coffee {
  cost() {
    return 5;
  }
  
  description() {
    return 'Coffee';
  }
}

// Decorators
class MilkDecorator {
  constructor(coffee) {
    this.coffee = coffee;
  }
  
  cost() {
    return this.coffee.cost() + 2;
  }
  
  description() {
    return this.coffee.description() + ', Milk';
  }
}

class SugarDecorator {
  constructor(coffee) {
    this.coffee = coffee;
  }
  
  cost() {
    return this.coffee.cost() + 1;
  }
  
  description() {
    return this.coffee.description() + ', Sugar';
  }
}

// Usage
let coffee = new Coffee();
coffee = new MilkDecorator(coffee);
coffee = new SugarDecorator(coffee);

console.log(coffee.description()); // "Coffee, Milk, Sugar"
console.log(coffee.cost()); // 8
```

**Use Cases**: Middleware, logging, caching, validation

## 🎭 Facade Pattern

Provides a simplified interface to a complex subsystem.

```javascript
// Complex subsystem
class CPU {
  freeze() { console.log('CPU freeze'); }
  jump(position) { console.log(`CPU jump to ${position}`); }
  execute() { console.log('CPU execute'); }
}

class Memory {
  load(position, data) { console.log(`Memory load ${data} at ${position}`); }
}

class HardDrive {
  read(position, size) { return `Data from ${position}, size ${size}`; }
}

// Facade
class Computer {
  constructor() {
    this.cpu = new CPU();
    this.memory = new Memory();
    this.hardDrive = new HardDrive();
  }
  
  start() {
    this.cpu.freeze();
    this.memory.load(0, this.hardDrive.read(0, 1024));
    this.cpu.jump(0);
    this.cpu.execute();
  }
}

// Usage - simple interface
const computer = new Computer();
computer.start(); // Handles all complexity internally
```

**Use Cases**: API simplification, library wrappers

## 🎯 Proxy Pattern

Provides a surrogate or placeholder for another object.

```javascript
class RealImage {
  constructor(filename) {
    this.filename = filename;
    this.loadFromDisk();
  }
  
  loadFromDisk() {
    console.log(`Loading ${this.filename}`);
  }
  
  display() {
    console.log(`Displaying ${this.filename}`);
  }
}

class ProxyImage {
  constructor(filename) {
    this.filename = filename;
    this.image = null;
  }
  
  display() {
    if (!this.image) {
      this.image = new RealImage(this.filename);
    }
    this.image.display();
  }
}

// Usage - lazy loading
const image = new ProxyImage('photo.jpg');
// RealImage not created yet
image.display(); // Now RealImage is created
```

**Use Cases**: Lazy loading, access control, logging, caching

---

**Next**: Learn about [Behavioral Patterns](./BEHAVIORAL-PATTERNS.md)

