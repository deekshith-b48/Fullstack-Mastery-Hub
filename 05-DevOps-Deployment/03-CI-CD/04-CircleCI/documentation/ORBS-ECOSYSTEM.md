# CircleCI Orbs Ecosystem

## 📚 Overview

CircleCI Orbs are reusable packages of configuration that simplify CI/CD setup. They provide pre-configured jobs, commands, and executors for common tasks.

## 🎯 What are Orbs?

Orbs are shareable packages of CircleCI configuration that can be imported and used across projects. They promote code reuse and standardization.

### Benefits

- **Reusability**: Reuse common configurations
- **Standardization**: Standardize workflows
- **Simplicity**: Simplify complex setups
- **Community**: Access to community orbs

## 🚀 Using Orbs

### Import Orbs

```yaml
version: 2.1

orbs:
  node: circleci/node@5.0.0
  aws-cli: circleci/aws-cli@2.0.0
  docker: circleci/docker@2.0.0
```

### Using Orb Commands

```yaml
jobs:
  build:
    docker:
      - image: node:18
    steps:
      - checkout
      - node/install-packages
      - node/run:
          command: npm run build
```

### Using Orb Jobs

```yaml
workflows:
  version: 2
  build:
    jobs:
      - node/test
```

## 📦 Popular Orbs

### Node.js Orb

```yaml
orbs:
  node: circleci/node@5.0.0

jobs:
  build:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - node/run:
          command: npm run build
```

### AWS Orb

```yaml
orbs:
  aws-cli: circleci/aws-cli@2.0.0

jobs:
  deploy:
    docker:
      - image: aws-cli/default
    steps:
      - checkout
      - aws-cli/setup
      - run:
          command: aws s3 sync dist/ s3://my-bucket/
```

### Docker Orb

```yaml
orbs:
  docker: circleci/docker@2.0.0

jobs:
  build:
    docker:
      - image: docker:20.10
    steps:
      - checkout
      - docker/build:
          image: my-image
          tag: latest
```

## 🔧 Creating Orbs

### Orb Structure

```yaml
# orb.yml
version: 2.1

description: My custom orb

commands:
  my-command:
    description: "My command"
    steps:
      - run:
          name: Run command
          command: echo "Hello"

jobs:
  my-job:
    docker:
      - image: node:18
    steps:
      - checkout
      - my-command
```

## 🎯 Best Practices

1. **Use Orbs**: Leverage existing orbs
2. **Custom Orbs**: Create custom orbs for reuse
3. **Versioning**: Pin orb versions
4. **Documentation**: Document orb usage
5. **Testing**: Test orb updates
6. **Community**: Share useful orbs
7. **Maintenance**: Keep orbs updated

## 🎓 Learning Resources

- Orbs: https://circleci.com/docs/orb-intro/
- Orb Registry: https://circleci.com/developer/orbs
- Creating Orbs: https://circleci.com/docs/orb-author-intro/

---

**Next**: Learn about [Workflows Orchestration](./WORKFLOWS-ORCHESTRATION.md)

