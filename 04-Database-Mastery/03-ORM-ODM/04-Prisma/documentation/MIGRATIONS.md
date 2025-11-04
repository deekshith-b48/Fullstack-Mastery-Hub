# Prisma Migrations

## 📚 Overview

Prisma Migrations manage database schema changes over time, providing version control for your database schema.

## 🔧 Migration Commands

### Create Migration

```bash
# Create migration
npx prisma migrate dev --name create_users

# Create and apply migration
npx prisma migrate dev

# Create migration without applying
npx prisma migrate dev --create-only
```

### Apply Migrations

```bash
# Apply pending migrations
npx prisma migrate deploy

# Reset database
npx prisma migrate reset
```

### Migration Status

```bash
# Check migration status
npx prisma migrate status
```

## 📝 Migration Files

### Auto-Generated Migration

```sql
-- migrations/20240101000000_create_users/migration.sql
-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
```

### Custom Migration

```sql
-- You can add custom SQL to migrations
-- Custom SQL
ALTER TABLE "User" ADD COLUMN "customField" TEXT;
```

## 🔄 Migration Workflow

1. **Update schema**: Modify `schema.prisma`
2. **Create migration**: `npx prisma migrate dev`
3. **Review migration**: Check generated SQL
4. **Apply migration**: Automatically applied in dev
5. **Deploy**: `npx prisma migrate deploy` in production

## 🎯 Best Practices

1. **Review migrations** before applying
2. **Test migrations** in development
3. **Backup database** before migrations
4. **Version control migrations**
5. **Document schema changes**

---

**Next**: Learn about [Queries & Filters](./QUERIES-FILTERS.md)

