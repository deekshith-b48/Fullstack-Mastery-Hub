# Performance Budgets

Performance budgets set limits on web performance metrics. This guide covers budget creation, enforcement, and best practices for maintaining performance.

## Performance Budget Overview

Performance budgets:
- **Set Limits**: Define performance limits
- **Prevent Regression**: Prevent performance regression
- **Guide Optimization**: Guide optimization efforts
- **Measure Success**: Measure performance success

## Budget Types

### Size Budgets

- **JavaScript Size**: JavaScript bundle size limits
- **CSS Size**: CSS bundle size limits
- **Image Size**: Image size limits
- **Total Size**: Total page size limits

### Time Budgets

- **Load Time**: Page load time limits
- **First Contentful Paint**: FCP limits
- **Time to Interactive**: TTI limits
- **Largest Contentful Paint**: LCP limits

### Resource Budgets

- **Number of Requests**: Request count limits
- **Third-Party Requests**: Third-party request limits
- **Image Requests**: Image request limits
- **Font Requests**: Font request limits

## Creating Budgets

### Budget Configuration

```javascript
budgets: [
  {
    path: '/',
    timings: [
      {
        metric: 'first-contentful-paint',
        budget: 2000,
      },
      {
        metric: 'largest-contentful-paint',
        budget: 2500,
      },
    ],
    resourceSizes: [
      {
        resourceType: 'script',
        budget: 500,
      },
      {
        resourceType: 'image',
        budget: 1000,
      },
    ],
  },
]
```

## Enforcing Budgets

### CI Integration

- **Lighthouse CI**: Use Lighthouse CI
- **Build Failures**: Fail builds on budget violations
- **PR Comments**: Comment on PRs
- **Monitoring**: Continuous monitoring

### Tools

- **bundlesize**: Bundle size monitoring
- **Lighthouse CI**: Lighthouse CI budgets
- **Webpack Bundle Analyzer**: Bundle analysis
- **Performance Budget Plugin**: Budget plugin

## Best Practices

1. **Realistic Budgets**: Set realistic budgets
2. **Monitor**: Regular monitoring
3. **Enforce**: Enforce in CI/CD
4. **Review**: Regular budget review
5. **Adjust**: Adjust as needed

## Next Steps

- Learn [Core Web Vitals](./CORE-WEB-VITALS.md)
- Explore [Lighthouse Scoring](./LIGHTHOUSE-SCORING.md)
- Study [Lighthouse Optimization](./LIGHTHOUSE-OPTIMIZATION.md)

Performance budgets maintain quality. Master budgets for consistent performance.
