# Python Virtual Environments

## 📚 Overview

Virtual environments isolate Python dependencies for different projects.

## 🎯 venv (Built-in)

```bash
# Create virtual environment
python -m venv venv

# Activate (Linux/Mac)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Deactivate
deactivate
```

## 🐍 virtualenv

```bash
# Install
pip install virtualenv

# Create
virtualenv myenv

# Activate
source myenv/bin/activate
```

## 📦 pipenv

```bash
# Install
pip install pipenv

# Create and install dependencies
pipenv install

# Install package
pipenv install requests

# Activate shell
pipenv shell

# Run command
pipenv run python app.py
```

## 🔧 conda

```bash
# Create environment
conda create -n myenv python=3.9

# Activate
conda activate myenv

# Install package
conda install numpy

# Deactivate
conda deactivate
```

---

**Next**: Learn about [Package Management](./PACKAGE-MANAGEMENT.md)

