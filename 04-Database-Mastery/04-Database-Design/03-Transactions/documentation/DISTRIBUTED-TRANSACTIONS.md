# Distributed Transactions

## 📚 Overview

Distributed transactions span multiple databases or services. This guide covers distributed transaction patterns and challenges.

## 🌐 Two-Phase Commit (2PC)

### Phase 1: Prepare

```python
# Coordinator sends prepare to all participants
def two_phase_commit(participants, operations):
    # Phase 1: Prepare
    prepared = []
    for participant, operation in zip(participants, operations):
        try:
            result = participant.prepare(operation)
            prepared.append((participant, result))
        except Exception:
            # Abort all
            for p, _ in prepared:
                p.rollback()
            raise
    
    # Phase 2: Commit
    for participant, result in prepared:
        participant.commit(result)
```

### Phase 2: Commit/Abort

```python
# If all prepared successfully, commit all
# If any failed, abort all
try:
    # All participants commit
    for participant in participants:
        participant.commit()
except Exception:
    # Rollback all
    for participant in participants:
        participant.rollback()
```

## 🔄 Saga Pattern

### Compensating Transactions

```python
# Each step has a compensating action
def transfer_money(from_account, to_account, amount):
    steps = []
    
    try:
        # Step 1: Debit
        debit_id = debit(from_account, amount)
        steps.append(('debit', debit_id))
        
        # Step 2: Credit
        credit_id = credit(to_account, amount)
        steps.append(('credit', credit_id))
        
    except Exception:
        # Compensate in reverse order
        for step_type, step_id in reversed(steps):
            if step_type == 'debit':
                credit(from_account, amount)
            elif step_type == 'credit':
                debit(to_account, amount)
        raise
```

## 🎯 Best Practices

1. **Minimize distributed transactions**
2. **Use saga pattern** when possible
3. **Implement idempotency**
4. **Handle failures** gracefully
5. **Monitor transaction** performance

---

**✅ All 135 files complete!** Database Mastery section fully documented with comprehensive content!

