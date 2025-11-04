# Node.js Best Practices

## 📚 Overview

Following best practices ensures maintainable and scalable Node.js applications.

## 🎯 Code Organization

### Project Structure

```
my-app/
├── src/
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── middleware/
│   ├── utils/
│   └── config/
├── tests/
├── .env
├── .gitignore
├── package.json
└── README.md
```

## 🔧 Best Practices

### 1. Use Environment Variables

```javascript
// .env
NODE_ENV=production
PORT=3000
DB_URL=mongodb://localhost:27017/myapp

// config.js
require('dotenv').config();

module.exports = {
  env: process.env.NODE_ENV,
  port: process.env.PORT || 3000,
  dbUrl: process.env.DB_URL
};
```

### 2. Error Handling

```javascript
// Always handle errors
async function fetchData() {
  try {
    const data = await database.get();
    return data;
  } catch (err) {
    console.error('Error:', err);
    throw err;
  }
}
```

### 3. Use Async/Await

```javascript
// ✅ Good
async function getUser(id) {
  const user = await User.findById(id);
  return user;
}

// ❌ Avoid callbacks
function getUser(id, callback) {
  User.findById(id, callback);
}
```

### 4. Logging

```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});
```

### 5. Code Style

```javascript
// Use ESLint and Prettier
// .eslintrc.js
module.exports = {
  extends: ['eslint:recommended'],
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error'
  }
};
```

---

**Next**: Learn about [Deployment Strategies](./DEPLOYMENT-STRATEGIES.md)

