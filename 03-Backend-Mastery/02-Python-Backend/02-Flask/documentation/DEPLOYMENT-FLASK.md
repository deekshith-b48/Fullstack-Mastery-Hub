# Flask Deployment

## 📚 Overview

Deploying Flask applications to production.

## 🚀 Gunicorn

```bash
# Install
pip install gunicorn

# Run
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

## 🐳 Docker

```dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
```

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

