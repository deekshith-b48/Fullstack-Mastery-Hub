# SQLAlchemy Migrations with Alembic

## 📚 Overview

Alembic is SQLAlchemy's database migration tool, providing version control for database schema.

## 🚀 Installation

```bash
# Install Alembic
pip install alembic
```

## 🔧 Setup

### Initialize Alembic

```bash
# Initialize Alembic
alembic init alembic
```

### Configuration

```python
# alembic/env.py
from models import Base
target_metadata = Base.metadata
```

## 📝 Creating Migrations

### Generate Migration

```bash
# Auto-generate migration
alembic revision --autogenerate -m "create users table"

# Create empty migration
alembic revision -m "add email column"
```

### Migration File

```python
# alembic/versions/xxx_create_users.py
def upgrade():
    op.create_table(
        'users',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('email', sa.String(255), nullable=False),
        sa.Column('name', sa.String(100), nullable=True),
        sa.PrimaryKeyConstraint('id')
    )

def downgrade():
    op.drop_table('users')
```

## 🔄 Running Migrations

```bash
# Apply migrations
alembic upgrade head

# Revert migration
alembic downgrade -1

# Show current revision
alembic current

# Show migration history
alembic history
```

## 🎯 Best Practices

1. **Review migrations** before applying
2. **Test migrations** in development
3. **Backup database** before migrations
4. **Version control migrations**
5. **Document schema changes**

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

