# FastAPI Background Tasks

## 📚 Overview

Background tasks run after the response is sent.

## 🎯 Background Tasks

```python
from fastapi import BackgroundTasks

def send_email(email: str, message: str):
    # Send email
    print(f"Sending email to {email}: {message}")

@app.post("/send-notification")
def send_notification(
    email: str,
    message: str,
    background_tasks: BackgroundTasks
):
    background_tasks.add_task(send_email, email, message)
    return {"message": "Notification sent"}
```

## 🔄 Celery Integration

```python
from celery import Celery

celery_app = Celery("tasks", broker="redis://localhost:6379")

@celery_app.task
def process_data(data):
    # Process data
    return result

@app.post("/process")
def process(data: dict):
    task = process_data.delay(data)
    return {"task_id": task.id}
```

---

**Next**: Learn about [WebSockets](./WEBSOCKETS-FASTAPI.md)

