# Lighthouse CI

Lighthouse CI automates Lighthouse audits in continuous integration. This guide covers Lighthouse CI setup, configuration, and best practices.

## Lighthouse CI Overview

Lighthouse CI provides:
- **Automated Audits**: Automated Lighthouse audits
- **CI Integration**: CI/CD integration
- **Performance Budgets**: Performance budgets
- **Trend Analysis**: Performance trend tracking
- **PR Comments**: Automated PR comments

## Installation

### Setup

```bash
npm install -g @lhci/cli
```

### Basic Configuration

Create `lighthouserc.js`:
```javascript
module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000'],
      numberOfRuns: 3,
    },
    assert: {
      assertions: {
        'categories:performance': ['error', {minScore: 0.9}],
        'categories:accessibility': ['error', {minScore: 0.9}],
      },
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

## CI Integration

### GitHub Actions

```yaml
name: Lighthouse CI
on: [push, pull_request]
jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
      - run: npm ci
      - run: npm run build
      - run: npm start &
      - run: npm install -g @lhci/cli
      - run: lhci autorun
```

### Other CI Platforms

- **CircleCI**: CircleCI integration
- **Jenkins**: Jenkins integration
- **GitLab CI**: GitLab CI integration
- **Azure DevOps**: Azure DevOps integration

## Performance Budgets

### Budget Configuration

```javascript
assert: {
  assertions: {
    'categories:performance': ['error', {minScore: 0.9}],
    'first-contentful-paint': ['error', {maxNumericValue: 2000}],
    'largest-contentful-paint': ['error', {maxNumericValue: 2500}],
  },
}
```

## Best Practices

1. **Set Budgets**: Define performance budgets
2. **Monitor Trends**: Track performance trends
3. **Fail Builds**: Fail builds on regressions
4. **Regular Audits**: Run audits on every PR
5. **Document**: Document configuration

## Next Steps

- Learn [Performance Budgets](./PERFORMANCE-BUDGETS.md)
- Explore [Core Web Vitals](./CORE-WEB-VITALS.md)
- Study [Lighthouse Optimization](./LIGHTHOUSE-OPTIMIZATION.md)

Lighthouse CI automates performance testing. Master Lighthouse CI for continuous performance monitoring.
