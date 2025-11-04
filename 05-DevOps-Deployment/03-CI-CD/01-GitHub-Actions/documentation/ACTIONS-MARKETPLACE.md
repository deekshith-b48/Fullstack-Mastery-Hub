# GitHub Actions Marketplace

## 📚 Overview

GitHub Actions Marketplace provides thousands of pre-built actions that you can use in your workflows. These actions simplify common tasks and reduce the need to write custom code.

## 🎯 Popular Actions

### Checkout

```yaml
steps:
  - uses: actions/checkout@v3
    with:
      ref: main
      path: src
      fetch-depth: 1
```

### Setup Node.js

```yaml
steps:
  - uses: actions/setup-node@v3
    with:
      node-version: '18'
      cache: 'npm'
      registry-url: 'https://registry.npmjs.org'
```

### Setup Python

```yaml
steps:
  - uses: actions/setup-python@v4
    with:
      python-version: '3.11'
      cache: 'pip'
```

### Docker Actions

```yaml
steps:
  - uses: docker/login-action@v2
    with:
      username: ${{ secrets.DOCKER_USERNAME }}
      password: ${{ secrets.DOCKER_PASSWORD }}
  
  - uses: docker/build-push-action@v4
    with:
      context: .
      push: true
      tags: user/app:latest
```

### AWS Actions

```yaml
steps:
  - uses: aws-actions/configure-aws-credentials@v2
    with:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      aws-region: us-east-1
  
  - uses: aws-actions/amazon-ecr-login@v1
  
  - name: Deploy
    run: |
      aws s3 sync dist/ s3://my-bucket/
```

## 🔧 Using Actions

### Action Versions

```yaml
# Use specific version
- uses: actions/checkout@v3.0.0

# Use major version (latest)
- uses: actions/checkout@v3

# Use branch
- uses: actions/checkout@main
```

### Action Inputs

```yaml
steps:
  - uses: action/action@v1
    with:
      input1: value1
      input2: value2
```

### Action Outputs

```yaml
steps:
  - uses: action/action@v1
    id: step-id
  
  - name: Use output
    run: echo ${{ steps.step-id.outputs.output-name }}
```

## 📦 Creating Custom Actions

### JavaScript Action

```javascript
// action.yml
name: 'Hello World'
description: 'Greet someone'
inputs:
  who-to-greet:
    description: 'Who to greet'
    required: true
    default: 'World'
outputs:
  time:
    description: 'The time we greeted you'
runs:
  using: 'node16'
  main: 'index.js'

// index.js
const core = require('@actions/core');
const github = require('@actions/github');

const whoToGreet = core.getInput('who-to-greet');
console.log(`Hello ${whoToGreet}!`);

const time = new Date().toTimeString();
core.setOutput('time', time);
```

### Docker Action

```yaml
# action.yml
name: 'Docker Action'
runs:
  using: 'docker'
  image: 'Dockerfile'
  args:
    - ${{ inputs.args }}
```

### Composite Action

```yaml
# action.yml
name: 'Composite Action'
runs:
  using: 'composite'
  steps:
    - run: echo "Step 1"
      shell: bash
    - run: echo "Step 2"
      shell: bash
```

## 🎯 Best Practices

1. **Version Pinning**: Pin action versions
2. **Security**: Review action code
3. **Reusability**: Create reusable actions
4. **Documentation**: Document action usage
5. **Testing**: Test actions thoroughly
6. **Updates**: Keep actions updated
7. **Marketplace**: Publish useful actions

## 🎓 Learning Resources

- Actions Marketplace: https://github.com/marketplace?type=actions
- Creating Actions: https://docs.github.com/en/actions/creating-actions
- Action Examples: https://github.com/actions

---

**Next**: Learn about [Self-Hosted Runners](./SELF-HOSTED-RUNNERS.md)

