# TypeORM Migrations & CLI

## 📚 Overview

TypeORM migrations manage database schema changes over time, while the CLI provides commands for migration management.

## 🔧 CLI Setup

### Install CLI

```bash
# Install TypeORM CLI globally
npm install -g typeorm

# Or use npx
npx typeorm
```

### Configuration

```json
// ormconfig.json
{
  "type": "postgres",
  "host": "localhost",
  "port": 5432,
  "username": "postgres",
  "password": "password",
  "database": "myapp",
  "entities": ["src/**/*.entity{.ts,.js}"],
  "migrations": ["src/migrations/**/*{.ts,.js}"],
  "cli": {
    "migrationsDir": "src/migrations"
  }
}
```

## 📝 Creating Migrations

### Generate Migration

```bash
# Generate migration
typeorm migration:generate -n CreateUsers

# Create empty migration
typeorm migration:create -n CreateUsers
```

### Migration File

```typescript
// migrations/1234567890-CreateUsers.ts
import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateUsers1234567890 implements MigrationInterface {
    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            CREATE TABLE "users" (
                "id" SERIAL NOT NULL,
                "firstName" character varying NOT NULL,
                "lastName" character varying NOT NULL,
                "email" character varying NOT NULL,
                CONSTRAINT "PK_users" PRIMARY KEY ("id")
            )
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "users"`);
    }
}
```

## 🔄 Running Migrations

```bash
# Run migrations
typeorm migration:run

# Revert last migration
typeorm migration:revert

# Show migration status
typeorm migration:show
```

## 🎯 Best Practices

1. **Version control migrations**
2. **Test migrations** before production
3. **Keep migrations reversible**
4. **Document schema changes**
5. **Run migrations in order**

---

**Next**: Learn about [Query Builder](./QUERY-BUILDER.md)

