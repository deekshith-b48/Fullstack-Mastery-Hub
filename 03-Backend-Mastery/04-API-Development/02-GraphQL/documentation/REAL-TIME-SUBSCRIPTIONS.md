# GraphQL Real-time Subscriptions

## 📚 Overview

GraphQL subscriptions enable real-time updates.

## 🔌 Subscription Schema

```graphql
type Subscription {
  userCreated: User!
  postUpdated: Post!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
}
```

## 🎯 Implementation

```javascript
const { PubSub } = require('apollo-server');
const pubsub = new PubSub();

const resolvers = {
  Mutation: {
    createUser: async (parent, args) => {
      const user = await User.create(args.input);
      pubsub.publish('USER_CREATED', { userCreated: user });
      return user;
    }
  },
  Subscription: {
    userCreated: {
      subscribe: () => pubsub.asyncIterator('USER_CREATED')
    }
  }
};
```

---

**Next**: Learn about [WebSockets](./../03-WebSockets/documentation/WEBSOCKETS-PROTOCOL.md)

