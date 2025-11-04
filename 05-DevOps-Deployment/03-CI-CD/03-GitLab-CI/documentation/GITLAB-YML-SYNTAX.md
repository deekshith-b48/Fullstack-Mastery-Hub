# GitLab CI YML Syntax

## 📚 Overview

GitLab CI pipelines are defined using YAML syntax in `.gitlab-ci.yml`. Understanding the syntax is essential for creating effective CI/CD pipelines.

## 🎯 Basic Structure

### Pipeline Structure

```yaml
stages:
  - build
  - test

job-name:
  stage: build
  script:
    - echo "Hello"
```

### Stages

```yaml
stages:
  - build
  - test
  - deploy
  - cleanup
```

### Jobs

```yaml
build:
  stage: build
  script:
    - npm install
    - npm run build
```

## 🔧 Job Configuration

### Image

```yaml
job:
  image: node:18
  script:
    - npm install
```

### Services

```yaml
job:
  image: node:18
  services:
    - postgres:15
    - redis:7
  script:
    - npm test
```

### Variables

```yaml
job:
  variables:
    NODE_ENV: production
  script:
    - echo $NODE_ENV
```

### Before/After Scripts

```yaml
job:
  before_script:
    - echo "Before"
    - npm install
  script:
    - npm test
  after_script:
    - echo "After"
```

## 🔄 Conditional Execution

### Only/Except

```yaml
deploy:
  script:
    - deploy.sh
  only:
    - main
    - tags
  except:
    - develop
```

### Rules

```yaml
deploy:
  script:
    - deploy.sh
  rules:
    - if: $CI_COMMIT_BRANCH == "main"
      when: on_success
    - if: $CI_COMMIT_BRANCH == "develop"
      when: manual
    - when: on_failure
```

## 📊 Artifacts and Cache

### Artifacts

```yaml
build:
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
    when: on_success
```

### Cache

```yaml
build:
  script:
    - npm install
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - node_modules/
```

## 🎯 Best Practices

1. **Structure**: Organize YAML logically
2. **Indentation**: Use consistent indentation
3. **Comments**: Add comments for clarity
4. **Reusability**: Use templates
5. **Documentation**: Document complex logic
6. **Testing**: Test YAML syntax
7. **Maintenance**: Keep YAML updated

## 🎓 Learning Resources

- YAML Syntax: https://docs.gitlab.com/ee/ci/yaml/
- Configuration: https://docs.gitlab.com/ee/ci/yaml/gitlab_ci_yaml.html
- Examples: https://docs.gitlab.com/ee/ci/examples/

---

**Next**: Learn about [Auto DevOps](./AUTO-DEVOPS.md)

