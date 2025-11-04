# GitHub Actions Matrix Strategies

## 📚 Overview

Matrix strategies allow you to run a job with multiple configurations. This is useful for testing across different operating systems, languages, or versions.

## 🎯 Matrix Fundamentals

### What is a Matrix?

A matrix strategy creates multiple job instances by combining different values. Each combination runs as a separate job.

### Benefits

- **Parallel Testing**: Test multiple configurations
- **Efficiency**: Run tests in parallel
- **Coverage**: Test across environments
- **Flexibility**: Easy to add new configurations

## 🚀 Basic Matrix

### Simple Matrix

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [14, 16, 18]
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

### Multiple Dimensions

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [14, 16, 18]
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

## 🔧 Advanced Matrix

### Include/Exclude

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node-version: [14, 16, 18]
        include:
          - os: ubuntu-latest
            node-version: 20
            experimental: true
        exclude:
          - os: windows-latest
            node-version: 14
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

### Dynamic Matrix

```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}
    steps:
      - id: set-matrix
        run: |
          echo '::set-output name=matrix::{"node":[14,16,18]}'
  
  test:
    needs: setup
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: ${{ fromJson(needs.setup.outputs.matrix).node }}
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

## 📊 Matrix Examples

### Testing Multiple Versions

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.9', '3.10', '3.11']
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}
      - run: pytest
```

### Cross-Platform Testing

```yaml
jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        build-type: [Debug, Release]
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: |
          cmake -DCMAKE_BUILD_TYPE=${{ matrix.build-type }} .
          cmake --build .
```

## 🎯 Best Practices

1. **Efficiency**: Use matrix for parallel execution
2. **Coverage**: Test across environments
3. **Optimization**: Exclude unnecessary combinations
4. **Documentation**: Document matrix configurations
5. **Maintenance**: Keep matrix updated
6. **Performance**: Balance matrix size
7. **Testing**: Test matrix configurations

## 🎓 Learning Resources

- Matrix Strategies: https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs
- Matrix Examples: https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs#examples
- Workflows: https://docs.github.com/en/actions/using-workflows

---

**Next**: Learn about [Caching Optimization](./CACHING-OPTIMIZATION.md)

