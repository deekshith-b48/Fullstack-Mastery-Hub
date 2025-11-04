# CircleCI Config YML Syntax

## 📚 Overview

CircleCI pipelines are configured using YAML syntax in `.circleci/config.yml`. Understanding the syntax is essential for creating effective CI/CD pipelines.

## 🎯 Basic Structure

### Configuration Structure

```yaml
version: 2.1

jobs:
  job-name:
    docker:
      - image: node:18
    steps:
      - checkout
      - run: echo "Hello"

workflows:
  version: 2
  workflow-name:
    jobs:
      - job-name
```

### Version

```yaml
version: 2.1  # Use 2.1 for latest features
```

## 🔧 Jobs

### Docker Executor

```yaml
jobs:
  build:
    docker:
      - image: node:18
    steps:
      - checkout
      - run: npm install
```

### Machine Executor

```yaml
jobs:
  build:
    machine:
      image: ubuntu-2004:202010-01
    steps:
      - checkout
      - run: npm install
```

### Steps

```yaml
steps:
  - checkout
  - run:
      name: Install
      command: npm install
  - run:
      name: Test
      command: npm test
      when: on_success
```

## 🔄 Workflows

### Basic Workflow

```yaml
workflows:
  version: 2
  build-test:
    jobs:
      - build
      - test
```

### Job Dependencies

```yaml
workflows:
  version: 2
  build-test-deploy:
    jobs:
      - build
      - test:
          requires:
            - build
      - deploy:
          requires:
            - test
```

### Conditional Execution

```yaml
workflows:
  version: 2
  deploy:
    jobs:
      - deploy:
          filters:
            branches:
              only: main
```

## 📊 Caching

### Cache Dependencies

```yaml
steps:
  - restore_cache:
      keys:
        - v1-dependencies-{{ checksum "package-lock.json" }}
  
  - run: npm install
  
  - save_cache:
      paths:
        - node_modules
      key: v1-dependencies-{{ checksum "package-lock.json" }}
```

## 🎯 Best Practices

1. **Structure**: Organize YAML logically
2. **Versioning**: Use version 2.1
3. **Caching**: Implement caching
4. **Documentation**: Document workflows
5. **Testing**: Test configuration
6. **Optimization**: Optimize workflows
7. **Maintenance**: Keep config updated

## 🎓 Learning Resources

- Config Syntax: https://circleci.com/docs/config-intro/
- Configuration Reference: https://circleci.com/docs/configuration-reference/
- Examples: https://circleci.com/docs/example-configs/

---

**Next**: Learn about [Orbs Ecosystem](./ORBS-ECOSYSTEM.md)

