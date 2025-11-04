# Node.js Deployment Strategies

## 📚 Overview

Deployment strategies ensure reliable and scalable application deployment.

## 🚀 Deployment Options

### 1. PM2 Process Manager

```bash
# Install PM2
npm install -g pm2

# Start application
pm2 start app.js

# Start with ecosystem file
pm2 start ecosystem.config.js

# Monitor
pm2 monit

# Logs
pm2 logs

# Restart
pm2 restart app

# Stop
pm2 stop app
```

### 2. Docker Deployment

```dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]
```

### 3. Cloud Platforms

#### Heroku

```bash
# Deploy to Heroku
heroku create
git push heroku main
```

#### AWS Elastic Beanstalk

```bash
eb init
eb create
eb deploy
```

#### Vercel/Netlify

```bash
# For serverless functions
vercel deploy
```

---

**Next**: Learn about [Monitoring & Logging](./MONITORING-LOGGING.md)

