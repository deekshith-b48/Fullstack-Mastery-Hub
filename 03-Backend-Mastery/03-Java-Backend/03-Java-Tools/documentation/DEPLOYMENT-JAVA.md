# Java Deployment

## 📚 Overview

Deploying Java applications to production.

## 🐳 Docker

```dockerfile
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/myapp.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
```

## ☁️ Cloud Platforms

### AWS Elastic Beanstalk

```bash
eb init
eb create
eb deploy
```

### Heroku

```bash
# Procfile
web: java -jar target/myapp.jar

# Deploy
git push heroku main
```

---

**Next**: Learn about [Monitoring Java](./MONITORING-JAVA.md)

