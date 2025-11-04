co# Docker Performance

## 📚 Overview

Optimizing Docker performance is essential for efficient containerized applications. This guide covers performance tuning, monitoring, and optimization techniques for Docker containers and images.

## 🚀 Performance Optimization

### Image Size Optimization

#### Use Multi-Stage Builds

```dockerfile
# Reduce final image size
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
# Final image: ~150MB vs ~900MB
```

#### Use Alpine Images

```dockerfile
# ✅ Good: Alpine (smaller)
FROM node:18-alpine  # ~50MB

# ❌ Bad: Full image
FROM node:18  # ~900MB
```

#### Remove Unnecessary Files

```dockerfile
# Clean up package managers
RUN apt-get update && \
    apt-get install -y package && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clean npm cache
RUN npm install && \
    npm cache clean --force
```

### Build Performance

#### Use BuildKit

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1
docker build -t my-app .

# Better caching and parallel builds
# Faster builds with cache mounts
```

#### Cache Mounts

```dockerfile
# syntax=docker/dockerfile:1.4
FROM node:18
RUN --mount=type=cache,target=/root/.npm \
    npm install
# Cache persists between builds
```

#### Parallel Builds

```dockerfile
# Build multiple stages in parallel
FROM node:18 AS frontend-builder
# ... frontend build

FROM node:18 AS backend-builder
# ... backend build

FROM node:18-alpine
COPY --from=frontend-builder /app/dist ./public
COPY --from=backend-builder /app/dist ./dist
```

### Layer Caching

#### Optimize Layer Order

```dockerfile
# ✅ Good: Dependencies first
COPY package*.json ./
RUN npm install
COPY . .

# ❌ Bad: Code first
COPY . .
RUN npm install  # Cache always invalid
```

#### Combine Commands

```dockerfile
# ✅ Good: One layer
RUN apt-get update && \
    apt-get install -y package && \
    apt-get clean

# ❌ Bad: Multiple layers
RUN apt-get update
RUN apt-get install -y package
```

## 📊 Container Performance

### Resource Limits

#### Memory Limits

```bash
# Set memory limit
docker run -d --memory="512m" nginx

# With swap
docker run -d \
  --memory="512m" \
  --memory-swap="1g" \
  nginx

# OOM kill priority
docker run -d --oom-kill-disable nginx
```

#### CPU Limits

```bash
# Limit CPU
docker run -d --cpus="1.0" nginx

# CPU shares
docker run -d --cpu-shares=512 nginx

# CPU set
docker run -d --cpuset-cpus="0,1" nginx
```

#### I/O Limits

```bash
# Limit block I/O
docker run -d \
  --device-read-bps /dev/sda:1mb \
  --device-write-bps /dev/sda:1mb \
  --device-read-iops /dev/sda:100 \
  --device-write-iops /dev/sda:100 \
  nginx
```

### Storage Performance

#### Use Appropriate Storage Driver

```bash
# Overlay2 (recommended)
# Fast and efficient
# Configure in daemon.json
{
  "storage-driver": "overlay2"
}
```

#### Volume Performance

```bash
# Local volumes (fastest)
docker volume create --driver local my-volume

# tmpfs for temporary data
docker run -d --tmpfs /tmp nginx

# Avoid bind mounts for performance-critical data
```

### Network Performance

#### Use Host Network (if appropriate)

```bash
# Maximum network performance
docker run -d --network host nginx

# No port mapping overhead
```

#### Optimize Bridge Network

```bash
# Custom bridge with optimizations
docker network create \
  --opt com.docker.network.bridge.mtu=1500 \
  --opt com.docker.network.bridge.enable_icc=true \
  optimized-network
```

## 🔍 Performance Monitoring

### Container Stats

```bash
# Real-time stats
docker stats

# Specific container
docker stats container_name

# One-time stats
docker stats --no-stream

# Custom format
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
```

### System Metrics

```bash
# System information
docker system df

# Detailed disk usage
docker system df -v

# Docker info
docker info
```

### Performance Profiling

```bash
# Container events
docker events

# Container logs
docker logs container_name

# Inspect container
docker inspect container_name
```

## 🎯 Optimization Strategies

### Build Optimization

#### Minimize Build Context

```bash
# Use .dockerignore
# Exclude unnecessary files
# Reduce context size
```

#### Parallel Builds

```bash
# Build multiple images in parallel
docker build -t app1:latest ./app1 &
docker build -t app2:latest ./app2 &
wait
```

#### Build Cache

```bash
# Use cache from previous build
docker build --cache-from my-app:previous .

# Share cache between builds
```

### Runtime Optimization

#### Container Lifecycle

```bash
# Use restart policies
docker run -d --restart unless-stopped nginx

# Health checks
HEALTHCHECK --interval=30s CMD curl -f http://localhost/ || exit 1
```

#### Resource Allocation

```bash
# Appropriate limits
docker run -d \
  --memory="512m" \
  --cpus="1.0" \
  --pids-limit=100 \
  nginx
```

## 📈 Performance Benchmarks

### Image Pull Performance

```bash
# Time image pull
time docker pull nginx:alpine

# Compare different images
# Alpine: ~50MB
# Standard: ~150MB
# Full: ~500MB
```

### Build Performance

```bash
# Time build
time docker build -t my-app .

# With cache
time docker build -t my-app .

# Without cache
time docker build --no-cache -t my-app .
```

### Container Startup

```bash
# Time container startup
time docker run --rm nginx echo "Started"

# Compare startup times
# Minimal images start faster
```

## 🔧 Performance Tuning

### Docker Daemon Tuning

```json
// /etc/docker/daemon.json
{
  "storage-driver": "overlay2",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 64000,
      "Soft": 64000
    }
  }
}
```

### Kernel Parameters

```bash
# Increase file descriptors
ulimit -n 65536

# Optimize network buffers
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
```

### Storage Driver Optimization

```bash
# Overlay2 options
{
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.size=20G"
  ]
}
```

## 📊 Performance Metrics

### Key Metrics

1. **Image Size**: Smaller is better
2. **Build Time**: Faster builds
3. **Startup Time**: Quick container startup
4. **Memory Usage**: Efficient memory usage
5. **CPU Usage**: Optimal CPU utilization
6. **I/O Performance**: Fast disk operations
7. **Network Throughput**: High network performance

### Monitoring Tools

```bash
# cAdvisor
docker run -d \
  --name=cadvisor \
  -p 8080:8080 \
  -v /:/rootfs:ro \
  -v /var/run:/var/run:ro \
  -v /sys:/sys:ro \
  -v /var/lib/docker/:/var/lib/docker:ro \
  google/cadvisor:latest

# Prometheus
# Collect Docker metrics
```

## 🎯 Best Practices Summary

1. **Use multi-stage builds**: Reduce image size
2. **Leverage build cache**: Faster builds
3. **Set resource limits**: Prevent resource exhaustion
4. **Use appropriate storage**: Optimize I/O performance
5. **Monitor performance**: Track metrics regularly
6. **Optimize networks**: Use appropriate network types
7. **Clean up regularly**: Remove unused resources
8. **Use BuildKit**: Better build performance
9. **Minimize layers**: Fewer layers = faster builds
10. **Profile and optimize**: Measure before optimizing

## 🔄 Performance Testing

### Load Testing

```bash
# Stress test container
docker run --rm -it --cpus="1.0" \
  progrium/stress --cpu 1 --timeout 60s

# Memory stress test
docker run --rm -it --memory="512m" \
  progrium/stress --vm 1 --vm-bytes 256M --timeout 60s
```

### Benchmark Scripts

```bash
#!/bin/bash
# Benchmark container performance
echo "Building image..."
time docker build -t test-image .

echo "Starting container..."
time docker run --rm test-image echo "Started"

echo "Container stats..."
docker stats --no-stream test-container
```

## 🎓 Learning Resources

- Docker Performance: https://docs.docker.com/config/containers/resource_constraints/
- BuildKit: https://docs.docker.com/build/buildkit/
- Performance Best Practices: https://docs.docker.com/develop/dev-best-practices/

---

**Docker section complete!** Next: Learn about [Kubernetes Fundamentals](./../02-Kubernetes/documentation/KUBERNETES-FUNDAMENTALS.md)

