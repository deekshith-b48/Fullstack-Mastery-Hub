# GraphQL Fundamentals

## 📚 Overview

GraphQL is a query language for APIs that allows clients to request exactly the data they need.

## 🎯 Basic Query

```graphql
query {
  user(id: 1) {
    name
    email
    posts {
      title
      content
    }
  }
}
```

## 🔄 Mutation

```graphql
mutation {
  createUser(name: "John", email: "john@example.com") {
    id
    name
    email
  }
}
```

## 📝 Schema

```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]!
}

type Query {
  user(id: ID!): User
  users: [User!]!
}

type Mutation {
  createUser(name: String!, email: String!): User!
}
```

---

**Next**: Learn about [Schema Design](./SCHEMA-DESIGN.md)

