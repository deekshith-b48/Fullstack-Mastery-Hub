# Static Site Deployment

## 📚 Overview

Static site deployment involves hosting pre-built HTML, CSS, and JavaScript files on a CDN or hosting service. Modern platforms like Vercel and Netlify make static site deployment simple and efficient.

## 🎯 Static Site Fundamentals

### What are Static Sites?

Static sites are websites built with HTML, CSS, and JavaScript that don't require server-side processing. All pages are pre-rendered and served as static files.

### Benefits

- **Performance**: Fast loading times
- **Security**: No server-side vulnerabilities
- **Scalability**: Easy to scale
- **Cost**: Low hosting costs
- **SEO**: Good for search engines

## 🚀 Deployment Strategies

### Vercel Deployment

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy static site
vercel

# Deploy with production flag
vercel --prod

# Configure vercel.json
```

```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### Netlify Deployment

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy static site
netlify deploy

# Deploy to production
netlify deploy --prod
```

```toml
[build]
  publish = "dist"
  command = "npm run build"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

## 📦 Build Configuration

### Build Scripts

```json
{
  "scripts": {
    "build": "npm run build:html && npm run build:css && npm run build:js",
    "build:html": "node scripts/build-html.js",
    "build:css": "sass src/styles:dist/styles",
    "build:js": "webpack --mode production"
  }
}
```

### Build Tools

- **Webpack**: Module bundler
- **Parcel**: Zero-config bundler
- **Rollup**: ES module bundler
- **Vite**: Fast build tool

## 🌐 CDN Configuration

### Cache Headers

```json
{
  "headers": [
    {
      "source": "/assets/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=0, must-revalidate"
        }
      ]
    }
  ]
}
```

### Compression

```bash
# Enable gzip compression
# Configure in platform settings

# Brotli compression
# Automatic on most platforms
```

## 🔄 Continuous Deployment

### GitHub Integration

```yaml
# .github/workflows/deploy.yml
name: Deploy Static Site

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm install
      - name: Build
        run: npm run build
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

## 🔐 Security

### Security Headers

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        },
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains"
        }
      ]
    }
  ]
}
```

### HTTPS

```bash
# Automatic HTTPS
# SSL certificates provided by platform

# Redirect HTTP to HTTPS
# Configure in platform settings
```

## 📊 Performance Optimization

### Image Optimization

```bash
# Use optimized images
# WebP format
# Lazy loading
# Responsive images
```

### Code Splitting

```javascript
// Dynamic imports
const module = await import('./module.js');

// Route-based splitting
const Home = lazy(() => import('./Home.js'));
```

### Minification

```bash
# CSS minification
# JavaScript minification
# HTML minification
# Automatic on most platforms
```

## 🎯 Best Practices

1. **Build Optimization**: Optimize build process
2. **Asset Optimization**: Compress images and assets
3. **Caching**: Configure appropriate cache headers
4. **Security**: Enable security headers
5. **Monitoring**: Monitor performance metrics
6. **Testing**: Test before deployment
7. **Documentation**: Document deployment process

## 🎓 Learning Resources

- Static Site Generators: https://www.staticgen.com/
- Deployment Best Practices: https://web.dev/deploy/
- Static Sites: https://jamstack.org/

---

**Next**: Learn about [Serverless Functions](./SERVERLESS-FUNCTIONS.md)

