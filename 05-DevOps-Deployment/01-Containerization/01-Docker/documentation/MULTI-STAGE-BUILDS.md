# Docker Multi-Stage Builds

## 📚 Overview

Multi-stage builds allow you to use multiple FROM statements in a Dockerfile to create smaller, more efficient final images by separating the build environment from the runtime environment.

## 🎯 What are Multi-Stage Builds?

Multi-stage builds enable you to use multiple `FROM` statements in a single Dockerfile. Each `FROM` instruction begins a new stage, and you can selectively copy artifacts from one stage to another, leaving behind everything you don't want in the final image.

### Benefits

1. **Smaller Images**: Final image contains only what's needed to run
2. **Better Security**: Build tools and dependencies not in final image
3. **Faster Builds**: Can cache intermediate stages
4. **Cleaner History**: Separate concerns between build and runtime
5. **Reduced Attack Surface**: Fewer packages in production image

## 🏗️ Basic Multi-Stage Build

### Simple Example

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

### Comparison

**Single-Stage Build:**
- Final image size: ~900MB
- Includes: Node.js, npm, build tools, source code, dependencies

**Multi-Stage Build:**
- Final image size: ~150MB
- Includes: Only runtime dependencies and built artifacts

## 📊 Advanced Patterns

### Three-Stage Build

```dockerfile
# Stage 1: Dependencies
FROM node:18 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

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

# Copy production dependencies
COPY --from=deps /app/node_modules ./node_modules

# Copy built application
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs

EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### Build Arguments in Stages

```dockerfile
# Stage 1: Build with arguments
ARG NODE_VERSION=18
ARG BUILD_ENV=production

FROM node:${NODE_VERSION} AS builder
ARG BUILD_ENV
WORKDIR /app
COPY package*.json ./

# Conditional installation based on build arg
RUN if [ "$BUILD_ENV" = "development" ]; then \
      npm install; \
    else \
      npm ci --only=production; \
    fi

COPY . .
RUN npm run build

# Stage 2: Runtime
FROM node:${NODE_VERSION}-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

## 🔧 Language-Specific Examples

### Python Multi-Stage

```dockerfile
# Stage 1: Build
FROM python:3.11-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /root/.local /root/.local

# Copy application
COPY . .

# Make sure scripts in .local are usable
ENV PATH=/root/.local/bin:$PATH

# Create non-root user
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
```

### Go Multi-Stage

```dockerfile
# Stage 1: Build
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git make

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Stage 2: Runtime
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/app .

# Run binary
CMD ["./app"]
```

### Java Multi-Stage

```dockerfile
# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml
COPY pom.xml .

# Download dependencies (cached layer)
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build application
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy built JAR from builder
COPY --from=builder /app/target/*.jar app.jar

# Create non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### .NET Multi-Stage

```dockerfile
# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Copy published app from build stage
COPY --from=build /app/publish .

EXPOSE 80
ENTRYPOINT ["dotnet", "MyApp.dll"]
```

## 🎯 Advanced Techniques

### Named Stages

```dockerfile
# Stage 1: Build dependencies
FROM node:18 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Stage 2: Build application
FROM node:18 AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: Test
FROM build AS test
RUN npm test

# Stage 4: Production
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

### Conditional Stages

```dockerfile
# Build stage (always runs)
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Test stage (optional)
FROM builder AS test
RUN npm test

# Production stage
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]

# Build specific stage
# docker build --target test -t myapp:test .
# docker build --target production -t myapp:prod .
```

### Parallel Builds

```dockerfile
# Stage 1: Frontend build
FROM node:18 AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
RUN npm run build

# Stage 2: Backend build (parallel)
FROM node:18 AS backend-builder
WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm install
COPY backend/ .
RUN npm run build

# Stage 3: Combine
FROM node:18-alpine AS runtime
WORKDIR /app
COPY --from=frontend-builder /app/frontend/dist ./public
COPY --from=backend-builder /app/backend/dist ./dist
COPY --from=backend-builder /app/backend/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

## 📊 Size Comparison

### Before Multi-Stage

```bash
# Single-stage image
docker images myapp
# REPOSITORY   TAG       SIZE
# myapp        latest    1.2GB
```

### After Multi-Stage

```bash
# Multi-stage image
docker images myapp
# REPOSITORY   TAG       SIZE
# myapp        latest    180MB
```

**Savings: 85% reduction in image size**

## 🎯 Best Practices

1. **Name your stages**: Makes builds clearer and allows targeting
2. **Use specific base images**: Prefer alpine variants for runtime
3. **Copy only what's needed**: Use COPY --from selectively
4. **Leverage build cache**: Order stages to maximize cache hits
5. **Separate concerns**: Build tools in builder, runtime in final stage
6. **Use .dockerignore**: Exclude unnecessary files from build context
7. **Minimize layers**: Combine related operations in single RUN commands

## 🔍 Debugging Multi-Stage Builds

### Build Specific Stage

```bash
# Build only builder stage
docker build --target builder -t myapp:builder .

# Inspect builder stage
docker run -it myapp:builder /bin/sh
```

### Save Intermediate Stages

```bash
# Build and save all stages
docker build --target builder -t myapp:builder .
docker build --target test -t myapp:test .
docker build -t myapp:latest .
```

## 📈 Performance Tips

1. **Cache dependencies stage**: Install dependencies before copying code
2. **Parallel builds**: Use multiple builder stages for independent components
3. **Layer optimization**: Minimize layers in final stage
4. **Build cache**: Use BuildKit for better caching
5. **Selective copying**: Only copy necessary artifacts between stages

## 🎓 Learning Resources

- Docker Multi-Stage Builds: https://docs.docker.com/build/building/multi-stage/
- BuildKit: https://docs.docker.com/build/buildkit/

---

**Next**: Learn about [Docker Networking](./DOCKER-NETWORKING.md)

