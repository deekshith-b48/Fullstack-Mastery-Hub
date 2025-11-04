# GitLab CI Artifacts Management

## 📚 Overview

Artifacts in GitLab CI allow you to save files from jobs for use in subsequent jobs or download them after pipeline completion.

## 🎯 Artifacts Fundamentals

### What are Artifacts?

Artifacts are files created during job execution that are saved and can be used by other jobs or downloaded.

### Artifact Types

- **Build Artifacts**: Compiled code, binaries
- **Test Reports**: Test results, coverage
- **Deployment Artifacts**: Deployment packages

## 🚀 Creating Artifacts

### Basic Artifacts

```yaml
build:
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
```

### Artifact Options

```yaml
build:
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    exclude:
      - dist/temp/
    expire_in: 1 week
    when: on_success
    name: "build-$CI_COMMIT_REF_NAME"
```

### Test Reports

```yaml
test:
  script:
    - npm test -- --reporter junit --output-file junit.xml
  artifacts:
    reports:
      junit: junit.xml
    expire_in: 1 week
```

## 📊 Using Artifacts

### Dependencies

```yaml
deploy:
  script:
    - ls dist/
  dependencies:
    - build
```

### Artifact Download

```bash
# Download artifacts from GitLab UI
# Job > Artifacts > Download

# Or via API
curl --header "PRIVATE-TOKEN: <token>" \
  "https://gitlab.com/api/v4/projects/<project-id>/jobs/<job-id>/artifacts" \
  --output artifacts.zip
```

## 🔄 Artifact Retention

### Expiration

```yaml
artifacts:
  expire_in: 1 week
  # or
  expire_in: 1 day
  # or
  expire_in: 1 hour
```

### Keep Artifacts

```yaml
job:
  artifacts:
    paths:
      - dist/
    expire_in: never
```

## 🎯 Best Practices

1. **Selective**: Only save necessary artifacts
2. **Expiration**: Set appropriate expiration
3. **Naming**: Use descriptive names
4. **Dependencies**: Use dependencies correctly
5. **Storage**: Monitor artifact storage
6. **Documentation**: Document artifact usage
7. **Cleanup**: Clean up old artifacts

## 🎓 Learning Resources

- Artifacts: https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html
- Artifact Management: https://docs.gitlab.com/ee/ci/yaml/#artifacts
- Best Practices: https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html#best-practices

---

**Next**: Learn about [Security Scanning](./SECURITY-SCANNING.md)

