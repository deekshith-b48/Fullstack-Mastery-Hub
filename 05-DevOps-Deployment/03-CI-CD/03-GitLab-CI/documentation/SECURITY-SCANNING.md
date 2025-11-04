# GitLab CI Security Scanning

## 📚 Overview

GitLab CI provides built-in security scanning capabilities to identify vulnerabilities in code, dependencies, and containers.

## 🎯 Security Scanning Features

### Scanning Types

- **SAST**: Static Application Security Testing
- **DAST**: Dynamic Application Security Testing
- **Dependency Scanning**: Scan dependencies
- **Container Scanning**: Scan container images
- **License Scanning**: Scan licenses

## 🚀 Enabling Scanning

### SAST

```yaml
include:
  - template: Security/SAST.gitlab-ci.yml

sast:
  variables:
    SAST_EXCLUDED_ANALYZERS: "bandit"
```

### Dependency Scanning

```yaml
include:
  - template: Security/Dependency-Scanning.gitlab-ci.yml

dependency_scanning:
  variables:
    DS_EXCLUDED_ANALYZERS: "bundler-audit"
```

### Container Scanning

```yaml
include:
  - template: Security/Container-Scanning.gitlab-ci.yml

container_scanning:
  variables:
    CS_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
```

## 📊 Security Reports

### Viewing Reports

```bash
# Security > Vulnerability Report
# View vulnerabilities
# Review findings
```

### Security Dashboard

```bash
# Group Security Dashboard
# Project Security Dashboard
# View security metrics
```

## 🔐 Security Policies

### Security Policies

```yaml
# .gitlab/security-policies/policy.yml
scan_execution_policy:
  - name: Enforce SAST
    enabled: true
    rules:
      - type: pipeline
        branches:
          - main
    actions:
      - scan: sast
```

## 🎯 Best Practices

1. **Enable Scanning**: Enable appropriate scans
2. **Review Findings**: Regularly review findings
3. **Fix Vulnerabilities**: Fix critical issues
4. **Policies**: Configure security policies
5. **Documentation**: Document security setup
6. **Monitoring**: Monitor security metrics
7. **Updates**: Keep scanners updated

## 🎓 Learning Resources

- Security Scanning: https://docs.gitlab.com/ee/user/application_security/
- SAST: https://docs.gitlab.com/ee/user/application_security/sast/
- Dependency Scanning: https://docs.gitlab.com/ee/user/application_security/dependency_scanning/

---

**Next**: Learn about [Multi-Project Pipelines](./MULTI-PROJECT-PIPELINES.md)

