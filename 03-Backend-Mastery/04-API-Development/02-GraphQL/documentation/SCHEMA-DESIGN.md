# GraphQL Schema Design

## 📚 Overview

Designing effective GraphQL schemas requires careful planning.

## 🎯 Best Practices

### 1. Use Descriptive Names

```graphql
✅ Good: getUserById, createUser
❌ Bad: getUser, create
```

### 2. Use Non-Nullable Types

```graphql
type User {
  id: ID!           # Required
  name: String!      # Required
  email: String      # Optional
}
```

### 3. Use Enums

```graphql
enum UserRole {
  ADMIN
  USER
  GUEST
}

type User {
  role: UserRole!
}
```

### 4. Organize with Input Types

```graphql
input CreateUserInput {
  name: String!
  email: String!
  password: String!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
}
```

---

**Next**: Learn about [Resolvers Mastery](./RESOLVERS-MASTERY.md)

