# GitHub Actions Advanced Workflows

## 📚 Overview

Advanced GitHub Actions workflows include reusable workflows, workflow calls, conditional logic, and complex automation patterns. These enable powerful CI/CD pipelines.

## 🎯 Reusable Workflows

### Creating Reusable Workflow

```yaml
# .github/workflows/reusable-build.yml
name: Reusable Build

on:
  workflow_call:
    inputs:
      node-version:
        required: true
        type: string
      environment:
        required: false
        type: string
        default: 'production'
    secrets:
      API_KEY:
        required: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ inputs.node-version }}
      - name: Build
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: npm run build
```

### Calling Reusable Workflow

```yaml
# .github/workflows/main.yml
name: Main Workflow

on:
  push:
    branches: [ main ]

jobs:
  call-workflow:
    uses: ./.github/workflows/reusable-build.yml
    with:
      node-version: '18'
      environment: 'production'
    secrets:
      API_KEY: ${{ secrets.API_KEY }}
```

## 🔄 Workflow Dependencies

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

### Conditional Execution

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - run: deploy.sh
```

## 🔐 Environment Protection

### Environment Secrets

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://example.com
    steps:
      - name: Deploy
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: deploy.sh
```

### Approval Gates

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
    steps:
      - run: deploy.sh
```

## 📊 Workflow Patterns

### Matrix with Dynamic Jobs

```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}
    steps:
      - id: set-matrix
        run: |
          echo '::set-output name=matrix::{"include":[{"os":"ubuntu-latest"},{"os":"windows-latest"}]}'
  
  test:
    needs: setup
    runs-on: ${{ matrix.os }}
    strategy:
      matrix: ${{ fromJson(needs.setup.outputs.matrix) }}
    steps:
      - run: echo "Testing on ${{ matrix.os }}"
```

### Parallel Jobs

```yaml
jobs:
  test-unit:
    runs-on: ubuntu-latest
    steps:
      - run: npm test
  
  test-integration:
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:integration
  
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: npm run lint
  
  deploy:
    runs-on: ubuntu-latest
    needs: [test-unit, test-integration, lint]
    steps:
      - run: deploy.sh
```

## 🎯 Best Practices

1. **Reusability**: Create reusable workflows
2. **Modularity**: Break down complex workflows
3. **Documentation**: Document workflow patterns
4. **Testing**: Test workflows thoroughly
5. **Optimization**: Optimize workflow performance
6. **Maintenance**: Keep workflows updated
7. **Security**: Follow security best practices

## 🎓 Learning Resources

- Reusable Workflows: https://docs.github.com/en/actions/using-workflows/reusing-workflows
- Workflow Syntax: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions
- Advanced Patterns: https://docs.github.com/en/actions/using-workflows

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

