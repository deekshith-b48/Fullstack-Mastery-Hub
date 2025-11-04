# Docker Security

## 📚 Overview

Docker security is crucial for protecting containerized applications and infrastructure. This guide covers security best practices, vulnerabilities, and hardening techniques for Docker environments.

## 🛡️ Security Fundamentals

### Security Principles

1. **Principle of Least Privilege**: Containers should run with minimal required permissions
2. **Defense in Depth**: Multiple security layers
3. **Image Scanning**: Regularly scan images for vulnerabilities
4. **Network Isolation**: Isolate container networks
5. **Resource Limits**: Prevent resource exhaustion attacks
6. **Secrets Management**: Secure handling of sensitive data

## 🔒 Container Security

### Run as Non-Root

```dockerfile
# Create non-root user
RUN groupadd -r appuser && \
    useradd -r -g appuser appuser

# Switch to non-root user
USER appuser

# Example
FROM node:18-alpine
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs
WORKDIR /app
COPY . .
CMD ["node", "server.js"]
```

### Read-Only Filesystem

```bash
# Run container with read-only root filesystem
docker run -d --read-only nginx

# With writable tmpfs for /tmp
docker run -d --read-only --tmpfs /tmp nginx
```

### Remove Unnecessary Capabilities

```bash
# Drop all capabilities and add only required
docker run -d --cap-drop ALL --cap-add NET_BIND_SERVICE nginx

# List of capabilities
# CAP_NET_BIND_SERVICE: Bind to ports < 1024
# CAP_SYS_ADMIN: Administrative operations
# CAP_DAC_OVERRIDE: Override file permissions
```

### Security Options

```bash
# Disable new privileges
docker run -d --security-opt no-new-privileges nginx

# AppArmor profile
docker run -d --security-opt apparmor=my-profile nginx

# SELinux label
docker run -d --security-opt label=type:container_t nginx
```

## 🔐 Image Security

### Use Official Images

```dockerfile
# ✅ Good: Use official images
FROM node:18-alpine

# ❌ Bad: Use untrusted images
FROM some-unknown-user/node:18
```

### Specific Image Tags

```dockerfile
# ✅ Good: Use specific version
FROM node:18.16.0-alpine

# ❌ Bad: Use latest tag
FROM node:latest
```

### Scan Images for Vulnerabilities

```bash
# Scan image with Docker Scout
docker scout cves image_name

# Scan with Trivy
trivy image image_name

# Scan with Snyk
snyk test --docker image_name
```

### Minimal Base Images

```dockerfile
# ✅ Good: Use minimal base image
FROM node:18-alpine

# ❌ Bad: Use full OS image
FROM ubuntu:22.04
```

## 🔑 Secrets Management

### Docker Secrets

```bash
# Create secret
echo "my-secret" | docker secret create my_secret -

# Use secret in service
docker service create \
  --secret my_secret \
  --name my-service \
  nginx

# Secrets mounted at /run/secrets/
```

### Environment Variables

```bash
# ❌ Bad: Hardcoded secrets
docker run -d -e PASSWORD=secret123 app

# ✅ Good: Use Docker secrets or env files
docker run -d --env-file .env.production app
```

### Build Secrets (BuildKit)

```dockerfile
# Use build secrets
# syntax=docker/dockerfile:1.4
FROM node:18
RUN --mount=type=secret,id=mysecret \
    cat /run/secrets/mysecret
```

## 🌐 Network Security

### Network Isolation

```bash
# Create isolated network
docker network create --internal isolated-network

# Containers can't access external network
docker run -d --network isolated-network nginx
```

### Firewall Rules

```bash
# Configure iptables for Docker
# Allow specific ports only
iptables -A DOCKER -p tcp --dport 80 -j ACCEPT
iptables -A DOCKER -p tcp --dport 443 -j ACCEPT
iptables -A DOCKER -j DROP
```

### Port Security

```bash
# Bind to specific interface
docker run -d -p 127.0.0.1:8080:80 nginx

# Don't expose unnecessary ports
# Only expose required ports
```

## 📊 Resource Limits

### Memory Limits

```bash
# Limit memory
docker run -d --memory="512m" nginx

# Memory limit with swap
docker run -d --memory="512m" --memory-swap="1g" nginx

# OOM kill priority
docker run -d --oom-kill-disable nginx
```

### CPU Limits

```bash
# Limit CPU usage
docker run -d --cpus="1.0" nginx

# CPU shares (relative priority)
docker run -d --cpu-shares=512 nginx

# CPU set
docker run -d --cpuset-cpus="0,1" nginx
```

### I/O Limits

```bash
# Limit block I/O
docker run -d \
  --device-read-bps /dev/sda:1mb \
  --device-write-bps /dev/sda:1mb \
  nginx
```

## 🔍 Security Scanning

### Image Vulnerability Scanning

```bash
# Docker Scout
docker scout cves image_name

# Trivy
trivy image image_name

# Snyk
snyk test --docker image_name

# Clair
clair-scanner --ip host_ip image_name
```

### Container Runtime Scanning

```bash
# Falco for runtime security
falco -r /etc/falco/falco_rules.yaml

# Monitor container behavior
# Detect suspicious activities
```

## 🛠️ Docker Daemon Security

### TLS Configuration

```bash
# Generate certificates
mkdir /etc/docker/certs
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

# Configure Docker daemon
# /etc/docker/daemon.json
{
  "tls": true,
  "tlsverify": true,
  "tlscacert": "/etc/docker/certs/ca.pem",
  "tlscert": "/etc/docker/certs/server-cert.pem",
  "tlskey": "/etc/docker/certs/server-key.pem"
}
```

### User Namespace

```bash
# Enable user namespace
# /etc/docker/daemon.json
{
  "userns-remap": "default"
}

# Map container root to host non-root user
```

### Content Trust

```bash
# Enable Docker Content Trust
export DOCKER_CONTENT_TRUST=1

# Sign images
docker trust sign image_name

# Verify signatures
docker trust inspect image_name
```

## 📋 Security Checklist

### Image Security

- [ ] Use official base images
- [ ] Use specific image tags (not latest)
- [ ] Scan images for vulnerabilities
- [ ] Use minimal base images
- [ ] Keep images updated
- [ ] Remove unnecessary packages
- [ ] Use multi-stage builds

### Container Security

- [ ] Run as non-root user
- [ ] Use read-only filesystem
- [ ] Drop unnecessary capabilities
- [ ] Set resource limits
- [ ] Use security options
- [ ] Isolate networks
- [ ] Limit exposed ports

### Runtime Security

- [ ] Enable logging
- [ ] Monitor container behavior
- [ ] Use secrets management
- [ ] Encrypt volumes
- [ ] Regular security audits
- [ ] Update Docker regularly

## 🎯 Best Practices

1. **Scan regularly**: Scan images for vulnerabilities
2. **Keep updated**: Update base images and Docker
3. **Minimal images**: Use minimal base images
4. **Non-root**: Run containers as non-root
5. **Network isolation**: Isolate container networks
6. **Secrets**: Use proper secrets management
7. **Resource limits**: Set appropriate limits
8. **Monitoring**: Monitor container behavior
9. **Documentation**: Document security configurations
10. **Training**: Keep team trained on security

## 🔄 Security Updates

### Updating Images

```bash
# Pull latest security updates
docker pull node:18-alpine

# Rebuild images with updated base
docker build --no-cache -t my-app:latest .

# Update running containers
docker-compose pull
docker-compose up -d
```

### Patching Strategy

1. **Regular updates**: Update base images monthly
2. **Security patches**: Apply security patches immediately
3. **Version control**: Pin specific versions
4. **Testing**: Test updates before production
5. **Rollback plan**: Have rollback procedure ready

## 🎓 Learning Resources

- Docker Security: https://docs.docker.com/engine/security/
- Best Practices: https://docs.docker.com/develop/dev-best-practices/
- CIS Docker Benchmark: https://www.cisecurity.org/benchmark/docker

---

**Next**: Learn about [Docker Best Practices](./DOCKER-BEST-PRACTICES.md)

