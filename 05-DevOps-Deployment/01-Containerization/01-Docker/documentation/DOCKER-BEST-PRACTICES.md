# Docker Best Practices

## 📚 Overview

Following Docker best practices ensures efficient, secure, and maintainable containerized applications. This guide covers comprehensive best practices for Docker development and deployment.

## 🎯 Image Best Practices

### Use Official Base Images

```dockerfile
# ✅ Good: Official images
FROM node:18-alpine
FROM python:3.11-slim
FROM nginx:alpine

# ❌ Bad: Unofficial or outdated images
FROM someuser/node:latest
```

### Use Specific Tags

```dockerfile
# ✅ Good: Specific version
FROM node:18.16.0-alpine

# ❌ Bad: Latest tag
FROM node:latest
```

### Minimize Image Layers

```dockerfile
# ✅ Good: Combine commands
RUN apt-get update && \
    apt-get install -y package1 package2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ❌ Bad: Multiple layers
RUN apt-get update
RUN apt-get install -y package1
RUN apt-get install -y package2
```

### Leverage Build Cache

```dockerfile
# ✅ Good: Dependencies first
COPY package*.json ./
RUN npm install
COPY . .

# ❌ Bad: Code first (breaks cache)
COPY . .
RUN npm install
```

## 📝 Dockerfile Best Practices

### Use .dockerignore

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
```

### Multi-Stage Builds

```dockerfile
# ✅ Good: Multi-stage build
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/server.js"]
```

### Health Checks

```dockerfile
# ✅ Good: Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/health || exit 1
```

### Labels for Metadata

```dockerfile
# ✅ Good: Add labels
LABEL maintainer="developer@example.com"
LABEL version="1.0.0"
LABEL description="My application"
LABEL org.opencontainers.image.title="My App"
```

## 🔒 Security Best Practices

### Run as Non-Root

```dockerfile
# ✅ Good: Non-root user
RUN groupadd -r appuser && \
    useradd -r -g appuser appuser
USER appuser
```

### Minimal Base Images

```dockerfile
# ✅ Good: Alpine variant
FROM node:18-alpine

# ❌ Bad: Full OS
FROM ubuntu:22.04
```

### Scan for Vulnerabilities

```bash
# Regular scanning
docker scout cves image_name
trivy image image_name
```

### Use Secrets

```bash
# ✅ Good: Docker secrets
docker secret create my_secret secret.txt

# ❌ Bad: Environment variables
docker run -e PASSWORD=secret123 app
```

## 📊 Performance Best Practices

### Optimize Build Context

```bash
# Use .dockerignore
# Exclude unnecessary files
# Minimize build context size
```

### Use BuildKit

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1
docker build -t my-app .

# Better caching and parallel builds
```

### Layer Caching

```dockerfile
# Order FROM most to least frequently changing
FROM node:18-alpine
COPY package*.json ./  # Changes less frequently
RUN npm install
COPY . .                # Changes frequently
```

### Resource Limits

```bash
# Set appropriate limits
docker run -d \
  --memory="512m" \
  --cpus="1.0" \
  nginx
```

## 🔄 Container Best Practices

### One Process Per Container

```dockerfile
# ✅ Good: Single process
CMD ["node", "server.js"]

# ❌ Bad: Multiple processes
CMD ["sh", "-c", "node server.js & nginx &"]
```

### Use Restart Policies

```bash
# Appropriate restart policy
docker run -d --restart unless-stopped nginx
```

### Proper Logging

```bash
# Configure logging
docker run -d \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  nginx
```

### Resource Constraints

```bash
# Set limits
docker run -d \
  --memory="512m" \
  --cpus="1.0" \
  --pids-limit=100 \
  nginx
```

## 🌐 Networking Best Practices

### Custom Networks

```bash
# Create dedicated networks
docker network create app-network

# Isolate services
docker network create frontend-network
docker network create backend-network
```

### Port Security

```bash
# Bind to specific interface
docker run -d -p 127.0.0.1:8080:80 nginx

# Don't expose unnecessary ports
```

## 💾 Storage Best Practices

### Use Named Volumes

```bash
# ✅ Good: Named volumes
docker volume create app-data
docker run -d -v app-data:/data app

# ❌ Bad: Bind mounts in production
docker run -d -v /host/path:/data app
```

### Volume Permissions

```dockerfile
# Set proper permissions
RUN groupadd -r appuser && \
    useradd -r -g appuser appuser && \
    chown -R appuser:appuser /data
USER appuser
VOLUME ["/data"]
```

## 📋 Documentation Best Practices

### Document Dockerfiles

```dockerfile
# Application server
# Runs Node.js application on port 3000
FROM node:18-alpine

# Install dependencies
WORKDIR /app
COPY package*.json ./
RUN npm install --production
```

### README Files

```markdown
# Docker Setup

## Building
docker build -t my-app .

## Running
docker run -d -p 3000:3000 my-app

## Environment Variables
- NODE_ENV: production
- PORT: 3000
```

## 🔍 Monitoring Best Practices

### Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1
```

### Logging

```bash
# Structured logging
docker run -d \
  --log-driver json-file \
  --log-opt tag="{{.Name}}" \
  nginx
```

### Metrics

```bash
# Monitor container stats
docker stats container_name

# Export metrics
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

## 🎯 Development Best Practices

### Development Workflow

```bash
# Use docker-compose for development
docker-compose up -d

# Hot reload
volumes:
  - ./src:/app/src

# Development images
docker-compose -f docker-compose.dev.yml up
```

### Testing

```bash
# Test Dockerfiles
docker build -t test-image .
docker run --rm test-image npm test

# Integration tests
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
```

## 📊 Production Best Practices

### Image Tagging

```bash
# Semantic versioning
docker tag my-app:latest my-app:1.0.0
docker tag my-app:latest my-app:v1.0.0

# Git commit tags
docker tag my-app:latest my-app:$(git rev-parse --short HEAD)
```

### Deployment

```bash
# Blue-green deployment
docker-compose -f docker-compose.blue.yml up -d
# Test blue
docker-compose -f docker-compose.green.yml up -d
# Switch traffic
docker-compose -f docker-compose.blue.yml down
```

### Backup Strategy

```bash
# Backup volumes
docker run --rm \
  -v app-data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/backup.tar.gz /data
```

## 🎓 Comprehensive Checklist

### Image Checklist
- [ ] Use official base images
- [ ] Use specific tags
- [ ] Minimize layers
- [ ] Optimize build cache
- [ ] Use multi-stage builds
- [ ] Add health checks
- [ ] Include labels
- [ ] Use .dockerignore

### Security Checklist
- [ ] Run as non-root
- [ ] Use minimal images
- [ ] Scan for vulnerabilities
- [ ] Use secrets management
- [ ] Network isolation
- [ ] Resource limits
- [ ] Read-only filesystem

### Performance Checklist
- [ ] Optimize build context
- [ ] Use BuildKit
- [ ] Leverage cache
- [ ] Set resource limits
- [ ] Monitor performance
- [ ] Clean up regularly

## 📚 Learning Resources

- Docker Best Practices: https://docs.docker.com/develop/dev-best-practices/
- Dockerfile Best Practices: https://docs.docker.com/develop/dev-best-practices/developing-images/dockerfile_best-practices/
- Production Best Practices: https://docs.docker.com/develop/dev-best-practices/developing-images/guidelines/

---

**Next**: Learn about [Docker Performance](./DOCKER-PERFORMANCE.md)

