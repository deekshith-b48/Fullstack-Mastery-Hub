# Source Map Explorer

Source Map Explorer analyzes bundle sizes using source maps. This guide covers installation, usage, and optimization strategies.

## Source Map Explorer Overview

Source Map Explorer provides:
- **Source Map Analysis**: Analyze using source maps
- **Size Breakdown**: Size breakdown by source files
- **Duplicate Detection**: Duplicate code detection
- **Optimization**: Optimization insights
- **CLI Tool**: Command-line tool

## Installation

### Install Package

```bash
npm install --save-dev source-map-explorer
```

## Usage

### Basic Usage

```bash
source-map-explorer 'dist/*.js'
```

### Generate Report

```bash
source-map-explorer 'dist/*.js' --html bundle-report.html
```

### Options

- **--html**: Generate HTML report
- **--json**: Generate JSON output
- **--tsv**: Generate TSV output
- **--only-mapped**: Only show mapped files
- **--gzip**: Show gzip sizes

## Understanding Results

### Size Breakdown

- **File Sizes**: Size by source file
- **Total Size**: Total bundle size
- **Largest Files**: Largest contributing files
- **Duplicate Code**: Duplicate code detection
- **Visualization**: Visual representation

### Analysis

- **Source Files**: Original source files
- **Size Contribution**: Size contribution per file
- **Dependencies**: Dependency analysis
- **Optimization**: Optimization opportunities
- **Trends**: Size trends

## Optimization Strategies

### Reduce Size

1. **Identify Large Files**: Identify large files
2. **Code Splitting**: Split large files
3. **Remove Duplicates**: Remove duplicate code
4. **Optimize Imports**: Optimize imports
5. **Tree Shaking**: Enable tree shaking

### Best Practices

1. **Regular Analysis**: Regular analysis
2. **Compare**: Compare builds
3. **Monitor**: Monitor size trends
4. **Optimize**: Optimize based on findings
5. **Document**: Document optimization

## Next Steps

- Learn [Bundle Budgets](./BUNDLE-BUDGETS.md)
- Explore [Tree Shaking Analysis](./TREE-SHAKING-ANALYSIS.md)
- Study [Code Splitting Analysis](./CODE-SPLITTING-ANALYSIS.md)

Source Map Explorer provides detailed insights. Master analysis for better optimization.
