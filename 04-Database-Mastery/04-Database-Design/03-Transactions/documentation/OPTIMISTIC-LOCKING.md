# Optimistic Locking

## 📚 Overview

Optimistic locking assumes conflicts are rare and checks for conflicts only when committing. This guide covers optimistic locking strategies.

## 🔄 Optimistic Locking Pattern

### Version-Based Locking

```sql
-- Add version column
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    version INT DEFAULT 0
);

-- Update with version check
UPDATE products 
SET price = 100, version = version + 1
WHERE id = 1 AND version = 5;

-- If version changed, update fails (0 rows affected)
```

### Timestamp-Based Locking

```sql
-- Add updated_at column
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Update with timestamp check
UPDATE products 
SET price = 100, updated_at = CURRENT_TIMESTAMP
WHERE id = 1 AND updated_at = '2024-01-15 10:00:00';
```

## 💻 Application Implementation

### Python Example

```python
from sqlalchemy import Column, Integer, DateTime
from datetime import datetime

class Product(Base):
    __tablename__ = 'products'
    
    id = Column(Integer, primary_key=True)
    price = Column(Numeric)
    version = Column(Integer, default=0)
    
    def update_price(self, new_price, expected_version):
        if self.version != expected_version:
            raise OptimisticLockError("Version mismatch")
        
        self.price = new_price
        self.version += 1
        session.commit()
```

### JavaScript Example

```javascript
// Check version before update
async function updateProduct(productId, newPrice, expectedVersion) {
    const result = await db.query(
        'UPDATE products SET price = $1, version = version + 1 WHERE id = $2 AND version = $3',
        [newPrice, productId, expectedVersion]
    );
    
    if (result.rowCount === 0) {
        throw new Error('Optimistic lock failed - version mismatch');
    }
}
```

## 🔄 Handling Conflicts

### Retry Strategy

```python
def update_with_retry(product_id, new_price, max_retries=3):
    for attempt in range(max_retries):
        try:
            # Fetch current version
            product = session.query(Product).get(product_id)
            current_version = product.version
            
            # Update
            product.update_price(new_price, current_version)
            return
        except OptimisticLockError:
            if attempt < max_retries - 1:
                time.sleep(0.1)
                continue
            else:
                raise
```

## 🎯 Best Practices

1. **Use for low-contention scenarios**
2. **Handle conflicts gracefully**
3. **Implement retry logic**
4. **Monitor conflict frequency**
5. **Consider pessimistic locking** for high contention

---

**Next**: Continue learning about transactions.

