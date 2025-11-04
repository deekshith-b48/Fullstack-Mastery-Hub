# GitHub Actions Self-Hosted Runners

## 📚 Overview

Self-hosted runners allow you to run GitHub Actions workflows on your own infrastructure. This provides more control over the environment and can be more cost-effective for large-scale usage.

## 🎯 Self-Hosted Runner Fundamentals

### What are Self-Hosted Runners?

Self-hosted runners are machines that you manage and maintain. They run GitHub Actions workflows using the runner application.

### Benefits

- **Control**: Full control over environment
- **Cost**: Can be more cost-effective
- **Customization**: Custom hardware and software
- **Security**: Enhanced security control
- **Compliance**: Meet compliance requirements

## 🚀 Setting Up Runners

### Linux Runner

```bash
# Create folder
mkdir actions-runner && cd actions-runner

# Download runner
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz

# Extract
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

# Configure
./config.sh --url https://github.com/OWNER/REPO --token TOKEN

# Install as service
sudo ./svc.sh install
sudo ./svc.sh start
```

### Windows Runner

```powershell
# Create folder
mkdir actions-runner; cd actions-runner

# Download runner
Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-win-x64-2.311.0.zip -OutFile actions-runner-win-x64-2.311.0.zip

# Extract
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD\actions-runner-win-x64-2.311.0.zip", "$PWD")

# Configure
.\config.cmd --url https://github.com/OWNER/REPO --token TOKEN

# Install as service
.\install.cmd
```

### macOS Runner

```bash
# Create folder
mkdir actions-runner && cd actions-runner

# Download runner
curl -o actions-runner-osx-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-osx-x64-2.311.0.tar.gz

# Extract
tar xzf ./actions-runner-osx-x64-2.311.0.tar.gz

# Configure
./config.sh --url https://github.com/OWNER/REPO --token TOKEN

# Install as service
./svc.sh install
./svc.sh start
```

## 🔧 Using Self-Hosted Runners

### Workflow Configuration

```yaml
jobs:
  build:
    runs-on: self-hosted
    steps:
      - uses: actions/checkout@v3
      - run: npm install
      - run: npm test
```

### Runner Labels

```yaml
jobs:
  build:
    runs-on: [self-hosted, linux, x64]
    steps:
      - run: echo "Running on self-hosted Linux runner"
```

### Multiple Runners

```yaml
jobs:
  test:
    runs-on: [self-hosted, linux]
    steps:
      - run: npm test
  
  build:
    runs-on: [self-hosted, windows]
    steps:
      - run: npm run build
```

## 🔐 Security

### Runner Security

```bash
# Use dedicated machines
# Isolate runners
# Regular updates
# Monitor runner activity
```

### Network Security

```bash
# Use VPN
# Firewall rules
# Private networks
# Access control
```

## 📊 Monitoring

### Runner Status

```bash
# Check runner status
cd actions-runner
./run.sh --check

# View logs
cat _diag/Runner_*.log
```

### GitHub Dashboard

```bash
# View runners in GitHub
# Settings > Actions > Runners
# Monitor runner activity
```

## 🎯 Best Practices

1. **Security**: Secure runner machines
2. **Updates**: Keep runners updated
3. **Monitoring**: Monitor runner health
4. **Isolation**: Isolate runners
5. **Backup**: Backup runner configurations
6. **Documentation**: Document setup
7. **Testing**: Test runner configurations

## 🎓 Learning Resources

- Self-Hosted Runners: https://docs.github.com/en/actions/hosting-your-own-runners
- Runner Security: https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions
- Managing Runners: https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners

---

**Next**: Learn about [Secrets Management](./SECRETS-MANAGEMENT.md)

