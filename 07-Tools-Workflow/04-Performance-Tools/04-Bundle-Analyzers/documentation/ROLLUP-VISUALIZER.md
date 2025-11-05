# Rollup Visualizer

Rollup Visualizer analyzes Rollup bundle output. This guide covers installation, usage, and optimization strategies for Rollup bundles.

## Rollup Visualizer Overview

Rollup Visualizer provides:
- **Bundle Analysis**: Rollup bundle analysis
- **Module Visualization**: Module visualization
- **Size Breakdown**: Size breakdown by module
- **Optimization**: Optimization insights
- **Interactive**: Interactive analysis

## Installation

### Install Package

```bash
npm install --save-dev rollup-plugin-visualizer
```

### Configuration

```javascript
import { visualizer } from 'rollup-plugin-visualizer';

export default {
  plugins: [
    visualizer({
      open: true,
      filename: 'dist/stats.html',
      gzipSize: true,
      brotliSize: true
    })
  ]
};
```

## Usage

### Running Analysis

```bash
npm run build
# Visualizer generates stats.html
```

### Options

- **open**: Open report automatically
- **filename**: Output filename
- **gzipSize**: Include gzip sizes
- **brotliSize**: Include brotli sizes
- **template**: Template type

## Understanding Results

### Visualization

- **Treemap**: Treemap view
- **Sunburst**: Sunburst chart
- **Network**: Network graph
- **Module List**: Module list view
- **Interactive**: Interactive exploration

### Key Metrics

- **Bundle Size**: Total bundle size
- **Module Sizes**: Individual module sizes
- **Gzip Size**: Gzipped size
- **Brotli Size**: Brotli compressed size
- **Module Count**: Module count

## Optimization Strategies

### Reduce Size

1. **Tree Shaking**: Leverage tree shaking
2. **Code Splitting**: Implement code splitting
3. **External Dependencies**: Externalize dependencies
4. **Remove Unused**: Remove unused code
5. **Optimize Imports**: Optimize imports

### Best Practices

1. **Regular Analysis**: Regular bundle analysis
2. **Compare**: Compare before/after
3. **Monitor**: Monitor bundle size
4. **Optimize**: Optimize based on findings
5. **Document**: Document decisions

## Next Steps

- Learn [Source Map Explorer](./SOURCE-MAP-EXPLORER.md)
- Explore [Tree Shaking Analysis](./TREE-SHAKING-ANALYSIS.md)
- Study [Code Splitting Analysis](./CODE-SPLITTING-ANALYSIS.md)

Rollup Visualizer helps optimize bundles. Master visualization for better optimization.
