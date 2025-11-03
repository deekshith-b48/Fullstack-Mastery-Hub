# Creational Design Patterns

## Singleton

```javascript
class Singleton {
    constructor() {
        if (Singleton.instance) {
            return Singleton.instance;
        }
        Singleton.instance = this;
        return this;
    }
}
```

## Factory

```javascript
class CarFactory {
    createCar(type) {
        switch(type) {
            case 'sedan': return new Sedan();
            case 'suv': return new SUV();
            default: throw new Error('Unknown type');
        }
    }
}
```

## Builder

```javascript
class QueryBuilder {
    constructor() {
        this.query = {};
    }
    
    select(fields) {
        this.query.select = fields;
        return this;
    }
    
    where(condition) {
        this.query.where = condition;
        return this;
    }
    
    build() {
        return this.query;
    }
}

const query = new QueryBuilder()
    .select(['name', 'age'])
    .where({ age: { $gt: 18 } })
    .build();
```

---

**Next**: See [Structural Patterns](./STRUCTURAL-PATTERNS.md)

