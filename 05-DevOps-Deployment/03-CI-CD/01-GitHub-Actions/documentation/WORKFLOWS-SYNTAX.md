# GitHub Actions Workflows Syntax

## 📚 Overview

GitHub Actions workflows are defined in YAML files. Understanding the workflow syntax is essential for creating effective CI/CD pipelines.

## 🎯 Workflow Structure

### Basic Structure

```yaml
name: Workflow Name

on:
  # Events

jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - name: Step name
        uses: action/action@v1
      - name: Run command
        run: echo "Hello"
```

### Name

```yaml
name: CI/CD Pipeline

# Optional: Display name for workflow
```

## 🔔 Events

### Push Event

```yaml
on:
  push:
    branches:
      - main
      - develop
    tags:
      - 'v*'
    paths:
      - 'src/**'
      - '*.js'
```

### Pull Request Event

```yaml
on:
  pull_request:
    branches:
      - main
    types:
      - opened
      - synchronize
      - reopened
```

### Schedule Event

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
    - cron: '0 */6 * * *'  # Every 6 hours
```

### Workflow Dispatch

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production
```

### Multiple Events

```yaml
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:
```

## 💼 Jobs

### Job Configuration

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    name: Build Application
    needs: []
    if: github.ref == 'refs/heads/main'
    strategy:
      matrix:
        node-version: [14, 16, 18]
    steps:
      - run: echo "Building"
```

### Job Dependencies

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - run: npm test
  
  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - run: npm run build
  
  deploy:
    runs-on: ubuntu-latest
    needs: [test, build]
    steps:
      - run: npm run deploy
```

### Matrix Strategy

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [14, 16, 18]
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
```

## 📝 Steps

### Step Types

```yaml
steps:
  # Using action
  - uses: actions/checkout@v3
  
  # Run command
  - name: Install dependencies
    run: npm install
  
  # Run with shell
  - name: Run script
    shell: bash
    run: |
      echo "Multi-line"
      echo "Commands"
  
  # Set environment variable
  - name: Set env
    run: echo "KEY=value" >> $GITHUB_ENV
  
  # Set output
  - name: Set output
    id: step-id
    run: echo "value=output" >> $GITHUB_OUTPUT
```

### Step Conditions

```yaml
steps:
  - name: Conditional step
    if: github.ref == 'refs/heads/main'
    run: echo "Main branch"
  
  - name: Always run
    if: always()
    run: echo "Always"
  
  - name: Success only
    if: success()
    run: echo "Success"
```

## 🔄 Expressions

### Context Expressions

```yaml
steps:
  - name: Use context
    run: |
      echo ${{ github.ref }}
      echo ${{ github.sha }}
      echo ${{ github.actor }}
      echo ${{ github.repository }}
      echo ${{ github.event_name }}
```

### Conditional Expressions

```yaml
steps:
  - name: Conditional
    if: contains(github.event.head_commit.message, 'deploy')
    run: echo "Deploy"
  
  - name: Compare
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    run: echo "Main push"
```

## 🔐 Secrets and Variables

### Secrets

```yaml
steps:
  - name: Use secret
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: echo "Deploying"
```

### Variables

```yaml
env:
  NODE_ENV: production

jobs:
  build:
    env:
      BUILD_NUMBER: ${{ github.run_number }}
    steps:
      - run: echo $NODE_ENV
```

## 📦 Artifacts

### Upload

```yaml
steps:
  - name: Upload
    uses: actions/upload-artifact@v3
    with:
      name: dist
      path: dist/
      retention-days: 7
```

### Download

```yaml
steps:
  - name: Download
    uses: actions/download-artifact@v3
    with:
      name: dist
      path: dist/
```

## 🎯 Best Practices

1. **YAML Syntax**: Follow YAML best practices
2. **Indentation**: Use consistent indentation
3. **Comments**: Add comments for clarity
4. **Reusability**: Create reusable workflows
5. **Error Handling**: Handle errors appropriately
6. **Optimization**: Optimize workflow performance
7. **Documentation**: Document complex workflows

## 🎓 Learning Resources

- Workflow Syntax: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions
- Expressions: https://docs.github.com/en/actions/learn-github-actions/expressions
- Contexts: https://docs.github.com/en/actions/learn-github-actions/contexts

---

**Next**: Learn about [Actions Marketplace](./ACTIONS-MARKETPLACE.md)

