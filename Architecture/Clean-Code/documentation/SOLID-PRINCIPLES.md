# SOLID Principles

## 📚 Overview

SOLID is an acronym for five design principles that make software designs more understandable, flexible, and maintainable.

## 🎯 S - Single Responsibility Principle

A class should have only one reason to change.

```javascript
// ❌ Bad - Multiple responsibilities
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
  
  save() {
    // Database logic
  }
  
  sendEmail() {
    // Email logic
  }
  
  validate() {
    // Validation logic
  }
}

// ✅ Good - Single responsibility
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
  
  getData() {
    return { name: this.name, email: this.email };
  }
}

class UserRepository {
  save(user) {
    // Database logic
  }
}

class EmailService {
  sendEmail(user, message) {
    // Email logic
  }
}

class UserValidator {
  validate(user) {
    // Validation logic
  }
}
```

## 🔓 O - Open/Closed Principle

Open for extension, closed for modification.

```javascript
// ❌ Bad - Must modify class for new shapes
class AreaCalculator {
  calculate(shape) {
    if (shape instanceof Rectangle) {
      return shape.width * shape.height;
    } else if (shape instanceof Circle) {
      return Math.PI * shape.radius ** 2;
    }
    // Must modify to add Triangle
  }
}

// ✅ Good - Extend without modifying
class Shape {
  area() {
    throw new Error('Must implement area');
  }
}

class Rectangle extends Shape {
  constructor(width, height) {
    super();
    this.width = width;
    this.height = height;
  }
  
  area() {
    return this.width * this.height;
  }
}

class Circle extends Shape {
  constructor(radius) {
    super();
    this.radius = radius;
  }
  
  area() {
    return Math.PI * this.radius ** 2;
  }
}

class AreaCalculator {
  calculate(shape) {
    return shape.area(); // Works with any Shape
  }
}
```

## 🔄 L - Liskov Substitution Principle

Objects of a superclass should be replaceable with objects of its subclasses.

```javascript
// ✅ Good - Square can substitute Rectangle
class Rectangle {
  setWidth(width) {
    this.width = width;
  }
  
  setHeight(height) {
    this.height = height;
  }
  
  area() {
    return this.width * this.height;
  }
}

class Square extends Rectangle {
  setWidth(width) {
    this.width = width;
    this.height = width; // Maintains square property
  }
  
  setHeight(height) {
    this.width = height;
    this.height = height; // Maintains square property
  }
}

// Can use Square anywhere Rectangle is expected
function calculateArea(rectangle) {
  rectangle.setWidth(5);
  rectangle.setHeight(4);
  return rectangle.area();
}
```

## 🎯 I - Interface Segregation Principle

Clients should not depend on interfaces they don't use.

```javascript
// ❌ Bad - Fat interface
class Worker {
  work() { }
  eat() { }
  sleep() { }
}

// ❌ Forces HumanWorker to implement unnecessary methods
class HumanWorker extends Worker {
  work() { /* ... */ }
  eat() { /* ... */ }
  sleep() { /* ... */ }
}

// ❌ RobotWorker must implement eat/sleep
class RobotWorker extends Worker {
  work() { /* ... */ }
  eat() { /* Not applicable */ }
  sleep() { /* Not applicable */ }
}

// ✅ Good - Segregated interfaces
class Workable {
  work() { }
}

class Eatable {
  eat() { }
}

class Sleepable {
  sleep() { }
}

class HumanWorker extends Workable, Eatable, Sleepable {
  work() { /* ... */ }
  eat() { /* ... */ }
  sleep() { /* ... */ }
}

class RobotWorker extends Workable {
  work() { /* ... */ }
}
```

## 🔌 D - Dependency Inversion Principle

Depend on abstractions, not concretions.

```javascript
// ❌ Bad - Depends on concrete implementation
class MySQLDatabase {
  save(data) {
    // MySQL specific
  }
}

class UserService {
  constructor() {
    this.db = new MySQLDatabase(); // Tight coupling
  }
  
  saveUser(user) {
    this.db.save(user);
  }
}

// ✅ Good - Depends on abstraction
class Database {
  save(data) {
    throw new Error('Must implement save');
  }
}

class MySQLDatabase extends Database {
  save(data) {
    // MySQL implementation
  }
}

class PostgreSQLDatabase extends Database {
  save(data) {
    // PostgreSQL implementation
  }
}

class UserService {
  constructor(database) {
    this.db = database; // Depends on abstraction
  }
  
  saveUser(user) {
    this.db.save(user);
  }
}

// Usage - inject dependency
const db = new MySQLDatabase();
const userService = new UserService(db);
```

---

**Next**: Learn about [DRY and Other Principles](./CODE-SMELLS.md)

