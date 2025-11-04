# Docker Networking

## 📚 Overview

Docker networking enables containers to communicate with each other and with the outside world. Understanding Docker networking is crucial for building distributed applications and managing container communication.

## 🎯 Docker Network Types

### Bridge Network (Default)

The bridge network is the default network type for containers. It provides isolation from the host network while allowing containers on the same bridge to communicate.

```bash
# Create bridge network
docker network create my-bridge

# Inspect network
docker network inspect my-bridge

# Connect container to network
docker network connect my-bridge container_name

# Run container on specific network
docker run -d --network my-bridge nginx
```

### Host Network

Host network mode removes network isolation between containers and the host, using the host's network directly.

```bash
# Run container on host network
docker run -d --network host nginx

# Container uses host's network stack
# No port mapping needed
```

### None Network

None network mode disables all networking for a container.

```bash
# Run container without network
docker run -d --network none alpine

# Container has no network access
```

### Overlay Network

Overlay networks enable multi-host networking for Docker Swarm or Kubernetes clusters.

```bash
# Create overlay network (requires swarm)
docker swarm init
docker network create --driver overlay my-overlay

# Services can communicate across hosts
docker service create --network my-overlay nginx
```

### Macvlan Network

Macvlan networks allow containers to appear as physical devices on the network with their own MAC addresses.

```bash
# Create macvlan network
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  my-macvlan

# Container gets IP from physical network
docker run -d --network my-macvlan nginx
```

## 🔧 Network Configuration

### Creating Custom Networks

```bash
# Basic network
docker network create my-network

# Network with subnet
docker network create --subnet=172.20.0.0/16 my-network

# Network with gateway
docker network create --subnet=172.20.0.0/16 \
  --gateway=172.20.0.1 my-network

# Network with IP range
docker network create --subnet=172.20.0.0/16 \
  --ip-range=172.20.240.0/20 my-network

# Network with custom driver
docker network create --driver bridge my-network
```

### Network Options

```bash
# Network with custom options
docker network create \
  --driver bridge \
  --opt com.docker.network.bridge.name=br0 \
  --opt com.docker.network.bridge.enable_icc=true \
  --opt com.docker.network.bridge.enable_ip_masquerade=true \
  my-network
```

## 🔗 Container Communication

### Same Network

```bash
# Create network
docker network create app-network

# Run containers on same network
docker run -d --name web --network app-network nginx
docker run -d --name db --network app-network postgres

# Containers can communicate by name
# web can access db at: http://db:5432
```

### Docker Compose Networking

```yaml
version: '3.8'

services:
  web:
    image: nginx
    networks:
      - frontend
  
  api:
    image: node:18
    networks:
      - frontend
      - backend
  
  db:
    image: postgres
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### Service Discovery

Containers on the same network can discover each other using container names.

```bash
# Container names resolve to IPs
docker run -d --name web nginx
docker run -d --name app --network container:web alpine

# web can be accessed by name from other containers
```

## 🌐 Port Mapping

### Basic Port Mapping

```bash
# Map host port to container port
docker run -d -p 8080:80 nginx

# Map to specific interface
docker run -d -p 127.0.0.1:8080:80 nginx

# Map random host port
docker run -d -p 80 nginx

# Map UDP port
docker run -d -p 8080:80/udp nginx

# Map multiple ports
docker run -d -p 8080:80 -p 8443:443 nginx
```

### Port Range Mapping

```bash
# Map port range
docker run -d -p 8080-8090:80-90 nginx

# Map TCP and UDP
docker run -d -p 8080:80/tcp -p 8080:80/udp nginx
```

## 🔍 Network Inspection

### Inspect Network

```bash
# Inspect network details
docker network inspect bridge

# Inspect specific network
docker network inspect my-network

# Show network configuration
docker network ls
```

### Container Network Info

```bash
# Show container network settings
docker inspect container_name | grep -A 20 NetworkSettings

# Show container IP address
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name

# Show container ports
docker port container_name
```

## 🔄 Network Management

### Connect/Disconnect

```bash
# Connect container to network
docker network connect my-network container_name

# Disconnect container from network
docker network disconnect my-network container_name

# Connect with alias
docker network connect --alias web my-network container_name
```

### Remove Networks

```bash
# Remove network
docker network rm my-network

# Remove all unused networks
docker network prune

# Force remove (disconnect containers first)
docker network rm -f my-network
```

## 🛡️ Network Security

### Network Isolation

```bash
# Isolated network (no external access)
docker network create --internal isolated-network

# Containers can only communicate internally
docker run -d --network isolated-network nginx
```

### Firewall Rules

```bash
# Network with custom firewall rules
docker network create \
  --opt com.docker.network.bridge.enable_icc=false \
  isolated-network

# Disable inter-container communication
```

## 📊 Advanced Networking

### Custom Bridge

```bash
# Create custom bridge
docker network create \
  --driver bridge \
  --subnet=172.25.0.0/16 \
  --gateway=172.25.0.1 \
  --opt com.docker.network.bridge.name=docker1 \
  custom-bridge
```

### DNS Configuration

```bash
# Network with custom DNS
docker network create \
  --dns=8.8.8.8 \
  --dns=8.8.4.4 \
  my-network

# Run container with custom DNS
docker run -d --dns=1.1.1.1 nginx
```

### Network Aliases

```bash
# Create network with alias
docker network create my-network

# Run container with alias
docker run -d --name web --network-alias nginx my-network nginx

# Other containers can access using alias
docker run -it --network my-network alpine ping nginx
```

## 🔧 Troubleshooting

### Network Connectivity Issues

```bash
# Check network connectivity
docker exec container_name ping other_container

# Check DNS resolution
docker exec container_name nslookup other_container

# Check network routes
docker exec container_name ip route

# Check network interfaces
docker exec container_name ip addr
```

### Network Debugging

```bash
# List all networks
docker network ls

# Inspect network details
docker network inspect network_name

# Check container network
docker inspect container_name | grep NetworkSettings

# Test network connectivity
docker run -it --rm --network my-network alpine ping hostname
```

## 🎯 Best Practices

1. **Use custom networks**: Create dedicated networks for applications
2. **Network isolation**: Separate frontend and backend networks
3. **Service discovery**: Use container names for communication
4. **Port mapping**: Only expose necessary ports
5. **Network security**: Use internal networks when external access not needed
6. **Network naming**: Use descriptive network names
7. **Cleanup**: Remove unused networks regularly

## 📈 Performance Optimization

### Network Performance

```bash
# Use host network for maximum performance
docker run -d --network host nginx

# Use overlay network for multi-host
docker network create --driver overlay fast-overlay

# Optimize bridge network
docker network create \
  --opt com.docker.network.bridge.mtu=1500 \
  optimized-network
```

## 🎓 Learning Resources

- Docker Networking: https://docs.docker.com/network/
- Network Drivers: https://docs.docker.com/network/drivers/
- Container Networking: https://docs.docker.com/config/containers/container-networking/

---

**Next**: Learn about [Docker Storage](./DOCKER-STORAGE.md)

