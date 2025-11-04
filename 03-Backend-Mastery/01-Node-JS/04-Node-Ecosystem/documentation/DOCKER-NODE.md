# Docker & Node.js

## 📚 Overview

Docker containerizes Node.js applications for consistent deployment.

## 🐳 Dockerfile

```dockerfile
FROM node:16-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "app.js"]
```

## 🐳 Multi-stage Build

```dockerfile
# Build stage
FROM node:16-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## 🐳 Docker Compose

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_URL=mongodb://db:27017/myapp
    depends_on:
      - db

  db:
    image: mongo:5
    volumes:
      - mongo-data:/data/db

volumes:
  mongo-data:
```

---

**Next**: Learn about [Testing Strategies](./TESTING-STRATEGIES.md)

