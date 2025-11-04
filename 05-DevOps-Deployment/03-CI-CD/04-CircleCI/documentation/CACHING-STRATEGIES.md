# CircleCI Caching Strategies

## 📚 Overview

Caching in CircleCI can significantly speed up builds by storing and reusing dependencies, build artifacts, and other frequently used data.

## 🎯 Caching Fundamentals

### What is Caching?

Caching allows you to store files that can be reused across builds. This includes dependencies, build artifacts, and other data.

### Benefits

- **Faster Builds**: Reduce build times
- **Cost Savings**: Fewer compute minutes
- **Efficiency**: Reuse dependencies
- **Reliability**: Consistent builds

## 🚀 Basic Caching

### Cache Dependencies

```yaml
steps:
  - restore_cache:
      keys:
        - v1-dependencies-{{ checksum "package-lock.json" }}
        - v1-dependencies-
  
  - run: npm install
  
  - save_cache:
      paths:
        - node_modules
      key: v1-dependencies-{{ checksum "package-lock.json" }}
```

### Cache Keys

```yaml
restore_cache:
  keys:
    - v1-dependencies-{{ checksum "package-lock.json" }}
    - v1-dependencies-{{ checksum "package.json" }}
    - v1-dependencies-
```

## 🔧 Advanced Caching

### Multiple Caches

```yaml
steps:
  - restore_cache:
      keys:
        - v1-npm-{{ checksum "package-lock.json" }}
        - v1-npm-
  
  - restore_cache:
      keys:
        - v1-pip-{{ checksum "requirements.txt" }}
        - v1-pip-
  
  - run: npm install
  - run: pip install -r requirements.txt
  
  - save_cache:
      paths:
        - node_modules
      key: v1-npm-{{ checksum "package-lock.json" }}
  
  - save_cache:
      paths:
        - ~/.cache/pip
      key: v1-pip-{{ checksum "requirements.txt" }}
```

### Cache Invalidation

```yaml
# Change cache key version to invalidate
restore_cache:
  keys:
    - v2-dependencies-{{ checksum "package-lock.json" }}  # Changed from v1
```

## 📊 Caching Best Practices

### Key Strategy

```yaml
# Use checksums for exact matches
# Use fallback keys for partial matches
restore_cache:
  keys:
    - v1-deps-{{ checksum "package-lock.json" }}
    - v1-deps-  # Fallback
```

## 🎯 Best Practices

1. **Key Strategy**: Use appropriate cache keys
2. **Fallback Keys**: Use fallback keys
3. **Cache Scope**: Scope caches appropriately
4. **Invalidation**: Invalidate when needed
5. **Monitoring**: Monitor cache hit rates
6. **Optimization**: Optimize cache usage
7. **Documentation**: Document cache strategies

## 🎓 Learning Resources

- Caching: https://circleci.com/docs/caching/
- Cache Strategies: https://circleci.com/docs/caching/#best-practices
- Optimization: https://circleci.com/docs/caching/#optimizing-caches

---

**Next**: Learn about [Security Features](./SECURITY-FEATURES.md)

