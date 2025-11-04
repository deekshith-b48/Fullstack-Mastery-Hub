# GitLab CI Runners Configuration

## 📚 Overview

GitLab CI runners are agents that execute jobs in pipelines. Configuring runners properly is essential for efficient pipeline execution.

## 🎯 Runner Types

### Shared Runners

```bash
# Available to all projects
# Managed by GitLab
# Use for general builds
```

### Specific Runners

```bash
# Assigned to specific projects
# More control
# Custom configuration
```

### Group Runners

```bash
# Available to all projects in group
# Shared across projects
# Efficient resource usage
```

## 🚀 Installing Runners

### Docker Runner

```bash
# Install GitLab Runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner

# Register runner
sudo gitlab-runner register \
  --url https://gitlab.com/ \
  --registration-token TOKEN \
  --executor docker \
  --docker-image node:18
```

### Shell Runner

```bash
# Register shell runner
sudo gitlab-runner register \
  --url https://gitlab.com/ \
  --registration-token TOKEN \
  --executor shell
```

### Kubernetes Runner

```bash
# Deploy GitLab Runner on Kubernetes
# Use Helm chart
helm install gitlab-runner gitlab/gitlab-runner
```

## 🔧 Runner Configuration

### config.toml

```toml
concurrent = 4
check_interval = 0

[[runners]]
  name = "docker-runner"
  url = "https://gitlab.com/"
  token = "TOKEN"
  executor = "docker"
  [runners.docker]
    image = "node:18"
    privileged = false
```

### Runner Tags

```yaml
job:
  tags:
    - docker
    - linux
  script:
    - npm test
```

## 📊 Runner Management

### List Runners

```bash
# List runners
gitlab-runner list

# View runner status
# GitLab > Settings > CI/CD > Runners
```

### Update Runner

```bash
# Update runner
sudo gitlab-runner restart
```

## 🎯 Best Practices

1. **Tagging**: Use tags for runner selection
2. **Monitoring**: Monitor runner health
3. **Scaling**: Scale runners as needed
4. **Security**: Secure runner connections
5. **Documentation**: Document runner setup
6. **Maintenance**: Maintain runners regularly
7. **Optimization**: Optimize runner configuration

## 🎓 Learning Resources

- Runners: https://docs.gitlab.com/runner/
- Installation: https://docs.gitlab.com/runner/install/
- Configuration: https://docs.gitlab.com/runner/configuration/

---

**Next**: Learn about [Artifacts Management](./ARTIFACTS-MANAGEMENT.md)

