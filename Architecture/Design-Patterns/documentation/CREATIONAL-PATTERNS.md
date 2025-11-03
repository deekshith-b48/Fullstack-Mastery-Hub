# Creational Design Patterns

## 📚 Overview

Creational patterns provide object creation mechanisms that increase flexibility and reuse of existing code.

## 🏭 Singleton Pattern

Ensures a class has only one instance and provides global access to it.

```javascript
class DatabaseConnection {
  constructor() {
    if (DatabaseConnection.instance) {
      return DatabaseConnection.instance;
    }
    
    this.connection = this.connect();
    DatabaseConnection.instance = this;
  }
  
  connect() {
    // Database connection logic
    return { connected: true };
  }
  
  query(sql) {
    return this.connection.query(sql);
  }
}

// Usage
const db1 = new DatabaseConnection();
const db2 = new DatabaseConnection();
console.log(db1 === db2); // true - same instance
```

**Use Cases**: Database connections, logging, configuration

## 🏗️ Factory Pattern

Creates objects without specifying the exact class.

```javascript
class VehicleFactory {
  createVehicle(type) {
    switch(type) {
      case 'car':
        return new Car();
      case 'truck':
        return new Truck();
      case 'motorcycle':
        return new Motorcycle();
      default:
        throw new Error(`Unknown vehicle type: ${type}`);
    }
  }
}

class Car {
  drive() {
    return 'Driving a car';
  }
}

class Truck {
  drive() {
    return 'Driving a truck';
  }
}

// Usage
const factory = new VehicleFactory();
const car = factory.createVehicle('car');
console.log(car.drive()); // "Driving a car"
```

**Use Cases**: Creating objects based on configuration, dynamic object creation

## 🔨 Builder Pattern

Constructs complex objects step by step.

```javascript
class Pizza {
  constructor(builder) {
    this.size = builder.size;
    this.crust = builder.crust;
    this.toppings = builder.toppings;
    this.sauce = builder.sauce;
  }
  
  static Builder = class {
    constructor() {
      this.toppings = [];
    }
    
    setSize(size) {
      this.size = size;
      return this;
    }
    
    setCrust(crust) {
      this.crust = crust;
      return this;
    }
    
    addTopping(topping) {
      this.toppings.push(topping);
      return this;
    }
    
    setSauce(sauce) {
      this.sauce = sauce;
      return this;
    }
    
    build() {
      return new Pizza(this);
    }
  };
}

// Usage
const pizza = new Pizza.Builder()
  .setSize('large')
  .setCrust('thin')
  .addTopping('pepperoni')
  .addTopping('mushrooms')
  .setSauce('tomato')
  .build();
```

**Use Cases**: Complex object construction, optional parameters, immutable objects

## 📋 Prototype Pattern

Creates objects by cloning existing instances.

```javascript
class Shape {
  constructor(x, y, color) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
  
  clone() {
    return new Shape(this.x, this.y, this.color);
  }
  
  render() {
    console.log(`Rendering ${this.color} shape at (${this.x}, ${this.y})`);
  }
}

// Usage
const circle = new Shape(10, 20, 'red');
const clonedCircle = circle.clone();
clonedCircle.x = 30; // Modify clone independently
```

**Use Cases**: Expensive object creation, default configurations

## 🎯 Abstract Factory Pattern

Creates families of related objects.

```javascript
// Abstract factory
class UIFactory {
  createButton() {
    throw new Error('Must implement createButton');
  }
  
  createDialog() {
    throw new Error('Must implement createDialog');
  }
}

// Concrete factories
class WindowsFactory extends UIFactory {
  createButton() {
    return new WindowsButton();
  }
  
  createDialog() {
    return new WindowsDialog();
  }
}

class MacFactory extends UIFactory {
  createButton() {
    return new MacButton();
  }
  
  createDialog() {
    return new MacDialog();
  }
}

// Usage
function createUI(os) {
  const factory = os === 'windows' 
    ? new WindowsFactory() 
    : new MacFactory();
  
  const button = factory.createButton();
  const dialog = factory.createDialog();
  
  return { button, dialog };
}
```

**Use Cases**: Cross-platform UI, theme systems

---

**Next**: Learn about [Structural Patterns](./STRUCTURAL-PATTERNS.md)

