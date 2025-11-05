# Core Web Vitals

Core Web Vitals are key user experience metrics. This guide covers LCP, FID, CLS, measurement, and optimization strategies.

## Core Web Vitals Overview

Core Web Vitals measure:
- **Loading Performance**: LCP
- **Interactivity**: FID
- **Visual Stability**: CLS

## Largest Contentful Paint (LCP)

### Definition

LCP measures loading performance:
- **Metric**: Time to render largest content
- **Target**: < 2.5 seconds
- **Measurement**: Largest image, video, or text block

### Optimization

1. **Optimize Images**: Optimize largest images
2. **Preload Resources**: Preload critical resources
3. **Server Response**: Improve server response time
4. **CDN**: Use CDN for assets
5. **Caching**: Implement caching

## First Input Delay (FID)

### Definition

FID measures interactivity:
- **Metric**: Time to first interaction
- **Target**: < 100 milliseconds
- **Measurement**: Delay before user interaction response

### Optimization

1. **Reduce JavaScript**: Minimize JavaScript execution
2. **Code Splitting**: Split JavaScript code
3. **Defer Scripts**: Defer non-critical scripts
4. **Web Workers**: Use web workers
5. **Optimize Third-Party**: Optimize third-party scripts

## Cumulative Layout Shift (CLS)

### Definition

CLS measures visual stability:
- **Metric**: Layout shift score
- **Target**: < 0.1
- **Measurement**: Unexpected layout shifts

### Optimization

1. **Image Dimensions**: Set image dimensions
2. **Font Loading**: Optimize font loading
3. **Ads**: Reserve space for ads
4. **Animations**: Avoid unexpected shifts
5. **Dynamic Content**: Reserve space for dynamic content

## Measurement

### Tools

- **Lighthouse**: Lighthouse audits
- **Chrome DevTools**: Performance panel
- **PageSpeed Insights**: PageSpeed Insights
- **Web Vitals Extension**: Chrome extension
- **Real User Monitoring**: RUM tools

### Best Practices

1. **Measure Regularly**: Regular measurement
2. **Real Users**: Measure real user metrics
3. **Multiple Devices**: Test on multiple devices
4. **Monitor Trends**: Track trends over time
5. **Set Goals**: Set performance goals

## Next Steps

- Learn [Lighthouse Scoring](./LIGHTHOUSE-SCORING.md)
- Explore [Lighthouse Optimization](./LIGHTHOUSE-OPTIMIZATION.md)
- Study [Lighthouse Metrics](./LIGHTHOUSE-METRICS.md)

Core Web Vitals impact user experience. Master optimization for better results.
