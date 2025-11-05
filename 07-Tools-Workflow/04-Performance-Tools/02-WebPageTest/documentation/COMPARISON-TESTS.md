# Comparison Tests

Comparison tests compare performance between different versions or configurations. This guide covers comparison testing, analysis, and best practices.

## Comparison Overview

Comparison tests:
- **Version Comparison**: Compare different versions
- **Configuration Comparison**: Compare configurations
- **Before/After**: Compare before/after changes
- **A/B Testing**: A/B performance testing
- **Regression Detection**: Detect performance regressions

## Running Comparisons

### Web Interface

1. **Run Test 1**: Run first test
2. **Run Test 2**: Run second test
3. **Compare**: Use comparison view
4. **Analyze**: Analyze differences
5. **Document**: Document findings

### API Comparison

```javascript
const test1 = await wpt.runTest('https://example.com/v1');
const test2 = await wpt.runTest('https://example.com/v2');

wpt.compareTest(test1.testId, test2.testId, (err, data) => {
  console.log(data);
});
```

## Comparison Metrics

### Performance Differences

- **Load Time**: Load time difference
- **Speed Index**: Speed Index difference
- **First Byte**: TTFB difference
- **Start Render**: Start render difference
- **Total Requests**: Request count difference

### Visual Comparison

- **Filmstrip**: Side-by-side filmstrip
- **Waterfall**: Side-by-side waterfall
- **Screenshots**: Side-by-side screenshots
- **Video**: Side-by-side video

## Use Cases

### Version Comparison

- **Before Deployment**: Test before deployment
- **After Deployment**: Test after deployment
- **Feature Comparison**: Compare feature versions
- **Performance Impact**: Measure performance impact

### Configuration Comparison

- **CDN Comparison**: Compare CDN configurations
- **Server Comparison**: Compare server configurations
- **Optimization Comparison**: Compare optimizations
- **Settings Comparison**: Compare settings

## Analysis

### Key Differences

1. **Metrics**: Identify metric differences
2. **Root Cause**: Find root causes
3. **Impact**: Assess impact
4. **Optimization**: Determine optimizations
5. **Documentation**: Document findings

### Best Practices

1. **Same Conditions**: Test under same conditions
2. **Multiple Runs**: Run multiple tests
3. **Statistical Significance**: Ensure significance
4. **Document**: Document comparisons
5. **Action Items**: Create action items

## Best Practices

1. **Baseline**: Establish baseline
2. **Regular Comparison**: Regular comparisons
3. **Automated**: Automate comparisons
4. **Alert**: Set up alerts for regressions
5. **Document**: Document all comparisons

## Next Steps

- Learn [WebPageTest Best Practices](./WEBPAGETEST-BEST-PRACTICES.md)
- Explore [WebPageTest Metrics](./WEBPAGETEST-METRICS.md)
- Study [Waterfall Analysis](./WATERFALL-ANALYSIS.md)

Comparison tests identify improvements. Master comparisons for better performance.
