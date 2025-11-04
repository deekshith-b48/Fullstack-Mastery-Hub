# GitLab CI Multi-Project Pipelines

## 📚 Overview

Multi-project pipelines allow you to trigger pipelines in other projects, enabling complex workflows across multiple repositories.

## 🎯 Multi-Project Pipelines

### Triggering Pipelines

```yaml
trigger:
  project: group/project
  branch: main
  strategy: depend
```

### With Variables

```yaml
trigger:
  project: group/project
  branch: main
  variables:
    ENVIRONMENT: production
    VERSION: $CI_COMMIT_TAG
```

### Multiple Projects

```yaml
stages:
  - build
  - trigger

trigger-downstream:
  stage: trigger
  trigger:
    include:
      - project: group/project1
        branch: main
      - project: group/project2
        branch: develop
```

## 🔄 Pipeline Dependencies

### Dependent Pipelines

```yaml
trigger:
  project: group/project
  branch: main
  strategy: depend
```

### Independent Pipelines

```yaml
trigger:
  project: group/project
  branch: main
  strategy: depend
```

## 📊 Pipeline Visualization

### View Dependencies

```bash
# Pipeline graph
# View upstream/downstream pipelines
# Monitor pipeline status
```

## 🎯 Best Practices

1. **Organization**: Organize pipeline dependencies
2. **Documentation**: Document pipeline relationships
3. **Monitoring**: Monitor multi-project pipelines
4. **Testing**: Test pipeline triggers
5. **Optimization**: Optimize pipeline flow
6. **Security**: Secure pipeline triggers
7. **Maintenance**: Maintain pipeline connections

## 🎓 Learning Resources

- Multi-Project Pipelines: https://docs.gitlab.com/ee/ci/pipelines/multi_project_pipelines.html
- Pipeline Triggers: https://docs.gitlab.com/ee/ci/triggers/
- Pipeline Dependencies: https://docs.gitlab.com/ee/ci/pipelines/downstream_pipelines.html

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

