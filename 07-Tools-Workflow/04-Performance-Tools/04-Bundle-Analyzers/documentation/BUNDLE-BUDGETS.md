# Bundle Budgets

Bundle budgets set limits on bundle sizes. This guide covers budget configuration, enforcement, and best practices for maintaining bundle size.

## Bundle Budget Overview

Bundle budgets:
- **Set Limits**: Define size limits
- **Prevent Regression**: Prevent size regression
- **CI Integration**: CI/CD integration
- **Automated Checks**: Automated size checks
- **Performance**: Maintain performance

## Configuration

### Webpack Configuration

```javascript
module.exports = {
  performance: {
    maxAssetSize: 250000,
    maxEntrypointSize: 250000,
    hints: 'error'
  }
};
```

### Budget Configuration

```javascript
module.exports = {
  performance: {
    budgets: [
      {
        type: 'initial',
        maximumWarning: '500kb',
        maximumError: '1mb'
      },
      {
        type: 'anyComponentStyle',
        maximumWarning: '2kb',
        maximumError: '4kb'
      }
    ]
  }
};
```

## Types of Budgets

### Initial Budget

- **First Load**: First load bundle size
- **Critical**: Critical path size
- **Target**: < 200KB
- **Enforcement**: Fail on violation

### Chunk Budgets

- **Individual Chunks**: Per-chunk limits
- **Code Splitting**: Code split chunks
- **Lazy Loading**: Lazy loaded chunks
- **Target**: Reasonable chunk sizes

### Asset Budgets

- **Images**: Image size limits
- **Fonts**: Font size limits
- **Other Assets**: Other asset limits
- **Optimization**: Asset optimization

## Enforcement

### CI Integration

- **Build Failures**: Fail builds on violations
- **PR Comments**: Comment on PRs
- **Monitoring**: Continuous monitoring
- **Alerts**: Set up alerts
- **Reports**: Generate reports

### Tools

- **bundlesize**: Bundle size monitoring
- **Webpack**: Built-in budget support
- **Custom Scripts**: Custom validation scripts
- **CI Plugins**: CI/CD plugins

## Best Practices

1. **Set Realistic**: Set realistic budgets
2. **Monitor**: Regular monitoring
3. **Enforce**: Enforce in CI/CD
4. **Review**: Regular budget review
5. **Adjust**: Adjust as needed

## Next Steps

- Learn [Tree Shaking Analysis](./TREE-SHAKING-ANALYSIS.md)
- Explore [Code Splitting Analysis](./CODE-SPLITTING-ANALYSIS.md)
- Study [Dependency Analysis](./DEPENDENCY-ANALYSIS.md)

Bundle budgets maintain quality. Master budgets for consistent bundle sizes.
