# GraphQL API Security

## 📚 Overview

GraphQL API security addresses GraphQL-specific security concerns. It includes query complexity, depth limiting, and field-level authorization.

## 🎯 GraphQL Security Concerns

### Key Concerns

1. **Query Complexity**: Prevent expensive queries
2. **Depth Limiting**: Limit query depth
3. **Field Authorization**: Field-level access
4. **Introspection**: Control introspection
5. **Rate Limiting**: Query rate limiting

## 🔍 Query Complexity

### Limit Query Complexity

```javascript
// GraphQL query complexity limiting
const { createComplexityLimitRule } = require('graphql-query-complexity');

const complexityLimit = createComplexityLimitRule({
  maximumComplexity: 100,
  onComplete: (complexity) => {
    if (complexity > 100) {
      throw new Error('Query too complex');
    }
  }
});
```

## 🔍 Depth Limiting

### Limit Query Depth

```javascript
// GraphQL depth limiting
const depthLimit = require('graphql-depth-limit');

const depthLimitRule = depthLimit(10); // Max depth 10

// Apply to schema
const schema = makeExecutableSchema({
  typeDefs,
  resolvers,
  validationRules: [depthLimitRule]
});
```

## 🔍 Field Authorization

### Field-Level Authorization

```javascript
// GraphQL field authorization
const { shield } = require('graphql-shield');

const permissions = shield({
  Query: {
    users: isAuthenticated,
    user: isAuthenticated
  },
  User: {
    email: isOwner,
    password: deny,
    adminData: isAdmin
  }
});
```

## 🔍 Introspection Control

### Control Introspection

```javascript
// Disable introspection in production
function disableIntrospection(req, res, next) {
  if (process.env.NODE_ENV === 'production') {
    const query = req.body.query;
    if (query && query.includes('__schema')) {
      return res.status(400).json({ error: 'Introspection disabled' });
    }
  }
  next();
}
```

## 🛡️ Best Practices

1. **Complexity**: Limit query complexity
2. **Depth**: Limit query depth
3. **Authorization**: Field-level authorization
4. **Introspection**: Control introspection
5. **Rate Limiting**: Limit query rate
6. **Validation**: Validate queries
7. **Monitoring**: Monitor GraphQL usage

---

**Next**: Learn about [API Authentication](./API-AUTHENTICATION.md)

