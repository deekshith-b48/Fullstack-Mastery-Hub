# Python Package Management

## 📚 Overview

Managing Python packages and dependencies effectively.

## 📦 pip

```bash
# Install package
pip install package-name

# Install from requirements
pip install -r requirements.txt

# List installed packages
pip list

# Freeze dependencies
pip freeze > requirements.txt

# Uninstall
pip uninstall package-name
```

## 📝 requirements.txt

```txt
Flask==2.0.1
requests>=2.25.0
numpy~=1.20.0
```

## 🔧 setup.py

```python
from setuptools import setup, find_packages

setup(
    name="my-package",
    version="1.0.0",
    packages=find_packages(),
    install_requires=[
        "requests>=2.25.0",
    ],
)
```

## 🐍 Poetry

```bash
# Install
pip install poetry

# Initialize
poetry init

# Install dependencies
poetry install

# Add package
poetry add requests

# Update
poetry update
```

---

**Next**: Learn about [Python Testing](./PYTHON-TESTING.md)

