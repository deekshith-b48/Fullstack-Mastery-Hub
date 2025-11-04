# Docker Fundamentals

## 📚 Overview

Docker is a platform for developing, shipping, and running applications using containerization. It packages applications and their dependencies into lightweight, portable containers that can run consistently across different environments.

## 🎯 What is Docker?

Docker is an open-source containerization platform that enables developers to package applications into containers—standardized executable components combining application source code with the operating system libraries and dependencies required to run that code in any environment.

### Key Concepts

- **Container**: A lightweight, standalone, executable package that includes everything needed to run an application
- **Image**: A read-only template used to create containers
- **Dockerfile**: A text file containing instructions for building Docker images
- **Registry**: A repository for storing and distributing Docker images
- **Docker Engine**: The runtime that builds, runs, and manages containers

### Benefits of Docker

1. **Consistency**: Same environment across development, testing, and production
2. **Isolation**: Applications run in isolated containers
3. **Portability**: Containers run anywhere Docker is installed
4. **Scalability**: Easy to scale applications horizontally
5. **Efficiency**: Lightweight compared to virtual machines
6. **Version Control**: Images can be versioned and tagged

## 🚀 Installation

### Linux (Ubuntu/Debian)

```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
sudo docker run hello-world
```

### macOS

```bash
# Install Docker Desktop for Mac
# Download from: https://www.docker.com/products/docker-desktop

# Or using Homebrew
brew install --cask docker
```

### Windows

```bash
# Install Docker Desktop for Windows
# Download from: https://www.docker.com/products/docker-desktop

# Requires Windows 10/11 Pro, Enterprise, or Education (64-bit)
# Or Windows 11 Home with WSL 2 backend
```

## 🔧 Basic Commands

### Docker Version

```bash
# Check Docker version
docker --version

# Detailed version information
docker version

# System information
docker info
```

### Working with Images

```bash
# List images
docker images

# Pull image from registry
docker pull nginx:latest

# Search for images
docker search nginx

# Remove image
docker rmi nginx:latest

# Remove all unused images
docker image prune -a
```

### Working with Containers

```bash
# Run container
docker run nginx

# Run container in detached mode
docker run -d nginx

# Run container with name
docker run -d --name my-nginx nginx

# Run container with port mapping
docker run -d -p 8080:80 nginx

# Run container with environment variables
docker run -d -e ENV_VAR=value nginx

# Run container with volume
docker run -d -v /host/path:/container/path nginx

# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop container_name

# Start stopped container
docker start container_name

# Restart container
docker restart container_name

# Remove container
docker rm container_name

# Remove all stopped containers
docker container prune

# Execute command in running container
docker exec -it container_name /bin/bash

# View container logs
docker logs container_name

# Follow logs
docker logs -f container_name
```

## 📦 Building Images

### Basic Dockerfile

```dockerfile
# Use official base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Define command to run
CMD ["npm", "start"]
```

### Build Image

```bash
# Build image
docker build -t my-app:latest .

# Build with tag
docker build -t my-app:v1.0.0 .

# Build with no cache
docker build --no-cache -t my-app:latest .
```

## 🔄 Container Lifecycle

### Container States

1. **Created**: Container created but not started
2. **Running**: Container is currently running
3. **Paused**: Container execution is paused
4. **Stopped**: Container stopped but not removed
5. **Removed**: Container deleted

### Managing States

```bash
# Create container without starting
docker create --name my-container nginx

# Start container
docker start my-container

# Stop container
docker stop my-container

# Pause container
docker pause my-container

# Unpause container
docker unpause my-container

# Restart container
docker restart my-container

# Kill container (force stop)
docker kill my-container
```

## 🌐 Docker Networking

### Network Types

```bash
# List networks
docker network ls

# Create network
docker network create my-network

# Inspect network
docker network inspect my-network

# Connect container to network
docker network connect my-network container_name

# Disconnect container from network
docker network disconnect my-network container_name

# Remove network
docker network rm my-network
```

### Default Networks

- **bridge**: Default network for containers
- **host**: Uses host's network directly
- **none**: No network access
- **overlay**: For swarm services

## 💾 Docker Volumes

### Volume Management

```bash
# List volumes
docker volume ls

# Create volume
docker volume create my-volume

# Inspect volume
docker volume inspect my-volume

# Remove volume
docker volume rm my-volume

# Remove all unused volumes
docker volume prune
```

### Using Volumes

```bash
# Named volume
docker run -d -v my-volume:/data nginx

# Bind mount
docker run -d -v /host/path:/container/path nginx

# Anonymous volume
docker run -d -v /data nginx
```

## 🔍 Container Inspection

### Inspect Commands

```bash
# Inspect container
docker inspect container_name

# Inspect image
docker inspect image_name

# Container statistics
docker stats container_name

# Container processes
docker top container_name

# Container events
docker events
```

## 🎯 Best Practices

1. **Use official base images** when possible
2. **Keep images small** by using multi-stage builds
3. **Use .dockerignore** to exclude unnecessary files
4. **Tag images** with meaningful version numbers
5. **Run one process** per container
6. **Use volumes** for persistent data
7. **Set resource limits** to prevent resource exhaustion
8. **Scan images** for security vulnerabilities
9. **Use health checks** for container monitoring
10. **Document Dockerfiles** with comments

## 🔒 Security Considerations

### Security Best Practices

```bash
# Run containers as non-root user
USER appuser

# Use specific image tags (not 'latest')
FROM node:18-alpine

# Scan images for vulnerabilities
docker scan image_name

# Use secrets management
docker secret create my_secret secret.txt

# Limit container resources
docker run --memory="512m" --cpus="1.0" nginx
```

## 📊 Performance Optimization

### Optimization Tips

1. **Use multi-stage builds** to reduce image size
2. **Layer caching**: Order Dockerfile instructions to maximize cache hits
3. **Use .dockerignore** to reduce build context
4. **Minimize layers**: Combine RUN commands where possible
5. **Use specific base images**: Prefer alpine variants
6. **Remove unnecessary files**: Clean up package caches
7. **Use build cache**: Leverage Docker's build cache

## 🎓 Learning Resources

- Official Docker Documentation: https://docs.docker.com/
- Docker Hub: https://hub.docker.com/
- Docker Best Practices: https://docs.docker.com/develop/dev-best-practices/
- Docker Security: https://docs.docker.com/engine/security/

---

**Next**: Learn about [Dockerfile Mastery](./DOCKERFILE-MASTERY.md)

