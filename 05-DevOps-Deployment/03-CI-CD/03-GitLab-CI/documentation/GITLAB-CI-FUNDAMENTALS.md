# GitLab CI Fundamentals

## 📚 Overview

GitLab CI is a built-in continuous integration service in GitLab. It enables you to automate testing, building, and deploying code using pipelines defined in `.gitlab-ci.yml`.

## 🎯 What is GitLab CI?

GitLab CI is integrated into GitLab and provides CI/CD capabilities. Pipelines are defined in YAML files and executed by GitLab runners.

### Key Concepts

- **Pipeline**: Collection of jobs
- **Job**: Individual task in a pipeline
- **Stage**: Group of jobs that run in parallel
- **Runner**: Agent that executes jobs
- **.gitlab-ci.yml**: Pipeline configuration file

### Benefits

- **Integrated**: Built into GitLab
- **YAML Configuration**: Simple YAML syntax
- **Flexible**: Highly customizable
- **Free**: Free for GitLab projects
- **Powerful**: Complex pipeline support

## 🚀 Getting Started

### Create .gitlab-ci.yml

```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - deploy

build:
  stage: build
  script:
    - echo "Building..."
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/

test:
  stage: test
  script:
    - echo "Testing..."
    - npm test

deploy:
  stage: deploy
  script:
    - echo "Deploying..."
    - npm run deploy
  only:
    - main
```

### Pipeline Execution

```bash
# Pipeline runs automatically on:
# - Push to repository
# - Merge requests
# - Manual triggers
# - Scheduled pipelines
```

## 🔧 Basic Configuration

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
job-name:
  stage: build
  script:
    - echo "Running job"
    - npm install
```

### Image

```yaml
job-name:
  image: node:18
  script:
    - npm install
```

## 🔄 Variables

### Predefined Variables

```yaml
job:
  script:
    - echo $CI_COMMIT_SHA
    - echo $CI_COMMIT_REF_NAME
    - echo $CI_PROJECT_NAME
```

### Custom Variables

```yaml
variables:
  NODE_ENV: production
  API_URL: https://api.example.com

job:
  script:
    - echo $NODE_ENV
```

### Secret Variables

```bash
# Settings > CI/CD > Variables
# Add variable
# Mark as protected/masked
```

## 📊 Artifacts

### Upload Artifacts

```yaml
build:
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
```

### Download Artifacts

```yaml
deploy:
  script:
    - ls dist/
  dependencies:
    - build
```

## 🎯 Best Practices

1. **YAML Structure**: Organize stages logically
2. **Caching**: Cache dependencies
3. **Variables**: Use variables appropriately
4. **Artifacts**: Share artifacts between jobs
5. **Documentation**: Document pipeline logic
6. **Testing**: Test pipeline changes
7. **Security**: Secure sensitive data

## 🎓 Learning Resources

- GitLab CI: https://docs.gitlab.com/ee/ci/
- Getting Started: https://docs.gitlab.com/ee/ci/quick_start/
- GitLab: https://gitlab.com

---

**Next**: Learn about [GitLab YML Syntax](./GITLAB-YML-SYNTAX.md)

