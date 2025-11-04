# Python Deployment

## 📚 Overview

Deploying Python applications to production.

## 🚀 Gunicorn

```bash
# Install
pip install gunicorn

# Run
gunicorn -w 4 -b 0.0.0.0:8000 app:app
```

## 🐳 Docker

```dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
```

## ☁️ Cloud Platforms

### Heroku

```bash
# Procfile
web: gunicorn app:app

# Deploy
git push heroku main
```

### AWS Elastic Beanstalk

```bash
eb init
eb create
eb deploy
```

---

**Next**: Learn about [Python Security](./PYTHON-SECURITY.md)

