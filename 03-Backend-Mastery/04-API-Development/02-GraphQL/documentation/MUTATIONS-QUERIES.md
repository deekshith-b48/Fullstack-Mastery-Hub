# GraphQL Mutations & Queries

## 📚 Overview

Queries fetch data, mutations modify data.

## 🔍 Queries

```graphql
query GetUser {
  user(id: 1) {
    id
    name
    email
  }
}

query GetUsers {
  users {
    id
    name
    posts {
      title
    }
  }
}
```

## ✏️ Mutations

```graphql
mutation CreateUser {
  createUser(input: {
    name: "John"
    email: "john@example.com"
  }) {
    id
    name
    email
  }
}

mutation UpdateUser {
  updateUser(id: 1, input: {
    name: "Jane"
  }) {
    id
    name
  }
}
```

---

**Next**: Learn about [Apollo Server](./APOLLO-SERVER.md)

