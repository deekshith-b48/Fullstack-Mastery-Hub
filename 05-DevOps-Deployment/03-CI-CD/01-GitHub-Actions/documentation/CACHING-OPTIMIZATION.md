# GitHub Actions Caching Optimization

## 📚 Overview

Caching in GitHub Actions can significantly speed up workflows by storing and reusing dependencies and build artifacts. Proper caching strategies can reduce build times dramatically.

## 🎯 Caching Fundamentals

### What is Caching?

Caching allows you to store files that can be reused across workflow runs. This includes dependencies, build artifacts, and other frequently used data.

### Benefits

- **Faster Builds**: Reduce build times
- **Cost Savings**: Fewer compute minutes
- **Efficiency**: Reuse dependencies
- **Reliability**: Consistent builds

## 🚀 Basic Caching

### Cache Action

```yaml
steps:
  - uses: actions/checkout@v3
  
  - name: Cache dependencies
    uses: actions/cache@v3
    with:
      path: node_modules
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-
  
  - name: Install dependencies
    run: npm install
```

### Cache Key

```yaml
steps:
  - uses: actions/cache@v3
    with:
      path: |
        node_modules
        dist
      key: ${{ runner.os }}-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-
```

## 🔧 Advanced Caching

### Multiple Caches

```yaml
steps:
  - name: Cache npm
    uses: actions/cache@v3
    with:
      path: ~/.npm
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
  
  - name: Cache pip
    uses: actions/cache@v3
    with:
      path: ~/.cache/pip
      key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
```

### Cache Invalidation

```yaml
steps:
  - name: Cache with version
    uses: actions/cache@v3
    with:
      path: node_modules
      key: ${{ runner.os }}-node-v2-${{ hashFiles('**/package-lock.json') }}
```

## 📊 Caching Strategies

### Dependency Caching

```yaml
steps:
  - uses: actions/checkout@v3
  
  - name: Cache node modules
    uses: actions/cache@v3
    id: cache-node-modules
    with:
      path: node_modules
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
  
  - name: Install dependencies
    if: steps.cache-node-modules.outputs.cache-hit != 'true'
    run: npm install
```

### Build Artifact Caching

```yaml
steps:
  - name: Cache build artifacts
    uses: actions/cache@v3
    with:
      path: dist
      key: ${{ runner.os }}-build-${{ github.sha }}
      restore-keys: |
        ${{ runner.os }}-build-
```

## 🎯 Best Practices

1. **Key Strategy**: Use appropriate cache keys
2. **Restore Keys**: Use restore keys for fallback
3. **Cache Scope**: Scope caches appropriately
4. **Invalidation**: Invalidate when needed
5. **Monitoring**: Monitor cache hit rates
6. **Optimization**: Optimize cache usage
7. **Documentation**: Document cache strategies

## 🎓 Learning Resources

- Caching: https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows
- Cache Action: https://github.com/actions/cache
- Optimization: https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows#optimization-examples

---

**Next**: Learn about [Advanced Workflows](./ADVANCED-WORKFLOWS.md)

