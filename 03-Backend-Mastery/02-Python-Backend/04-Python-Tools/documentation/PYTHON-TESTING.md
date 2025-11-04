# Python Testing

## 📚 Overview

Testing Python applications ensures code quality and reliability.

## 🧪 unittest

```python
import unittest

class TestMath(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(1, 2), 3)
    
    def test_subtract(self):
        self.assertEqual(subtract(2, 1), 1)

if __name__ == '__main__':
    unittest.main()
```

## 🎯 pytest

```python
# test_math.py
def test_add():
    assert add(1, 2) == 3

def test_subtract():
    assert subtract(2, 1) == 1

# Run: pytest
```

## 🔄 Fixtures

```python
import pytest

@pytest.fixture
def user():
    return User(name="John", email="john@example.com")

def test_user_name(user):
    assert user.name == "John"
```

---

**Next**: Learn about [Deployment](./DEPLOYMENT-PYTHON.md)

