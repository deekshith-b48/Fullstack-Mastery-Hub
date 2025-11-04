# GitHub Actions Best Practices

## 📚 Overview

Following GitHub Actions best practices ensures efficient, secure, and maintainable CI/CD pipelines. This guide covers comprehensive best practices for workflow development.

## 🎯 Workflow Organization

### File Structure

```bash
.github/
  workflows/
    ci.yml          # Continuous Integration
    cd.yml          # Continuous Deployment
    test.yml        # Testing workflows
    release.yml     # Release workflows
```

### Naming Conventions

```yaml
# Use descriptive names
name: CI/CD Pipeline

# Use consistent naming
name: Build and Test
```

## 🔒 Security

### Secrets Management

```yaml
# Never expose secrets in logs
steps:
  - name: Bad
    run: echo "${{ secrets.API_KEY }}"  # ❌
  
  - name: Good
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: deploy.sh  # ✅
```

### Action Versions

```yaml
# Pin action versions
- uses: actions/checkout@v3.0.0  # ✅

# Avoid using branches
- uses: actions/checkout@main  # ❌
```

### Permissions

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    steps:
      - run: echo "Build"
```

## ⚡ Performance

### Caching

```yaml
steps:
  - uses: actions/cache@v3
    with:
      path: node_modules
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

### Parallel Execution

```yaml
jobs:
  test:
    strategy:
      matrix:
        node-version: [14, 16, 18]
    steps:
      - run: npm test
```

### Early Exit

```yaml
steps:
  - name: Check
    run: |
      if [ condition ]; then
        echo "Skipping"
        exit 0
      fi
```

## 📝 Code Quality

### YAML Formatting

```yaml
# Use consistent indentation
# Use proper YAML syntax
# Add comments for clarity
```

### Error Handling

```yaml
steps:
  - name: Step with error handling
    run: |
      set -e
      set -o pipefail
      npm test || echo "Tests failed"
```

## 🔄 Maintenance

### Regular Updates

```yaml
# Keep actions updated
# Review workflow changes
# Test updates
```

### Documentation

```yaml
# Add comments
# Document complex workflows
# Maintain README
```

## 🎯 Best Practices Checklist

- [ ] Use versioned actions
- [ ] Implement proper caching
- [ ] Use secrets securely
- [ ] Organize workflows logically
- [ ] Document workflows
- [ ] Test workflows
- [ ] Monitor workflow performance
- [ ] Keep workflows updated
- [ ] Use conditional logic appropriately
- [ ] Optimize for performance

## 🎓 Learning Resources

- Best Practices: https://docs.github.com/en/actions/learn-github-actions/best-practices
- Security: https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions
- Performance: https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows

---

**GitHub Actions section complete!** Next: Learn about [Jenkins Fundamentals](./../02-Jenkins/documentation/JENKINS-FUNDAMENTALS.md)

