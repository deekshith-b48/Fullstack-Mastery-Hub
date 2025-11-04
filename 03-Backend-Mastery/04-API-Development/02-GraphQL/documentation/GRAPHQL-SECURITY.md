# GraphQL Security

## 📚 Overview

Security best practices for GraphQL APIs.

## 🛡️ Best Practices

### 1. Query Depth Limiting

```javascript
const depthLimit = require('graphql-depth-limit');

const server = new ApolloServer({
  typeDefs,
  resolvers,
  validationRules: [depthLimit(5)]
});
```

### 2. Query Complexity

```javascript
const { createComplexityLimitRule } = require('graphql-query-complexity');

const complexityLimit = createComplexityLimitRule(1000);
```

### 3. Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
});

app.use('/graphql', limiter);
```

### 4. Input Validation

```javascript
// Validate input in resolvers
const resolvers = {
  Mutation: {
    createUser: async (parent, args) => {
      if (!args.input.email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        throw new Error('Invalid email');
      }
      // Create user
    }
  }
};
```

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

