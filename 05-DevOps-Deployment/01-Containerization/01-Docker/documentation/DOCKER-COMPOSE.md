# Docker Compose

## 📚 Overview

Docker Compose is a tool for defining and running multi-container Docker applications. It uses YAML files to configure application services, networks, and volumes, making it easy to orchestrate complex applications.

## 🎯 What is Docker Compose?

Docker Compose allows you to define and run multi-container Docker applications with a single command. Instead of running multiple `docker run` commands, you define your application's services, networks, and volumes in a `docker-compose.yml` file.

### Key Benefits

1. **Simplified Management**: Manage multiple containers as a single application
2. **Configuration as Code**: Define infrastructure in YAML files
3. **Environment Isolation**: Separate environments for dev, test, and production
4. **Service Dependencies**: Define and manage service dependencies
5. **Networking**: Automatic network creation and service discovery
6. **Volume Management**: Easy data persistence configuration

## 🚀 Installation

### Linux

```bash
# Docker Compose V2 (included with Docker Desktop)
# For standalone installation
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker-compose --version
# Or with Docker Compose V2
docker compose version
```

### macOS/Windows

Docker Compose is included with Docker Desktop installation.

## 📝 Basic docker-compose.yml

### Simple Example

```yaml
version: '3.8'

services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    restart: unless-stopped

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

## 🔧 Compose File Structure

### Version

```yaml
version: '3.8'  # Compose file format version
```

### Services

```yaml
services:
  service_name:
    # Service configuration
    image: nginx:alpine
    build: .
    ports:
      - "8080:80"
    environment:
      - VAR=value
    volumes:
      - ./data:/app/data
    depends_on:
      - db
```

### Networks

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### Volumes

```yaml
volumes:
  db_data:
    driver: local
  cache:
    driver: local
```

## 📊 Service Configuration

### Image

```yaml
services:
  web:
    image: nginx:alpine
    # Or use specific tag
    image: nginx:1.23.0-alpine
```

### Build

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        NODE_VERSION: 18
    # Or simple build
    build: .
```

### Ports

```yaml
services:
  web:
    ports:
      - "8080:80"           # host:container
      - "443:443"
      - "127.0.0.1:8080:80" # Bind to specific interface
      - "8080-8090:80"      # Port range
```

### Environment Variables

```yaml
services:
  app:
    environment:
      - NODE_ENV=production
      - API_URL=https://api.example.com
      - DATABASE_URL=postgres://user:pass@db:5432/mydb
    
    # Or use env file
    env_file:
      - .env
      - .env.production
    
    # Or reference
    environment:
      - NODE_ENV=${NODE_ENV:-development}
```

### Volumes

```yaml
services:
  app:
    volumes:
      # Named volume
      - db_data:/var/lib/postgresql/data
      
      # Bind mount
      - ./data:/app/data
      
      # Anonymous volume
      - /tmp
      
      # Read-only mount
      - ./config:/app/config:ro
```

### Networks

```yaml
services:
  web:
    networks:
      - frontend
      - backend
  
  db:
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### Dependencies

```yaml
services:
  web:
    depends_on:
      - db
      - redis
    
    # With health checks
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
```

### Restart Policy

```yaml
services:
  app:
    restart: always
    # Options: no, always, on-failure, unless-stopped
```

### Health Checks

```yaml
services:
  web:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

## 🔄 Common Commands

### Basic Operations

```bash
# Start services
docker-compose up

# Start in detached mode
docker-compose up -d

# Start specific services
docker-compose up web db

# Stop services
docker-compose stop

# Stop and remove containers
docker-compose down

# Stop and remove volumes
docker-compose down -v

# View logs
docker-compose logs

# Follow logs
docker-compose logs -f

# View logs for specific service
docker-compose logs web

# Execute command in service
docker-compose exec web /bin/sh

# Run one-off command
docker-compose run web npm test

# Build images
docker-compose build

# Build without cache
docker-compose build --no-cache

# Pull images
docker-compose pull

# List services
docker-compose ps

# Scale services
docker-compose up -d --scale web=3
```

### Advanced Operations

```bash
# Validate compose file
docker-compose config

# Validate and print
docker-compose config --services

# View service configuration
docker-compose config web

# Pause services
docker-compose pause

# Unpause services
docker-compose unpause

# Restart services
docker-compose restart

# Remove stopped containers
docker-compose rm

# Remove with volumes
docker-compose rm -v

# Force recreation
docker-compose up -d --force-recreate

# Recreate specific service
docker-compose up -d --no-deps --build web
```

## 📋 Complete Example

### Full Stack Application

```yaml
version: '3.8'

services:
  # Frontend
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=http://backend:5000
    depends_on:
      - backend
    networks:
      - frontend
      - backend
    volumes:
      - ./frontend:/app
      - /app/node_modules
    restart: unless-stopped

  # Backend API
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
      args:
        NODE_ENV: production
    ports:
      - "5000:5000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgres://user:password@db:5432/myapp
      - REDIS_URL=redis://redis:6379
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    networks:
      - backend
    volumes:
      - ./backend:/app
      - /app/node_modules
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  # Database
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Redis
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - backend
    restart: unless-stopped
    command: redis-server --appendonly yes

  # Nginx Reverse Proxy
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./nginx/ssl:/etc/nginx/ssl
    depends_on:
      - frontend
      - backend
    networks:
      - frontend
    restart: unless-stopped

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

## 🎯 Best Practices

### Environment Files

```yaml
# docker-compose.yml
services:
  app:
    env_file:
      - .env
      - .env.local
```

```bash
# .env
NODE_ENV=production
DATABASE_URL=postgres://user:pass@db:5432/mydb
API_KEY=secret_key
```

### Multiple Compose Files

```bash
# Base configuration
docker-compose.yml

# Override for development
docker-compose.override.yml

# Production override
docker-compose.prod.yml

# Use multiple files
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

### Production Configuration

```yaml
# docker-compose.prod.yml
version: '3.8'

services:
  app:
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
```

## 🔍 Advanced Features

### Profiles

```yaml
services:
  web:
    profiles: ["frontend"]
    # ...
  
  db:
    profiles: ["backend"]
    # ...

# Start with profile
docker-compose --profile frontend up
```

### Extensions

```yaml
# docker-compose.yml
x-common-variables: &common-variables
  POSTGRES_USER: user
  POSTGRES_PASSWORD: password

services:
  db:
    environment:
      <<: *common-variables
      POSTGRES_DB: myapp
```

### Secrets

```yaml
services:
  app:
    secrets:
      - db_password
      - api_key

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    external: true
```

## 🎓 Learning Resources

- Docker Compose Documentation: https://docs.docker.com/compose/
- Compose File Reference: https://docs.docker.com/compose/compose-file/
- Best Practices: https://docs.docker.com/compose/production/

---

**Next**: Learn about [Multi-Stage Builds](./MULTI-STAGE-BUILDS.md)

