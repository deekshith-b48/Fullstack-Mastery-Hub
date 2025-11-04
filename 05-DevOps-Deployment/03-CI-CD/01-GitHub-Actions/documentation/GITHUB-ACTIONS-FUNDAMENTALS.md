# GitHub Actions Fundamentals

## 📚 Overview

GitHub Actions is a CI/CD platform that enables you to automate workflows directly in your GitHub repository. It provides powerful automation capabilities for building, testing, and deploying code.

## 🎯 What are GitHub Actions?

GitHub Actions allows you to automate software workflows directly in your repository. You can create custom workflows that build, test, and deploy your code automatically.

### Key Concepts

- **Workflow**: Automated process defined in YAML
- **Job**: Set of steps that run on the same runner
- **Step**: Individual task in a job
- **Action**: Reusable unit of code
- **Runner**: Server that runs workflows
- **Event**: Trigger that starts a workflow

### Benefits

- **Integrated**: Built into GitHub
- **Flexible**: Customize workflows
- **Reusable**: Share actions
- **Free**: Free for public repositories
- **Powerful**: Complex automation support

## 🚀 Getting Started

### Create Workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm install
    
    - name: Run tests
      run: npm test
    
    - name: Build
      run: npm run build
```

### Workflow Events

```yaml
on:
  # Push to branches
  push:
    branches: [ main, develop ]
  
  # Pull requests
  pull_request:
    branches: [ main ]
  
  # Schedule (cron)
  schedule:
    - cron: '0 0 * * *'
  
  # Manual trigger
  workflow_dispatch:
  
  # Release
  release:
    types: [ published ]
```

## 🔧 Jobs and Steps

### Multiple Jobs

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test
  
  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v3
      - run: npm run build
  
  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v3
      - run: npm run deploy
```

### Matrix Strategy

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [14, 16, 18]
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

## 🔐 Secrets and Environment

### Secrets

```yaml
steps:
  - name: Deploy
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: |
      echo "Deploying with API key"
      deploy.sh
```

### Environment Variables

```yaml
env:
  NODE_ENV: production
  API_URL: https://api.example.com

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo $NODE_ENV
```

## 📦 Artifacts

### Upload Artifacts

```yaml
steps:
  - name: Build
    run: npm run build
  
  - name: Upload artifacts
    uses: actions/upload-artifact@v3
    with:
      name: dist
      path: dist/
```

### Download Artifacts

```yaml
steps:
  - name: Download artifacts
    uses: actions/download-artifact@v3
    with:
      name: dist
      path: dist/
```

## 🔄 Conditional Execution

### Conditions

```yaml
steps:
  - name: Deploy
    if: github.ref == 'refs/heads/main'
    run: npm run deploy
  
  - name: Test
    if: github.event_name == 'pull_request'
    run: npm test
```

### Expressions

```yaml
steps:
  - name: Conditional step
    if: contains(github.event.head_commit.message, 'deploy')
    run: echo "Deployment triggered"
```

## 🎯 Best Practices

1. **Workflow Organization**: Organize workflows logically
2. **Caching**: Cache dependencies
3. **Secrets**: Use secrets for sensitive data
4. **Matrix Testing**: Test multiple versions
5. **Conditional Steps**: Use conditions appropriately
6. **Artifacts**: Share artifacts between jobs
7. **Documentation**: Document workflows

## 🎓 Learning Resources

- GitHub Actions: https://docs.github.com/en/actions
- Workflow Syntax: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions
- Actions: https://github.com/actions

---

**Next**: Learn about [Workflows Syntax](./WORKFLOWS-SYNTAX.md)

