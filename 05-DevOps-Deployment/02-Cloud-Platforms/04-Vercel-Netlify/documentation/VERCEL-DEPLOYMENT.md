# Vercel Deployment

## 📚 Overview

Vercel is a cloud platform for frontend frameworks and static sites. It provides instant deployments, automatic HTTPS, and global CDN for optimal performance.

## 🎯 What is Vercel?

Vercel is a deployment platform optimized for frontend frameworks like Next.js, React, Vue, and Angular. It offers zero-configuration deployments, automatic scaling, and built-in performance optimizations.

### Key Features

- **Instant Deployments**: Deploy in seconds
- **Automatic HTTPS**: SSL certificates included
- **Global CDN**: Content delivered worldwide
- **Serverless Functions**: API routes supported
- **Preview Deployments**: Branch previews
- **Analytics**: Built-in analytics

## 🚀 Getting Started

### Installation

```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Verify installation
vercel --version
```

### Deploy Project

```bash
# Deploy current directory
vercel

# Deploy with production flag
vercel --prod

# Deploy specific directory
vercel ./my-project

# Deploy with custom name
vercel --name my-project
```

## 🔧 Configuration

### vercel.json

```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
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
        }
      ]
    }
  ]
}
```

### Environment Variables

```bash
# Set environment variable
vercel env add VARIABLE_NAME

# List environment variables
vercel env ls

# Remove environment variable
vercel env rm VARIABLE_NAME production
```

## 🔄 Deployment Workflow

### Git Integration

```bash
# Connect Git repository
# Automatic deployments on push

# Preview deployments for PRs
# Production deployments on main branch
```

### Manual Deployment

```bash
# Deploy from CLI
vercel

# Deploy to production
vercel --prod

# Deploy with custom configuration
vercel --build-env NODE_ENV=production
```

## 🌐 Custom Domains

### Add Domain

```bash
# Add custom domain
vercel domains add example.com

# Verify domain
# Add DNS records as instructed

# List domains
vercel domains ls
```

### SSL Certificates

```bash
# SSL automatically provisioned
# Wildcard certificates supported
```

## 🔧 Serverless Functions

### API Routes

```javascript
// api/hello.js (Next.js)
export default function handler(req, res) {
  res.status(200).json({ message: 'Hello from Vercel!' });
}

// api/users/[id].js
export default function handler(req, res) {
  const { id } = req.query;
  res.status(200).json({ id, name: 'User' });
}
```

### Function Configuration

```json
{
  "functions": {
    "api/**/*.js": {
      "maxDuration": 10
    }
  }
}
```

## 📊 Monitoring

### Analytics

```bash
# Enable Vercel Analytics
# View in Vercel dashboard

# Real-time analytics
# Performance metrics
```

### Logs

```bash
# View deployment logs
vercel logs

# View function logs
vercel logs --follow
```

## 🎯 Best Practices

1. **Framework Optimization**: Use supported frameworks
2. **Environment Variables**: Secure sensitive data
3. **Custom Domains**: Use custom domains
4. **Performance**: Optimize images and assets
5. **Preview Deployments**: Test before production
6. **Monitoring**: Use analytics and logs
7. **Security**: Enable security headers

## 🎓 Learning Resources

- Vercel Documentation: https://vercel.com/docs
- Deployment Guide: https://vercel.com/docs/deployments
- Vercel: https://vercel.com

---

**Next**: Learn about [Netlify Deployment](./NETLIFY-DEPLOYMENT.md)

