# GraphQL Performance Optimization

## 📚 Overview

Optimizing GraphQL queries for better performance.

## 🎯 DataLoader (N+1 Problem)

```javascript
const DataLoader = require('dataloader');

const userLoader = new DataLoader(async (ids) => {
  const users = await User.findByIds(ids);
  return ids.map(id => users.find(u => u.id === id));
});

const resolvers = {
  Post: {
    author: (parent) => userLoader.load(parent.authorId)
  }
};
```

## 🔄 Caching

```javascript
// Cache query results
const cache = new Map();

const resolvers = {
  Query: {
    user: async (parent, args) => {
      const key = `user:${args.id}`;
      if (cache.has(key)) {
        return cache.get(key);
      }
      const user = await User.findById(args.id);
      cache.set(key, user);
      return user;
    }
  }
};
```

---

**Next**: Learn about [Real-time Subscriptions](./REAL-TIME-SUBSCRIPTIONS.md)

