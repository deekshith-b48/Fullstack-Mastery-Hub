# CI/CD Integration

## 📚 Overview

CI/CD integration with Vercel and Netlify enables automatic deployments from Git repositories. Changes pushed to your repository trigger automatic builds and deployments.

## 🎯 CI/CD Fundamentals

### Continuous Integration (CI)

- **Automated Testing**: Run tests on every commit
- **Build Verification**: Verify builds succeed
- **Code Quality**: Check code quality
- **Security Scanning**: Scan for vulnerabilities

### Continuous Deployment (CD)

- **Automatic Deployment**: Deploy on successful builds
- **Preview Deployments**: Deploy previews for PRs
- **Production Deployments**: Deploy to production
- **Rollback**: Easy rollback capabilities

## 🚀 Vercel CI/CD

### GitHub Integration

```bash
# Connect GitHub repository
# Automatic deployments configured

# Preview deployments for PRs
# Production deployments on main branch
```

### Vercel Configuration

```json
{
  "git": {
    "deploymentEnabled": {
      "main": true
    },
    "ignoredBuildStep": "git diff HEAD^ HEAD --quiet ."
  },
  "github": {
    "enabled": true,
    "autoAlias": true
  }
}
```

### Build Configuration

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm install",
  "framework": "nextjs"
}
```

### Environment Variables

```bash
# Set in Vercel dashboard
# Automatic for all deployments
# Or use vercel CLI

vercel env add VARIABLE_NAME production
```

## 🔧 Netlify CI/CD

### GitHub Integration

```bash
# Connect GitHub repository
netlify init

# Automatic deployments configured
```

### Netlify Configuration

```toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"

[build.processing]
  skip_processing = false

[build.processing.css]
  bundle = true
  minify = true

[build.processing.js]
  bundle = true
  minify = true

[build.processing.html]
  pretty_urls = true
```

### Build Hooks

```bash
# Create build hook
netlify build:hooks:create --name "Production Build"

# Trigger build via webhook
curl -X POST -d {} https://api.netlify.com/build_hooks/{hook-id}
```

## 🔄 Deployment Workflows

### Preview Deployments

```bash
# Vercel: Automatic previews for PRs
# Netlify: Deploy previews for PRs

# Access preview URLs
# Test before merging
```

### Production Deployments

```bash
# Automatic on main branch
# Manual trigger available

# Deploy to production
vercel --prod
netlify deploy --prod
```

### Branch Deployments

```bash
# Deploy specific branch
# Configure in platform settings

# Branch-specific environment variables
```

## 📊 Deployment Status

### Status Checks

```yaml
# GitHub Actions integration
name: Vercel Deployment

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

## 🔐 Security

### Secrets Management

```bash
# Store secrets in platform
# Encrypted environment variables
# Not exposed in build logs
```

### Access Control

```bash
# Team access control
# Branch protection
# Deployment approvals
```

## 🎯 Best Practices

1. **Automated Testing**: Run tests in CI
2. **Preview Deployments**: Test before production
3. **Environment Variables**: Secure sensitive data
4. **Branch Strategy**: Use appropriate branching
5. **Monitoring**: Monitor deployment status
6. **Rollback Plan**: Have rollback procedure
7. **Documentation**: Document deployment process

## 🎓 Learning Resources

- Vercel Deployments: https://vercel.com/docs/deployments
- Netlify Deployments: https://docs.netlify.com/site-deploys/overview/
- CI/CD: https://www.atlassian.com/continuous-delivery/ci-cd

---

**Next**: Learn about [Domain Management](./DOMAIN-MANAGEMENT.md)

