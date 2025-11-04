# GraphQL Resolvers Mastery

## 📚 Overview

Resolvers are functions that fetch data for GraphQL fields.

## 🎯 Basic Resolver

```javascript
const resolvers = {
  Query: {
    user: async (parent, args, context) => {
      return await User.findById(args.id);
    },
    users: async () => {
      return await User.findAll();
    }
  },
  
  User: {
    posts: async (parent) => {
      return await Post.findByUserId(parent.id);
    }
  }
};
```

## 🔄 Field Resolvers

```javascript
User: {
  fullName: (parent) => {
    return `${parent.firstName} ${parent.lastName}`;
  },
  
  posts: async (parent) => {
    return await Post.findByUserId(parent.id);
  }
}
```

---

**Next**: Learn about [Mutations & Queries](./MUTATIONS-QUERIES.md)

