# WebPageTest Metrics

WebPageTest provides comprehensive performance metrics. This guide covers key metrics, interpretation, and optimization strategies.

## Key Metrics

### Load Time

- **Definition**: Total page load time
- **Target**: < 3 seconds
- **Measurement**: From request to complete load
- **Optimization**: Optimize resource loading

### Time to First Byte (TTFB)

- **Definition**: Server response time
- **Target**: < 200 milliseconds
- **Measurement**: Time until first byte received
- **Optimization**: Improve server performance

### Start Render

- **Definition**: First visual content
- **Target**: < 1 second
- **Measurement**: First pixels rendered
- **Optimization**: Optimize critical rendering path

### Speed Index

- **Definition**: Visual load speed
- **Target**: < 3.4 seconds
- **Measurement**: Visual completeness over time
- **Optimization**: Optimize above-the-fold content

### Total Requests

- **Definition**: Number of HTTP requests
- **Target**: Minimize requests
- **Measurement**: All resource requests
- **Optimization**: Combine resources

## Advanced Metrics

### Document Complete

- **Measures**: Document completion time
- **Includes**: All resources loaded
- **Optimization**: Optimize resource loading

### Fully Loaded

- **Measures**: Complete page load
- **Includes**: All activity complete
- **Optimization**: Optimize all resources

### First Contentful Paint

- **Measures**: First content paint
- **Target**: < 1.8 seconds
- **Optimization**: Optimize critical path

## Optimization Strategies

### TTFB Optimization

1. **Server Performance**: Improve server performance
2. **CDN**: Use CDN
3. **Caching**: Implement caching
4. **Database**: Optimize database queries
5. **Response Compression**: Enable compression

### Load Time Optimization

1. **Resource Optimization**: Optimize resources
2. **Parallel Loading**: Enable parallel loading
3. **Caching**: Implement caching
4. **CDN**: Use CDN
5. **Minification**: Minify resources

## Best Practices

1. **Monitor Metrics**: Regularly monitor metrics
2. **Set Targets**: Set performance targets
3. **Optimize Continuously**: Continuous optimization
4. **Compare**: Compare before/after
5. **Document**: Document improvements

## Next Steps

- Learn [WebPageTest Locations](./WEBPAGETEST-LOCATIONS.md)
- Explore [Waterfall Analysis](./WATERFALL-ANALYSIS.md)
- Study [Filmstrip View](./FILMSTRIP-VIEW.md)

Understanding metrics improves performance. Master WebPageTest metrics for better results.
