# Apollo Server

## 📚 Overview

Apollo Server is a production-ready GraphQL server.

## 🚀 Setup

```javascript
const { ApolloServer, gql } = require('apollo-server');

const typeDefs = gql`
  type User {
    id: ID!
    name: String!
  }
  
  type Query {
    users: [User!]!
  }
`;

const resolvers = {
  Query: {
    users: () => users
  }
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
  console.log(`Server ready at ${url}`);
});
```

## 🔐 Authentication

```javascript
const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => {
    const token = req.headers.authorization;
    const user = getUser(token);
    return { user };
  }
});
```

---

**Next**: Learn about [GraphQL Security](./GRAPHQL-SECURITY.md)

