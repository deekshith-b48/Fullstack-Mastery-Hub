# Dockerfile Mastery

## 📚 Overview

A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Mastering Dockerfile creation is essential for building efficient, secure, and maintainable Docker images.

## 🎯 Dockerfile Basics

### Structure

A Dockerfile consists of instructions that are executed in order. Each instruction creates a new layer in the image.

### Basic Dockerfile

```dockerfile
# Base image
FROM node:18-alpine

# Metadata
LABEL maintainer="your-email@example.com"
LABEL version="1.0"

# Working directory
WORKDIR /app

# Copy files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application
COPY . .

# Expose port
EXPOSE 3000

# Environment variables
ENV NODE_ENV=production

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1

# Run command
CMD ["node", "server.js"]
```

## 📝 Dockerfile Instructions

### FROM

```dockerfile
# Base image
FROM ubuntu:22.04

# Specific version
FROM node:18.16.0-alpine

# Multi-stage build
FROM node:18 AS builder
FROM nginx:alpine AS production
```

### LABEL

```dockerfile
# Add metadata
LABEL maintainer="developer@example.com"
LABEL version="1.0.0"
LABEL description="My application"
LABEL org.opencontainers.image.title="My App"
LABEL org.opencontainers.image.version="1.0.0"
```

### WORKDIR

```dockerfile
# Set working directory
WORKDIR /app

# Create and change to directory
WORKDIR /usr/src/app

# Multiple WORKDIRs
WORKDIR /app
WORKDIR src
# Final directory: /app/src
```

### COPY vs ADD

```dockerfile
# COPY - Preferred for local files
COPY package.json ./
COPY src/ ./src/
COPY . .

# ADD - Can extract archives and download URLs
ADD https://example.com/file.tar.gz /tmp/
ADD archive.tar.gz /tmp/

# COPY with wildcards
COPY *.js ./
COPY src/*.js ./src/
```

### RUN

```dockerfile
# Single command
RUN apt-get update

# Multiple commands (creates one layer)
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Chain commands
RUN npm install && \
    npm run build && \
    npm cache clean --force
```

### CMD vs ENTRYPOINT

```dockerfile
# CMD - Default command (can be overridden)
CMD ["node", "server.js"]
CMD node server.js
CMD ["npm", "start"]

# ENTRYPOINT - Always executed (harder to override)
ENTRYPOINT ["node", "server.js"]

# Combined
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "server.js"]
```

### EXPOSE

```dockerfile
# Document ports (doesn't publish)
EXPOSE 3000
EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 8080/udp
```

### ENV

```dockerfile
# Set environment variable
ENV NODE_ENV=production
ENV API_URL=https://api.example.com

# Multiple variables
ENV NODE_ENV=production \
    PORT=3000 \
    API_KEY=secret

# Use in RUN
RUN echo $NODE_ENV
```

### ARG

```dockerfile
# Build-time variable
ARG VERSION=latest
ARG NODE_VERSION=18

# Use in FROM
ARG NODE_VERSION=18
FROM node:${NODE_VERSION}

# Use in RUN
ARG BUILD_DATE
RUN echo "Build date: $BUILD_DATE"
```

### USER

```dockerfile
# Switch user
USER node
USER 1000:1000

# Create user first
RUN groupadd -r appuser && \
    useradd -r -g appuser appuser
USER appuser
```

### VOLUME

```dockerfile
# Create mount point
VOLUME ["/data"]
VOLUME ["/var/log", "/var/db"]
```

### HEALTHCHECK

```dockerfile
# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Disable health check from base image
HEALTHCHECK NONE
```

## 🔄 Multi-Stage Builds

### Basic Multi-Stage

```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### Advanced Multi-Stage

```dockerfile
# Stage 1: Dependencies
FROM node:18 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 3: Runtime
FROM node:18-alpine AS runtime
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY package*.json ./
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

## 🎯 Best Practices

### Layer Optimization

```dockerfile
# ❌ Bad: Creates many layers
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get clean

# ✅ Good: One layer, cleans up
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### Cache Optimization

```dockerfile
# ✅ Good: Dependencies first (changes less frequently)
COPY package*.json ./
RUN npm install
COPY . .

# ❌ Bad: Code first (changes frequently)
COPY . .
RUN npm install
```

### Security

```dockerfile
# ✅ Use specific tags
FROM node:18.16.0-alpine

# ✅ Run as non-root
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

# ✅ Remove unnecessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### .dockerignore

```dockerfile
# .dockerignore
node_modules
npm-debug.log
.git
.gitignore
.env
.nyc_output
coverage
.DS_Store
*.md
.vscode
.idea
```

## 📊 Example Dockerfiles

### Node.js Application

```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy application
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js

# Start application
CMD ["node", "server.js"]
```

### Python Application

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Create non-root user
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 8000

# Start application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
```

### Nginx Static Site

```dockerfile
FROM nginx:alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files
COPY dist/ /usr/share/nginx/html/

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
```

## 🔍 Advanced Techniques

### Build Arguments

```dockerfile
ARG NODE_VERSION=18
ARG BUILD_DATE
ARG VCS_REF

FROM node:${NODE_VERSION}-alpine

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF

# Use build args
RUN echo "Building with Node ${NODE_VERSION}"
```

### Conditional Builds

```dockerfile
ARG BUILD_ENV=production

FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./

# Conditional installation
RUN if [ "$BUILD_ENV" = "development" ]; then \
      npm install; \
    else \
      npm ci --only=production; \
    fi
```

### Onbuild Instructions

```dockerfile
# Base image with ONBUILD
FROM node:18-alpine
ONBUILD COPY package*.json ./
ONBUILD RUN npm install
ONBUILD COPY . .
CMD ["npm", "start"]

# Child image automatically runs ONBUILD
FROM my-base-image
# ONBUILD instructions run automatically
```

## 🎯 Performance Tips

1. **Minimize layers**: Combine RUN commands
2. **Use .dockerignore**: Exclude unnecessary files
3. **Order matters**: Put frequently changing layers last
4. **Use specific tags**: Avoid 'latest' tag
5. **Multi-stage builds**: Reduce final image size
6. **Alpine images**: Use smaller base images
7. **Cache dependencies**: Install dependencies before copying code

---

**Next**: Learn about [Docker Compose](./DOCKER-COMPOSE.md)

