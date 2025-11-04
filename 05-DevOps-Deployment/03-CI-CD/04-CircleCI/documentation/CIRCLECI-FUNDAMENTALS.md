# CircleCI Fundamentals

## 📚 Overview

CircleCI is a continuous integration and delivery platform that automates software development workflows. It provides powerful CI/CD capabilities with flexible configuration options.

## 🎯 What is CircleCI?

CircleCI automates building, testing, and deploying code. It integrates with GitHub, GitLab, and Bitbucket to run pipelines automatically on code changes.

### Key Concepts

- **Pipeline**: Automated workflow
- **Job**: Collection of steps
- **Workflow**: Orchestration of jobs
- **Orb**: Reusable configuration package
- **Executor**: Execution environment

### Benefits

- **Flexible**: Multiple configuration options
- **Orbs**: Reusable components
- **Powerful**: Complex workflow support
- **Scalable**: Handles large projects
- **Free**: Free tier available

## 🚀 Getting Started

### Create .circleci/config.yml

```yaml
# .circleci/config.yml
version: 2.1

jobs:
  build:
    docker:
      - image: node:18
    steps:
      - checkout
      - run:
          name: Install dependencies
          command: npm install
      - run:
          name: Build
          command: npm run build

workflows:
  version: 2
  build-and-test:
    jobs:
      - build
```

### Connect Repository

```bash
# Add project to CircleCI
# CircleCI dashboard > Add Project
# Select repository
# Follow setup instructions
```

## 🔧 Basic Configuration

### Jobs

```yaml
jobs:
  build:
    docker:
      - image: node:18
    steps:
      - checkout
      - run: npm install
      - run: npm run build
```

### Workflows

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

## 🔄 Orbs

### Using Orbs

```yaml
version: 2.1

orbs:
  node: circleci/node@5.0.0

jobs:
  build:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run: npm run build
```

## 🎯 Best Practices

1. **Configuration**: Organize config.yml logically
2. **Orbs**: Use orbs for common tasks
3. **Caching**: Implement caching strategies
4. **Parallelization**: Run jobs in parallel
5. **Documentation**: Document workflows
6. **Testing**: Test configuration changes
7. **Security**: Secure sensitive data

## 🎓 Learning Resources

- CircleCI Documentation: https://circleci.com/docs/
- Getting Started: https://circleci.com/docs/getting-started/
- CircleCI: https://circleci.com

---

**Next**: Learn about [Config YML Syntax](./CONFIG-YML-SYNTAX.md)

