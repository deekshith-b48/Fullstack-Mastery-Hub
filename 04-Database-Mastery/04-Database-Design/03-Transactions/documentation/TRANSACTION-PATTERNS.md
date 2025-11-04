# Transaction Patterns and Best Practices

## 📚 Overview

Common transaction patterns and best practices for reliable database operations.

## 🔄 Common Patterns

### Unit of Work Pattern

```python
class UnitOfWork:
    def __init__(self):
        self.session = Session()
        self.committed = False
    
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type:
            self.rollback()
        else:
            self.commit()
        self.session.close()
    
    def commit(self):
        self.session.commit()
        self.committed = True
    
    def rollback(self):
        self.session.rollback()

# Usage
with UnitOfWork() as uow:
    user = User(name='John')
    uow.session.add(user)
    # Auto-commit on success, rollback on error
```

### Saga Pattern

```python
# Distributed transaction pattern
def transfer_money(from_account, to_account, amount):
    try:
        # Step 1: Debit
        debit(from_account, amount)
        
        # Step 2: Credit
        credit(to_account, amount)
        
        # Commit
        commit()
    except Exception:
        # Compensate: Reverse operations
        credit(from_account, amount)
        debit(to_account, amount)
        rollback()
```

## 🎯 Best Practices

### Keep Transactions Short

```python
# ✅ Good: Short transaction
def create_user(name, email):
    with transaction():
        user = User(name=name, email=email)
        session.add(user)
        # Commit quickly

# ❌ Bad: Long transaction
def process_order(order_id):
    with transaction():
        # Multiple slow operations
        validate_order()  # Slow
        calculate_taxes()  # Slow
        send_email()  # Slow
        # Transaction held too long
```

### Handle Errors Properly

```python
try:
    with transaction():
        # Operations
        commit()
except DatabaseError:
    rollback()
    raise
except Exception:
    rollback()
    log_error()
    raise
```

### Use Appropriate Isolation Levels

```python
# Read-heavy: Lower isolation
session.execute("SET TRANSACTION ISOLATION LEVEL READ COMMITTED")

# Critical operations: Higher isolation
session.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE")
```

## 🎯 Transaction Checklist

- [ ] Keep transactions short
- [ ] Handle all errors
- [ ] Use appropriate isolation level
- [ ] Test concurrent scenarios
- [ ] Monitor transaction performance
- [ ] Document transaction boundaries

---

**Next**: Continue learning about transactions.

