# Node.js Testing Strategies

## 📚 Overview

Testing ensures code quality and prevents regressions.

## 🧪 Testing Frameworks

### Jest

```javascript
// Install
npm install --save-dev jest

// test/user.test.js
const { add, subtract } = require('./math');

describe('Math functions', () => {
  test('adds 1 + 2 to equal 3', () => {
    expect(add(1, 2)).toBe(3);
  });

  test('subtracts 2 - 1 to equal 1', () => {
    expect(subtract(2, 1)).toBe(1);
  });
});
```

### Mocha & Chai

```javascript
const chai = require('chai');
const expect = chai.expect;

describe('Math functions', () => {
  it('should add two numbers', () => {
    expect(add(1, 2)).to.equal(3);
  });
});
```

## 🎯 Testing Types

### Unit Tests

```javascript
// Test individual functions
test('validateEmail', () => {
  expect(validateEmail('test@example.com')).toBe(true);
  expect(validateEmail('invalid')).toBe(false);
});
```

### Integration Tests

```javascript
// Test API endpoints
const request = require('supertest');
const app = require('./app');

test('GET /users', async () => {
  const response = await request(app)
    .get('/users')
    .expect(200);
  
  expect(response.body).toHaveProperty('users');
});
```

### End-to-End Tests

```javascript
// Test complete user flows
test('User registration flow', async () => {
  // Register user
  const registerResponse = await request(app)
    .post('/register')
    .send({ email: 'test@example.com', password: 'password123' })
    .expect(201);
  
  // Login
  const loginResponse = await request(app)
    .post('/login')
    .send({ email: 'test@example.com', password: 'password123' })
    .expect(200);
});
```

---

**Next**: Learn about [Microservices Architecture](./MICROSERVICES-ARCHITECTURE.md)

