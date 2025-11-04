# Docker Storage

## 📚 Overview

Docker storage manages data persistence and container filesystems. Understanding Docker storage is essential for managing application data, volumes, and container state.

## 🎯 Storage Drivers

### Storage Driver Types

Docker uses storage drivers to manage how images and containers are stored and accessed on the host system.

### Overlay2 (Recommended)

Overlay2 is the recommended storage driver for most Linux distributions.

```bash
# Check current storage driver
docker info | grep Storage

# Configure overlay2 in daemon.json
{
  "storage-driver": "overlay2"
}
```

### Other Storage Drivers

- **devicemapper**: Block-level storage
- **btrfs**: Copy-on-write filesystem
- **zfs**: ZFS filesystem
- **aufs**: Union filesystem (deprecated)

## 💾 Volumes

### Named Volumes

Named volumes are managed by Docker and stored in Docker's storage directory.

```bash
# Create named volume
docker volume create my-volume

# Inspect volume
docker volume inspect my-volume

# List volumes
docker volume ls

# Remove volume
docker volume rm my-volume

# Remove all unused volumes
docker volume prune
```

### Using Named Volumes

```bash
# Create and use volume
docker volume create postgres_data
docker run -d -v postgres_data:/var/lib/postgresql/data postgres

# Volume with specific driver
docker volume create --driver local \
  --opt type=none \
  --opt device=/host/path \
  --opt o=bind \
  my-volume
```

### Bind Mounts

Bind mounts map a host directory directly into a container.

```bash
# Bind mount
docker run -d -v /host/path:/container/path nginx

# Read-only bind mount
docker run -d -v /host/path:/container/path:ro nginx

# Bind mount with specific options
docker run -d -v /host/path:/container/path:rw,noexec,nosuid nginx
```

### Anonymous Volumes

Anonymous volumes are created automatically when no volume name is specified.

```bash
# Anonymous volume
docker run -d -v /data nginx

# Volume created automatically
# Can be referenced by generated name
```

## 📁 Dockerfile Volumes

### VOLUME Instruction

```dockerfile
# Define volume in Dockerfile
FROM nginx:alpine
VOLUME ["/var/log", "/var/cache"]

# Volume created when container starts
# Data persists even if container removed
```

## 🔄 Volume Management

### Volume Backup

```bash
# Backup volume
docker run --rm \
  -v postgres_data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/postgres_backup.tar.gz /data

# Restore volume
docker run --rm \
  -v postgres_data:/data \
  -v $(pwd):/backup \
  alpine sh -c "cd /data && tar xzf /backup/postgres_backup.tar.gz"
```

### Volume Inspection

```bash
# Inspect volume details
docker volume inspect my-volume

# Find volume mount point
docker volume inspect my-volume | grep Mountpoint

# Access volume data directly
sudo ls -la /var/lib/docker/volumes/my-volume/_data
```

## 🔧 Volume Drivers

### Local Driver

```bash
# Create volume with local driver
docker volume create \
  --driver local \
  --opt type=tmpfs \
  --opt device=tmpfs \
  --opt o=size=100m,uid=1000 \
  my-tmpfs-volume
```

### NFS Driver

```bash
# Create volume with NFS driver
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.100 \
  --opt device=:/path/to/nfs \
  my-nfs-volume
```

### Plugin Drivers

```bash
# Install volume plugin
docker plugin install vieux/sshfs

# Create volume with plugin
docker volume create \
  --driver vieux/sshfs \
  --opt sshcmd=user@host:/path \
  --opt password=secret \
  my-ssh-volume
```

## 📊 Storage Optimization

### Image Size Optimization

```dockerfile
# Use multi-stage builds
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
# Smaller final image
```

### Layer Optimization

```dockerfile
# Combine RUN commands to reduce layers
RUN apt-get update && \
    apt-get install -y package1 package2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### .dockerignore

```dockerfile
# .dockerignore
node_modules
.git
*.log
.env
.DS_Store
```

## 🔍 Storage Inspection

### Disk Usage

```bash
# Show disk usage
docker system df

# Detailed disk usage
docker system df -v

# Show volume disk usage
docker system df -v | grep -A 5 Volumes
```

### Cleanup

```bash
# Remove unused data
docker system prune

# Remove all unused volumes
docker system prune --volumes

# Remove all unused images
docker image prune -a

# Remove all stopped containers
docker container prune
```

## 🛡️ Storage Security

### Volume Permissions

```dockerfile
# Set proper permissions in Dockerfile
RUN groupadd -r appuser && \
    useradd -r -g appuser appuser && \
    chown -R appuser:appuser /data
USER appuser
VOLUME ["/data"]
```

### Secure Volume Mounts

```bash
# Mount with specific permissions
docker run -d \
  -v my-volume:/data:rw,noexec,nosuid \
  nginx

# Read-only mount for sensitive data
docker run -d \
  -v config:/app/config:ro \
  nginx
```

## 📈 Performance Tips

### Storage Driver Performance

```bash
# Use overlay2 for best performance
# Configure in /etc/docker/daemon.json
{
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.size=20G"
  ]
}
```

### Volume Performance

```bash
# Use local volumes for better performance
docker volume create --driver local my-volume

# Use tmpfs for temporary data
docker run -d --tmpfs /tmp nginx
```

## 🎯 Best Practices

1. **Use named volumes**: For persistent data
2. **Use bind mounts**: For development
3. **Backup volumes**: Regularly backup important data
4. **Clean up**: Remove unused volumes regularly
5. **Optimize images**: Use multi-stage builds
6. **Monitor disk usage**: Regularly check storage usage
7. **Set permissions**: Configure proper volume permissions

## 🔄 Volume Migration

### Export Volume

```bash
# Export volume to tar
docker run --rm \
  -v my-volume:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/volume.tar.gz -C /data .
```

### Import Volume

```bash
# Create new volume
docker volume create new-volume

# Import from tar
docker run --rm \
  -v new-volume:/data \
  -v $(pwd):/backup \
  alpine tar xzf /backup/volume.tar.gz -C /data
```

## 📊 Storage Metrics

### Monitoring Storage

```bash
# Check Docker storage
docker system df

# Monitor specific volume
docker volume inspect my-volume

# Check filesystem usage
df -h /var/lib/docker
```

## 🎓 Learning Resources

- Docker Storage: https://docs.docker.com/storage/
- Volume Drivers: https://docs.docker.com/storage/volumes/
- Storage Drivers: https://docs.docker.com/storage/storagedriver/

---

**Next**: Learn about [Docker Security](./DOCKER-SECURITY.md)

