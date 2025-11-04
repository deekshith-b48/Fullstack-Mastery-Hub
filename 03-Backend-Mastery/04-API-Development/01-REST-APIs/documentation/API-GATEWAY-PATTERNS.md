# API Gateway Patterns

## 📚 Overview

API Gateway provides a single entry point for multiple microservices.

## 🏗️ Architecture

```
Client → API Gateway → Microservice 1
                    → Microservice 2
                    → Microservice 3
```

## 🎯 Functions

- **Routing**: Route requests to appropriate services
- **Authentication**: Centralized authentication
- **Rate Limiting**: Protect backend services
- **Load Balancing**: Distribute requests
- **Request Aggregation**: Combine multiple service calls

## 🔧 Example (Kong)

```javascript
// Kong Gateway configuration
services:
  - name: user-service
    url: http://user-service:3000
  - name: order-service
    url: http://order-service:3000
```

---

**Next**: Learn about [GraphQL](./../02-GraphQL/documentation/GRAPHQL-FUNDAMENTALS.md)

