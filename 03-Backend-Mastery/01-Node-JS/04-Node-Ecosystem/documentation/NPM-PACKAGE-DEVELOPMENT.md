# NPM Package Development

## 📚 Overview

Creating and publishing npm packages enables code reuse and sharing.

## 📦 Package Structure

```
my-package/
├── package.json
├── README.md
├── index.js
├── lib/
│   └── utils.js
└── tests/
    └── test.js
```

## 📝 package.json

```json
{
  "name": "my-package",
  "version": "1.0.0",
  "description": "My awesome package",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "build": "babel src -d lib"
  },
  "keywords": ["nodejs", "utility"],
  "author": "Your Name",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/username/my-package"
  },
  "dependencies": {
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "jest": "^27.0.0"
  }
}
```

## 🚀 Publishing

```bash
# Login to npm
npm login

# Publish
npm publish

# Publish beta version
npm publish --tag beta

# Update version
npm version patch  # 1.0.0 -> 1.0.1
npm version minor   # 1.0.0 -> 1.1.0
npm version major   # 1.0.0 -> 2.0.0
```

---

**Next**: Learn about [Node.js Best Practices](./NODE-BEST-PRACTICES.md)

