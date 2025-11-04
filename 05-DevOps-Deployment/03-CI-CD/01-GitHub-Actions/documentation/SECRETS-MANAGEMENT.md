# GitHub Actions Secrets Management

## 📚 Overview

GitHub Actions secrets allow you to store sensitive information securely. Secrets are encrypted and can be used in workflows without exposing them in logs.

## 🎯 Secrets Fundamentals

### What are Secrets?

Secrets are encrypted environment variables that you can use in GitHub Actions workflows. They are stored securely and masked in logs.

### Types of Secrets

- **Repository Secrets**: Available to all workflows in a repository
- **Organization Secrets**: Available to all repositories in an organization
- **Environment Secrets**: Available to specific environments
- **Dependabot Secrets**: For Dependabot workflows

## 🔐 Creating Secrets

### Repository Secrets

```bash
# Create secret via GitHub CLI
gh secret set API_KEY --body "secret-value"

# Or via GitHub web interface
# Settings > Secrets and variables > Actions > New repository secret
```

### Organization Secrets

```bash
# Create organization secret
gh secret set API_KEY --org my-org --body "secret-value"

# Or via GitHub web interface
# Organization settings > Secrets > New organization secret
```

### Environment Secrets

```bash
# Create environment
# Settings > Environments > New environment

# Add secret to environment
# Environment > Secrets > Add secret
```

## 💻 Using Secrets

### In Workflows

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Use secret
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: |
          echo "Deploying with API key"
          deploy.sh
```

### Environment-Specific

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: deploy.sh
```

### Multiple Secrets

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_REGION: us-east-1
```

## 🔒 Security Best Practices

### Secret Access

```yaml
# Limit secret access
# Use environment-specific secrets
# Rotate secrets regularly
# Use least privilege
```

### Secret Masking

```yaml
steps:
  - name: Secret is masked
    run: echo "Secret: ${{ secrets.API_KEY }}"
    # Output: Secret: ***

  - name: Don't expose secrets
    run: |
      echo "Never do this:"
      echo "${{ secrets.API_KEY }}"  # ❌ Bad
```

### Secret Rotation

```bash
# Rotate secrets regularly
# Update secrets in GitHub
# Update workflows if needed
# Test after rotation
```

## 📊 Managing Secrets

### List Secrets

```bash
# List repository secrets
gh secret list

# List organization secrets
gh secret list --org my-org
```

### Delete Secrets

```bash
# Delete secret
gh secret delete API_KEY

# Or via GitHub web interface
```

### Update Secrets

```bash
# Update secret
gh secret set API_KEY --body "new-value"
```

## 🔄 Secret Scopes

### Repository Scope

```yaml
# Available to all workflows in repository
env:
  SECRET: ${{ secrets.REPO_SECRET }}
```

### Organization Scope

```yaml
# Available to all repositories in organization
env:
  SECRET: ${{ secrets.ORG_SECRET }}
```

### Environment Scope

```yaml
# Available to specific environment
jobs:
  deploy:
    environment: production
    steps:
      - run: echo ${{ secrets.ENV_SECRET }}
```

## 🎯 Best Practices

1. **Least Privilege**: Grant minimum access
2. **Rotation**: Rotate secrets regularly
3. **Masking**: Secrets are automatically masked
4. **Documentation**: Document secret usage
5. **Audit**: Audit secret access
6. **Testing**: Test secret updates
7. **Backup**: Backup secret configurations

## 🎓 Learning Resources

- Secrets: https://docs.github.com/en/actions/security-guides/encrypted-secrets
- Managing Secrets: https://docs.github.com/en/actions/security-guides/encrypted-secrets#using-encrypted-secrets-in-a-workflow
- Security: https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions

---

**Next**: Learn about [Matrix Strategies](./MATRIX-STRATEGIES.md)

