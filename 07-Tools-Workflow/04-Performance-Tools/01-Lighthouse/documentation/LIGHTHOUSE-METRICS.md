# Lighthouse Metrics

Lighthouse metrics measure web performance. This guide covers Core Web Vitals, performance metrics, and optimization strategies.

## Core Web Vitals

### Largest Contentful Paint (LCP)

- **Definition**: Time to render largest content
- **Target**: < 2.5 seconds
- **Good**: < 2.5s
- **Needs Improvement**: 2.5s - 4.0s
- **Poor**: > 4.0s

### First Input Delay (FID)

- **Definition**: Time to first interaction
- **Target**: < 100 milliseconds
- **Good**: < 100ms
- **Needs Improvement**: 100ms - 300ms
- **Poor**: > 300ms

### Cumulative Layout Shift (CLS)

- **Definition**: Visual stability measure
- **Target**: < 0.1
- **Good**: < 0.1
- **Needs Improvement**: 0.1 - 0.25
- **Poor**: > 0.25

## Performance Metrics

### First Contentful Paint (FCP)

- **Measures**: First content rendering
- **Target**: < 1.8 seconds
- **Optimization**: Optimize critical rendering path

### Total Blocking Time (TBT)

- **Measures**: Main thread blocking time
- **Target**: < 200 milliseconds
- **Optimization**: Reduce JavaScript execution time

### Speed Index

- **Measures**: Page load speed
- **Target**: < 3.4 seconds
- **Optimization**: Optimize above-the-fold content

## Optimizing Metrics

### LCP Optimization

1. **Optimize Images**: Optimize largest images
2. **Preload**: Preload critical resources
3. **Server Response**: Improve server response time
4. **Render-Blocking**: Remove render-blocking resources

### FID Optimization

1. **Reduce JavaScript**: Minimize JavaScript
2. **Code Splitting**: Split code
3. **Defer Scripts**: Defer non-critical scripts
4. **Web Workers**: Use web workers

### CLS Optimization

1. **Image Dimensions**: Set image dimensions
2. **Font Loading**: Optimize font loading
3. **Ads**: Reserve space for ads
4. **Animations**: Avoid unexpected layout shifts

## Best Practices

1. **Monitor Metrics**: Regularly monitor metrics
2. **Set Targets**: Set performance targets
3. **Optimize Continuously**: Continuous optimization
4. **Test Regularly**: Regular testing
5. **Document**: Document improvements

## Next Steps

- Learn [Core Web Vitals](./CORE-WEB-VITALS.md)
- Explore [Lighthouse Audits](./LIGHTHOUSE-AUDITS.md)
- Study [Performance Budgets](./PERFORMANCE-BUDGETS.md)

Understanding metrics improves performance. Master Lighthouse metrics for better results.
